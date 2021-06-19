import 'package:flutter/material.dart';
import 'package:mobile_unterhaltungs_app/Kalender/CalenderView.dart';

void main() {
  runApp(MyApp());
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


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Hauptmenü"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20.0),
            ElevatedButton(
              child: Text('Kalender'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CalenderView()),//Hier kommt der Aufruf der Seite
              ),
            ),
            const SizedBox(height: 12.0),
            /*ElevatedButton(
              child: Text('Chat'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ),//Hier kommt der Aufruf der Seite
              ),
            ),
            const SizedBox(height: 12.0),*/
            /*ElevatedButton(
              child: Text('Mein Bereich'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ),//Hier kommt der Aufruf der Seite
              ),
            ),
            const SizedBox(height: 12.0),*/
            /*ElevatedButton(
              child: Text('News'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ), //Hier kommt der Aufruf der Seite
              ),
            ),
            const SizedBox(height: 12.0),*/
          ],
        ),
      ),
    );
  }
}
