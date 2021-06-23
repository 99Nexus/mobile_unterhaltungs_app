import 'package:flutter/material.dart';

class Placeholder extends StatefulWidget {
  const Placeholder({Key? key}) : super(key: key);

  @override
  _PlaceholderState createState() => _PlaceholderState();
}

class _PlaceholderState extends State<Placeholder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Platzhalter")),
      body: Container(
        child: Text("Hier wird noch gebaut"),
      ),
    );
  }
}
