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
  final _addShopItem = TextEditingController();

  addToShoplist(String item) async {
    Map data = {"item": item};
    final token = await storage.read(key: "token");
    await http.post(
      Uri.parse("http://10.0.2.2:3000/shoplist"),
      headers: {"Authorization": "Bearer $token"},
      body: data,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Felírás',
                          labelText: 'Felírás',
                        ),
                        controller: _addShopItem,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: ElevatedButton(
                          child: Text('Submit'),
                          onPressed: () {
                            addToShoplist(_addShopItem.text);
                          }),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  FutureBuilder(
                    future: fetchAlbum(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Shoplist>> snapshot) {
                      if (snapshot.hasData) {
                        List<Shoplist> shoplist = snapshot.data!;
                        return Container(
                          width: double.infinity,
                          height: 1000,
                          child: ListView.builder(
                              itemCount: shoplist.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  color: Colors.green,
                                  child: InkWell(
                                    splashColor: Colors.blue.withAlpha(30),
                                    onTap: () {
                                      print('Card tapped.');
                                    },
                                    child: ListTile(
                                      title: Text(shoplist[index].item),
                                      subtitle:
                                          Text("${shoplist[index].addedBy}"),
                                    ),
                                  ),
                                );
                              }),
                        );
                      } else {
                        return Center(child: Text('Loading...'));
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
