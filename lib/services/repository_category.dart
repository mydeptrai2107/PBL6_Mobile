import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pbl6/config/value.dart';
import 'package:pbl6/models/category.dart';

class RepositoryCategory{
  Future getAllCategory() async {
    String uri = '${iPURL}api/Category/GetCategories';
    try{
      final response = await http.get(Uri.parse(uri));
      if(response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Iterable it = data['Data'];
        List<CategoryModel> list = it.map((e) => CategoryModel.fromJson(e)).toList();
        return list;
      }
      return [];
    } catch (e){
      return;
    }
  }
}