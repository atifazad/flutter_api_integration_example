import 'package:flutter/material.dart';
import 'package:flutter_api_integration_example/models/user.dart';
import 'package:flutter_api_integration_example/services/authentication.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorMessage;

  void updateErrorMessage(String message) {
    setState(() {
      _errorMessage = message;
    });
  }

  @override
  void initState() {
    super.initState();
    updateErrorMessage('');
  }

  @override
  Widget build(BuildContext context) {

    var errorLable = Text('$_errorMessage');

    final usernameField = TextField(
      controller: _usernameController,
      decoration: InputDecoration(hintText: 'Enter Username'),
    );

    final passwordField = TextField(
      controller: _passwordController,
      decoration: InputDecoration(hintText: 'Enter password'),
    );

    final loginButton = RaisedButton(
      child: Text('Login'),
      onPressed: () async{
        User futureUser = await authenticate(_usernameController.text, _passwordController.text);
        if(futureUser != null) {
          Navigator.pushReplacementNamed(context, '/home');
        }
        else {
          updateErrorMessage('Login failed. Please try again');
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            usernameField,
            passwordField,
            loginButton,
            errorLable,
          ],
        )
      ),
    );
  }
}
