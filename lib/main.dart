import 'package:flutter/material.dart';
import 'login.dart';
import 'registration.dart';
import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Bukla cooking',
          ),
        ),
        body: Login(),
      ),
      routes: {
        '/register': (_) => RegPage(),
        '/home': (_) => HomePage(),
      },
    );
  }
}
