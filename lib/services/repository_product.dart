import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pbl6/config/value.dart';
import 'package:pbl6/models/product.dart';

class RepositoryProduct {
  // ignore: non_constant_identifier_names
  Future GetAllProduct() async {
    String uri = '${iPURL}api/Product/GetProducts';
    try {
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Iterable it = data['Data'];
        List<Product> list = it.map((e) => Product.fromJson(e)).toList();
        return list;
      }
      return [];
    } catch (e) {
      return;
    }
  }

  Future getProductByCategory(String idCategory) async {
    String uri =
        "${iPURL}api/Product/GetProducts?categoryId=$idCategory&status=1&recordQuantity=999";
    try{
      final response = await http.get(Uri.parse(uri));
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        Iterable it = data['Data'];
        List<Product> list = it.map((e) => Product.fromJson(e)).toList();
        return list;
      }
      return [];
    } catch(e){
      return;
    }
  }

  Future GetProductByName(String name) async {
    String uri = '${iPURL}api/Product/GetProducts?categoryId=0&productName=$name&status=1&recordQuantity=999';
    try {
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Iterable it = data['Data'];
        List<Product> list = it.map((e) => Product.fromJson(e)).toList();
        return list;
      }
      return [];
    } catch (e) {
      return;
    }
  }
}
