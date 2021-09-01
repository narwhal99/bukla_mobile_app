import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

final _logKey = GlobalKey<FormState>();

class _LoginState extends State<Login> {
  final _userName = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(50.0),
        child: Form(
          key: _logKey,
          child: Column(
            children: [
              TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Username',
                  labelText: 'Username',
                ),
                controller: _userName,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  labelText: 'Password',
                ),
                controller: _password,
              ),
              ElevatedButton(
                  child: Text('Login'),
                  onPressed: () {
                    print(_userName.text);
                    print(_password.text);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
