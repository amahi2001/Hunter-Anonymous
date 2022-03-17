import 'dart:html';
import 'package:blog/updownbutton.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

/*For checking if upvote is pressed*/
var upvote_session = [];
var downvote_session = [];

void deletePosts(CollectionReference collection){
  var doc = collection.get();
  doc.then((snapshot) {
    snapshot.docs.forEach((doc) {
      doc.reference.delete();
    });
  });
}

//today's date
DateTime today = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour,
    DateTime.now().minute,
    DateTime.now().second);

_goToFBPage() async {
  const fb_url = 'https://www.facebook.com/Hunter-Anonymous-104189795564227';
  if (await canLaunch(fb_url)) {
    await launch(fb_url);
  } else {
    throw 'Could not launch $fb_url';
  }
}

_goToTWPage() async {
  const tw_url = 'https://twitter.com/HunterAnonymou4';
  if (await canLaunch(tw_url)) {
    await launch(tw_url);
  } else {
    throw 'Could not launch $tw_url';
  }
}

_goToINSPage() async {
  const ins_url = 'https://www.instagram.com/hunter_anonymous395/';
  if (await canLaunch(ins_url)) {
    await launch(ins_url);
  } else {
    throw 'Could not launch $ins_url';
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String post_text; //this is the user's post
  CollectionReference posts =
      FirebaseFirestore.instance.collection('posts'); //firebase instance
  
  final text = TextEditingController();
  void clearTextField() => text.clear();

  /*For StreamBuilder */
  late Stream<QuerySnapshot> PostStreams;

  /*For Scroll to top button */
  bool _showBackToTopButton = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    // deletePosts(posts);
    PostStreams = posts.orderBy('Date', descending: true).snapshots();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 300) {
            _showBackToTopButton = true;
          } else {
            _showBackToTopButton = false;
          }
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }

  bool _uphasBeenPressed = false;
  bool _downhasBeenPressed = false;

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    // Desktop & Tablet View App bar formats.
    String appTitle = 'Hunter Anonymous';
    double font_size = 55;
    double icon_SizedBox1Width = 25;
    double icon_SizedBox2Width = 15;
    double textField_Icon_RightPadding = 15;
    double welcome_message_FontSize = 28;
 
    if (width <= 430){  // Mobile View App bar formats.
      appTitle = 'Hunter\n Anonymous';
      font_size = 26;
      icon_SizedBox1Width = 0.0;
      icon_SizedBox2Width = 5;
      textField_Icon_RightPadding = 1;
      welcome_message_FontSize = 16;
    } 

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton(
              onPressed: _scrollToTop,
              tooltip: 'Scroll to top',
              child: const Icon(Icons.arrow_upward),
            ),
      appBar: AppBar(
        //this creates an appbar at the top my page
        title: Text(appTitle,
            style: TextStyle(
                color: Colors.deepPurple.shade700,
                fontWeight: FontWeight.bold,
                fontSize: font_size,
                wordSpacing: 15),
            textAlign: TextAlign.center,
            semanticsLabel: 'Blog Title: Hunter Anonymous'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 22),
            child: Wrap(
              children: [
                IconButton(
                    onPressed: _goToFBPage,
                    tooltip: 'Facebook',
                    icon: Icon(FontAwesome5.facebook,
                        color: Colors.deepPurple.shade400, size: 30),
                    hoverColor: Color.fromARGB(255, 250, 225, 150),
                    highlightColor: Color.fromARGB(255, 255, 211, 78),
                    splashRadius: 25),
                SizedBox(width: icon_SizedBox1Width),
                IconButton(
                    onPressed: _goToTWPage,
                    tooltip: 'Twitter',
                    icon: Icon(FontAwesome5.twitter,
                        color: Colors.deepPurple.shade400, size: 30),
                    hoverColor: Color.fromARGB(255, 250, 225, 150),
                    highlightColor: Color.fromARGB(255, 255, 211, 78),
                    splashRadius: 25),
                SizedBox(width: icon_SizedBox1Width),
                IconButton(
                    onPressed: _goToINSPage,
                    tooltip: 'Instagram',
                    icon: Icon(FontAwesome5.instagram,
                        color: Colors.deepPurple.shade400, size: 30),
                    hoverColor: Color.fromARGB(255, 250, 225, 150),
                    highlightColor: Color.fromARGB(255, 255, 211, 78),
                    splashRadius: 25),
                SizedBox(width: icon_SizedBox2Width)
              ],
            ),
          ),
        ], // End of Social Media Buttons
        // A gradient appbar background.
        flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
              Colors.deepPurple.shade300,
              Colors.yellow.shade100,
            ]))),
        centerTitle: true,
        elevation: 0, //shadow below the appBar
        toolbarHeight: 75,
      ),
      body: ListView(
        controller: _scrollController,
        children: [
          Card(
            child: Text(
              'Welcome to Hunter Anonymous, you can share your voice here. It will be anonymous, but please be respectful to others.',
              style: TextStyle(
                color: Colors.deepPurpleAccent.shade400,
                fontSize: welcome_message_FontSize, 
                wordSpacing: 8),
              textAlign: TextAlign.center,
              semanticsLabel: 'A welcome message to users.'
            ),
          ),
          Card(
            child: Container(
                width: 0.98 * MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Semantics(
                        child: TextField(
                            controller: text,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            onChanged: (value) {
                              post_text = value;
                            },
                            decoration: InputDecoration(
                                hintText: 'Enter Post',
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(97, 53, 153, 85),
                                    fontSize: 26,
                                    wordSpacing: 4),
                                contentPadding:
                                    EdgeInsets.only(left: 10, top: 15),
                                suffixIcon: IconButton(
                                    // An icon button for user to remove text from a text field.
                                    padding:
                                        EdgeInsets.only(top: 15, right: textField_Icon_RightPadding),
                                    splashRadius: 0.1,
                                    onPressed: clearTextField,
                                    tooltip: 'Remove input text',
                                    icon: Icon(Icons.clear,
                                        size: 25, color: Colors.deepPurple)),
                                fillColor: Colors.deepPurple.shade100,
                                filled: true),
                            style: TextStyle(fontSize: 26, wordSpacing: 5),
                            cursorHeight: 26), // End of the Text Field.
                        textField: true,
                        multiline: true,
                        label:'You are in a text field, please enter your post.'),
                    SizedBox(height: 5),
                    Semantics(
                        child: ElevatedButton(
                            // this is our submit button
                            onPressed: () async {
                              await posts.add({
                                'Date': today,
                                'Votes': 0,
                                'Text': post_text,
                              }).then((value) => print('post successful'));
                              clearTextField(); // Text will be removed from text field after pressing submission button.
                            },
                            child: Text('Submit Post',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    wordSpacing: 6)),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 144, 105, 211)),
                                overlayColor: MaterialStateProperty.all<Color>(
                                    Colors.deepPurple),
                                fixedSize: MaterialStateProperty.all(
                                    const Size(180, 40)))),
                        button: true, // End of Submission Button.
                        label: 'Submission Button',
                        onTapHint: 'Press enter to submit your post.'),
                  ],
                ),
                padding: EdgeInsets.only(bottom: 5)),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: PostStreams,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong: ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, index) {
                    String formatted_date = DateFormat()
                        .format(snapshot.data?.docs[index]['Date'].toDate());
                    var id = snapshot.data?.docs[index].id;
                    return Card(
                      color: Colors.deepPurple.shade100,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(
                              color: Colors.deepPurple.shade200, width: 1)),
                      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              fit: FlexFit.tight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(padding: EdgeInsets.only(left:15, top: 6, right: 15, bottom: 3),
                                    child: Text(snapshot.data?.docs[index]['Text'],
                                      style: TextStyle(
                                          color: Colors.deepPurple.shade900, fontSize: 20, wordSpacing: 3))),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 6),
                                    child: Text(formatted_date,
                                      style: TextStyle(
                                          fontSize: 12, wordSpacing: 5))),
                                  //for testing
                                  /*Text('ID: ${id}',
                                      style: TextStyle(
                                          fontSize: 11, wordSpacing: 5)),
                                */
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 6, right:15, bottom: 6),
                              child: UpDownButton(id!, downvote_session, upvote_session,
                                posts, snapshot, index))
                          ]),
                    );
                  },
                );
              }),
        ],
      ),
    );
  }
}
