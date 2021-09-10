import 'package:flutter/material.dart';
import 'recipes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _pages = <Widget>[
    Icon(
      Icons.checklist_rtl,
      size: 150,
    ),
    RecipePage(),
    Icon(
      Icons.chat,
      size: 150,
    ),
    Icon(
      Icons.chat,
      size: 150,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Demo'),
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex), //New
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex, //
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_rtl),
            label: 'Bevásárló lista',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Recept',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups),
            label: 'Csoportom',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Beállítás',
          ),
        ],
      ),
    );
  }
}
