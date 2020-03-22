import 'dart:async';
import 'dart:convert';
import 'package:flutter_api_integration_example/models/user.dart';
import 'package:http/http.dart' as http;

Future<User> authenticate(String username, String password) async {
  User futureUser;
  final url = 'http://127.0.0.1:8000/api/login';
  // final headers = {
  //   'Content-Type': 'application/json',
  // };
  final Map<String, dynamic> body = {
    'username': username,
    'password': password,
  };
  final encoding = Encoding.getByName('utf-8');

  final http.Response response = await http.post(
    url,
    // headers: headers,
    body: body,
    encoding: encoding
  );

  if(response.statusCode == 200) {
    var jsonResponse = json.decode(response.body);
    if (jsonResponse['status'] == 'success') {
      futureUser = User.fromJson(jsonResponse);
    }
    else {
      print('login failed');
    }
  }
  else {
    throw Exception('Server error');
  }

  return futureUser;
}