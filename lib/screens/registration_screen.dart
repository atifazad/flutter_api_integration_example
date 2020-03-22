import 'package:flutter/material.dart';
import 'package:flutter_api_integration_example/models/user.dart';
import 'package:flutter_api_integration_example/services/authentication.dart';
import 'package:flutter_api_integration_example/services/registration.dart';

class RegistrationScreen extends StatefulWidget {

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

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

    final emailField = TextField(
      controller: _emailController,
      decoration: InputDecoration(hintText: 'Enter email'),
    );

    final registerButton = RaisedButton(
      child: Text('Register'),
      onPressed: () async{
        User futureUser = await registerUser(_usernameController.text, _passwordController.text, _emailController.text);
        if(futureUser != null) {
          Navigator.pushReplacementNamed(context, '/home');
        }
        else {
          updateErrorMessage('Registration failed. Please try again');
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            usernameField,
            emailField,
            passwordField,
            registerButton,
            errorLable,
          ],
        )
      ),
    );
  }
}