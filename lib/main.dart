import 'package:flutter/material.dart';
import 'package:flutterapp/homepage.dart';

void main() {
  runApp(MinhaApp());
}

class MinhaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github Users',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
