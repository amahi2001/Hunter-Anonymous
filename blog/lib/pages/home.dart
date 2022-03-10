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
          title: Text(
            'Blog Home',
            style: TextStyle(
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
              ]))),
          centerTitle: true,
          elevation: 0, //shadow below the appBar
          toolbarHeight: 60,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 26),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Text(
                      "Welcome to Hunter's Voice",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 65,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Share your complaints anonymously,\n let everyone hear your thoughts.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 52,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: 285,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.black, width: 5))),
                    ),
                    SizedBox(height: 60),
                    Container(
                      width: 0.8 * MediaQuery.of(context).size.width,
                      height: 400,
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                            children: [Text("NO homeworks and NO projects")]),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
