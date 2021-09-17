import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();

Future<List<Shoplist>> fetchAlbum() async {
  final token = await storage.read(key: "token");
  final response = await http.get(
    Uri.parse('http://10.0.2.2:3000/shoplist'),
    headers: {"Authorization": "Bearer $token"},
  );
  if (response.statusCode == 200) {
    List<dynamic> responseJson = jsonDecode(response.body);
    List<Shoplist> shoplist = responseJson
        .map(
          (dynamic item) => Shoplist.fromJson(item),
        )
        .toList();

    return shoplist;
  } else {
    throw 'Unable to retrieve shoplist.';
  }
}

class Shoplist {
  final String item;
  final String createdAt;
  final String addedBy;

  Shoplist({
    required this.item,
    required this.createdAt,
    required this.addedBy,
  });

  factory Shoplist.fromJson(Map<String, dynamic> json) {
    return Shoplist(
      item: json['item'] as String,
      createdAt: json['createdAt'] as String,
      addedBy: json['addedBy']["fullName"] as String,
    );
  }
}

class ShoplistPage extends StatefulWidget {
  @override
  _ShoplistPage createState() => _ShoplistPage();
}

class _ShoplistPage extends State<ShoplistPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: fetchAlbum(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Shoplist>> snapshot) {
            if (snapshot.hasData) {
              List<Shoplist> shoplist = snapshot.data!;
              return ListView(
                children: shoplist
                    .map(
                      (Shoplist shoplist) => ListTile(
                        title: Text(shoplist.item),
                        subtitle: Text("${shoplist.addedBy}"),
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
