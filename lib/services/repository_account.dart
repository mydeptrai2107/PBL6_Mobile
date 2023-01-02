import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pbl6/config/value.dart';

import '../models/user.dart';

class RepositoryAccount {
  Future login(String email, String password) async {
    String uri = "${iPURL}api/User/UserLogin";
    final response = await http.post(
      Uri.parse(uri),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );
    final data = jsonDecode(response.body);
    if (data['isSuccess'] == true) {
      var accessToken = data['Data'][0];
      return accessToken;
    } else {
      return "sai";
    }
  }

  Future getUser(String email, String password) async {
    String uri = "${iPURL}api/User/UserLogin";
    final response = await http.post(
      Uri.parse(uri),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );
    final data = jsonDecode(response.body);
    User user = User.fromJson(data['Data'][1]);
    return user;
  }

  Future editUser(User user) async {
    String uri = "${iPURL}api/UserInfo/EditUserInfo";

    final request = http.MultipartRequest('PUT', Uri.parse(uri));

    request.fields['UserId'] = user.userId.toString();
    request.fields['FirstName'] = user.firstName;
    request.fields['LastName'] = user.lastName;
    request.fields['PhoneNumber'] = user.phoneNumber;
    request.fields['Address'] = user.address;
    request.fields['Sex'] = user.sex.toString();

    var response = await request.send();
    if (response.statusCode == 200) {
      return 'đúng';
    } else {
      return 'sai';
    }
  }

  Future register(String email, String password) async {
    String uri = "${iPURL}api/User/UserRegister";
    final response = await http.post(
      Uri.parse(uri),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

    final data = jsonDecode(response.body);
    if (data['isSuccess'] == 1) {
      return true;
    } else {
      return false;
    }
  }
}
