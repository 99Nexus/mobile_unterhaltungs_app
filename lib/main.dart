import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mobile_unterhaltungs_app/Kalender/CalenderView.dart';
import 'package:mobile_unterhaltungs_app/Produktinformationen/ProductList.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_unterhaltungs_app/Mein Bereich/MeinBereich.dart';

import 'Hauptmenue/Hauptmenue.dart';

void main() {
  initializeDateFormatting('de_DE').then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unterhaltung Lieblingsstücke App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MainMenu(),
    );
  }
}

class MainMenu extends StatefulWidget {
  MainMenu({Key? key}) : super(key: key);
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _pageIndex=0;
  List<Widget> pageList=<Widget>[
    Hauptmenue(),
    CalenderView(),
    ProductList(),
    MeinBereich('Max Mustermann', 15),
    Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:pageList[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        type : BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _pageIndex,
        onTap: (value){
          setState(() {
            _pageIndex=value;
          });
        },
        selectedItemColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 104, 18, 18),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_important ),
            label: '',
          ),
        ],
      ),
    );
  }
}
