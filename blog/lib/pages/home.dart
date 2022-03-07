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
        title: Text('Blog Home',
          style: 
            TextStyle(
              color: Colors.blue.shade800,
              fontWeight: FontWeight.bold,
              fontSize: 40),
        ),
        // A gradient appbar background.
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Colors.blue.shade100,
                Colors.yellow.shade100,
              ]
              )
          )
        ),
        centerTitle: true,
        elevation: 0, //shadow below the appBar
        toolbarHeight: 60,
      ),
      body: Column(
        
      )
    );
  }
}