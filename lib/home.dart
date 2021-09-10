import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();

Future<List<Recipes>> fetchAlbum() async {
  final token = await storage.read(key: "token");
  final response = await http.get(
    Uri.parse('http://10.0.2.2:3000/recipes'),
    headers: {"Authorization": "Bearer $token"},
  );
  if (response.statusCode == 200) {
    List<dynamic> responseJson = jsonDecode(response.body);
    List<Recipes> recipes = responseJson
        .map(
          (dynamic item) => Recipes.fromJson(item),
        )
        .toList();
    return recipes;
  } else {
    throw 'Unable to retrieve posts.';
  }
}

class Recipes {
  final String recipeName;
  final String recipeDescription;
  final int peopleamount;

  Recipes({
    required this.recipeName,
    required this.recipeDescription,
    required this.peopleamount,
  });

  factory Recipes.fromJson(Map<String, dynamic> json) {
    return Recipes(
      recipeName: json['name'] as String,
      recipeDescription: json['description'] as String,
      peopleamount: json['peopleamount'] as int,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Bukla cooking',
          ),
        ),
        body: FutureBuilder(
          future: fetchAlbum(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Recipes>> snapshot) {
            if (snapshot.hasData) {
              List<Recipes> recipes = snapshot.data!;
              return ListView(
                children: recipes
                    .map(
                      (Recipes recipes) => ListTile(
                        title: Text(recipes.recipeName),
                        subtitle: Text("${recipes.peopleamount}"),
                      ),
                    )
                    .toList(),
              );
            } else {
              return Center(child: Text('Loading...'));
            }
          },
        ),
      ),
    );
  }
}
