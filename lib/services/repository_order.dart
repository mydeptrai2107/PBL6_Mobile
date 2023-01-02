import 'dart:convert';
import 'package:pbl6/config/value.dart';
import 'package:http/http.dart' as http;
import 'package:pbl6/models/cart.dart';
import 'package:pbl6/models/order.dart';

class RepositoryOrder {
  Future getOrderItemByUserId(String idUser) async {
    String uri =
        '${iPURL}api/Order/GetOrders?status=-1&userID=$idUser&recordQuantity=999';
    try {
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Iterable it = data['Data'];
        List<Order> list = it.map((e) => Order.fromJson(e)).toList();
        return list;
      }
      return response.statusCode;
    } catch (e) {
      return e.toString();
    }
  }

  Future getCartItemByOrderId(String idOrder) async {
    String uri = '${iPURL}api/Order/GetOrderDetailsByOrderID?id=$idOrder';
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

  Future updateStatusOrder(int idOrder, int status) async {
    String uri = '${iPURL}api/Order/UpdateOrderStatus';
    try {
      final response = await http.put(
        Uri.parse(uri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken'
        },
        body: jsonEncode(<String, String>{
          'id': idOrder.toString(),
          'status': status.toString(),
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['isSuccess']) {
          return true;
        } else {
          return false;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
