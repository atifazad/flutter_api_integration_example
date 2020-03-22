import 'dart:async';
import 'dart:convert';
import 'package:flutter_api_integration_example/models/user.dart';
import 'package:http/http.dart' as http;

Future<User> registerUser(String username, String password, String email) async {
  User futureUser;
  final url = 'http://127.0.0.1:8000/api/users';
  // final headers = {
  //   'Content-Type': 'application/json',
  // };
  final Map<String, dynamic> body = {
    'username': username,
    'password': password,
    'email': email,
  };
  final encoding = Encoding.getByName('utf-8');

  final http.Response response = await http.post(
    url,
    body: body,
    encoding: encoding
  );

  if(response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    if (jsonResponse['status'] == 'success') {
      futureUser = User.fromJson(jsonResponse);
    }
    else {
      print('user registration failed');
    }
  }
  else {
    throw Exception('Server error');
  }

  return futureUser;
}