import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pbl6/config/value.dart';
import 'package:pbl6/models/cart.dart';

class RepositoryCart {
  Future<bool> addProductToCart(String userID, String productID,
      String productCount, String description) async {
    String uri = '${iPURL}api/Cart/AddProductToCart';
    final response = await http.post(
      Uri.parse(uri),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, String>{
        'userID': userID,
        'productID': productID,
        'productCount': productCount,
        'description': description
      }),
    );

    final data = jsonDecode(response.body);
    if (data['isSuccess'] == true) {
      return true;
    } else {
      return false;
    }
  }

  Future getCartItemByUserId(String idUser) async {
    String uri = '${iPURL}api/Cart/GetCartItemsByUserID?id=$idUser';
    try {
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Iterable it = data['Data'];
        List<Cart> list = it.map((e) => Cart.fromJson(e)).toList();
        return list;
      }
      return [];
    } catch (e) {
      return;
    }
  }

  Future deleteCartItemByID(int id) async {
    String uri = '${iPURL}api/Cart/DeleteCartItemByID?id=$id';
    try {
      final response = await http.delete(
        Uri.parse(uri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken'
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['isSuccess'];
      }
    } catch (e) {
      return 'fail';
    }
  }

  Future editCartItem(int id, int productCount, String description) async {
    String uri = '${iPURL}api/Cart/EditCartItem';
    try {
      final response = await http.put(
        Uri.parse(uri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken'
        },
        body: jsonEncode(<String, String>{
          'id': id.toString(),
          'productCount': productCount.toString(),
          'description': description
        }),
      );
      final data = jsonDecode(response.body);
      if (data['isSuccess']) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return;
    }
  }

  Future onPayment(
      int idUser, List<int> idCarts, String address, double shippingFee) async {
    String uri = '${iPURL}api/Cart/OnPayment';
    Map<String, String> header = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      final request = await http.MultipartRequest('POST', Uri.parse(uri));
      request.headers.addAll(header);

      request.fields['userID'] = idUser.toString();
      for (int i = 0; i < idCarts.length; i++) {
        request.fields.addAll({
          'cartItemsID[$i]': idCarts[i].toString(),
        });
      }
      request.fields['Address'] = address;
      request.fields['ShippingFee'] = shippingFee.toString();
      var response = await request.send();
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
