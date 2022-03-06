import 'package:blog/pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Body());
}

class Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog Home', //title of the tab
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: HomePage(), //this is the home page
    );
  }
}