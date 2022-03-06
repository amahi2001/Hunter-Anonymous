import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //this creates an appbar at the top my page
        title: Text('Blog Home'),
        centerTitle: true,
        elevation: 0, //shadow below the appBar
        backgroundColor: Colors.purple,
      ),
    );
  }
}