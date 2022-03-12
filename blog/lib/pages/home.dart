import 'dart:html';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

DateTime today = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour,
    DateTime.now().minute,
    DateTime.now().second);

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //today's date
  late String post_text; //this is the user's post
  CollectionReference posts =
      FirebaseFirestore.instance.collection('posts'); //firebase instance
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //this creates an appbar at the top my page
          title: Text(
            'Hunter Anonymous',
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
        body: SingleChildScrollView(
            child: Column(
          children: [
            Card(
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (value) {
                  post_text = value;
                },
                decoration: InputDecoration(hintText: 'Enter Post'),
              ),
            ),
            ElevatedButton(
                // this is our submit button
                onPressed: () async {
                  await posts.add({
                    'Date': today,
                    'Downvotes': 0,
                    'Text': post_text,
                    'Upvotes': 0
                  }).then((value) => print('post successful'));
                },
                child: Text(
                  'Submit Post',
                  style: TextStyle(color: Colors.white),
                )),
            StreamBuilder<QuerySnapshot>(
                stream: posts.orderBy('Upvotes').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.size,
                    itemBuilder: (context, index) {
                      String formatted_date = DateFormat()
                          .format(snapshot.data?.docs[index]['Date'].toDate());
                      return Card(
                        child: Row(children: [
                          Column(
                            children: [
                              Text(snapshot.data?.docs[index]['Text']),
                            ],
                          ),
                          SizedBox(
                            width: 200,
                          ),
                          Column(
                            children: [
                              Text(formatted_date),
                            ],
                          ),
                          SizedBox(
                            width: 200,
                          ),
                          Column(
                            children: [
                              ElevatedButton(
                                  onPressed: () {},
                                  child: Icon(Icons.thumb_up)),
                              Text('${snapshot.data?.docs[index]['Upvotes']}'),
                            ],
                          ),
                          SizedBox(
                            width: 100,
                          ),
                          Column(
                            children: [
                              ElevatedButton(
                                  onPressed: () {},
                                  child: Icon(Icons.thumb_down)),
                              Text(
                                  '${snapshot.data?.docs[index]['Downvotes']}'),
                            ],
                          )
                        ]),
                      );
                    },
                  );
                }),
          ],
        )));
  }
}
