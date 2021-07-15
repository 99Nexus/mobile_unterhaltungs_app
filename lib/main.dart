import 'package:flutter/material.dart';
import 'package:mobile_unterhaltungs_app/Controller/AuthController.dart';
import 'package:mobile_unterhaltungs_app/Data/Person/Person.dart';
import 'package:mobile_unterhaltungs_app/Kalender/CalenderView.dart';
import 'package:mobile_unterhaltungs_app/Login%20und%20Registrieren/Registrieren.dart';
import 'package:mobile_unterhaltungs_app/Mein%20Bereich/ArbeitszeitBeantragen.dart';
import 'package:mobile_unterhaltungs_app/Produktinformationen/ProductList.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_unterhaltungs_app/Mein Bereich/MeinBereich.dart';
import 'package:mobile_unterhaltungs_app/Mein Bereich/UrlaubBeantragen.dart';
import 'Hauptmenue/Hauptmenue.dart';
import 'News/NewsList.dart';
import 'package:provider/provider.dart';
import 'package:mobile_unterhaltungs_app/Login%20und%20Registrieren/Login.dart';

class MyApp extends StatelessWidget {
  MyApp(this.user);

  Person user;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unterhaltung Lieblingsstücke App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MainMenu(user),
    );
  }
}

class MainMenu extends StatefulWidget {
  MainMenu(this.user);

  Person user;

  @override
  _MainMenuState createState() => _MainMenuState(user);
}

class _MainMenuState extends State<MainMenu> {
  _MainMenuState(this._user);

  Person _user;
  int _pageIndex = 0;
  late List<Widget> pageList;

  @override
  void initState() {
    pageList = <Widget>[
      Hauptmenue(_user),
      CalenderView(_user),
      ProductList(),
      MeinBereich(_user, 15, 0),
      //ArbeitszeitBeantragen(_user),
      //UrlaubBeantragen(_user),
      NewsList(),
    ];
    _pageIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'images/teaser-unterhaltung.png',
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shadowColor: Colors.transparent,
        toolbarHeight: 80,
      ),
      backgroundColor: Colors.white,
      body: pageList[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
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
            icon: Icon(Icons.shopping_bag),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_important),
            label: '',
          ),
        ],
      ),
    );
  }
}
