import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

final _logKey = GlobalKey<FormState>();
final storage = new FlutterSecureStorage();

class _LoginState extends State<Login> {
  final _userName = TextEditingController();
  final _password = TextEditingController();

  signIn(String email, String password) async {
    Map data = {'username': email, 'password': password};
    // var jsonData;
    var response = await http.post(Uri.parse("http://10.0.2.2:3000/user/login"),
        body: data);
    Map<String, dynamic> jsonData = json.decode(response.body);
    print(jsonData["token"]);
    if (response.statusCode == 200) {
      Navigator.of(context).pushReplacementNamed("/home");
    }
    await storage.write(key: "token", value: jsonData["token"]);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(50.0),
        child: Form(
          key: _logKey,
          child: Column(
            children: [
              TextFormField(
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
                    signIn(_userName.text, _password.text);
                  }),
              ElevatedButton(
                  child: Text('Registration page'),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/register');
                  })
            ],
          ),
        ),
      ),
    );
  }
}
