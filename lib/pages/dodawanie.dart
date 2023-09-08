import 'package:flutter/material.dart';
import 'package:niezapominajka_flutter/pages/DemoApp.dart';

void main() {
  runApp(Dodawanie());
}

class Dodawanie extends StatefulWidget {
  @override
  _Dodawanie createState() => _Dodawanie();
}

class _Dodawanie extends State<Dodawanie> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DemoApp(),
    );
  }
}