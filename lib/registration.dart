import 'package:flutter/material.dart';

class RegPage extends StatefulWidget {
  @override
  _RegState createState() => _RegState();
}

final _logKey = GlobalKey<FormState>();

class _RegState extends State<RegPage> {
  final _userName = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration page'),
      ),
      body: SingleChildScrollView(
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
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password confirmation',
                  labelText: 'Password confirmation',
                ),
                controller: _password,
              ),
              ElevatedButton(
                  child: Text('Register'),
                  onPressed: () {
                    print(_userName.text);
                    print(_password.text);
                  })
            ],
          ),
        ),
      )),
    );
  }
}
