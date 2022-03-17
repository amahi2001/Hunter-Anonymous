import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpDownButton extends StatefulWidget {
  final String id;
  final List<dynamic> downvote_session;
  final List<dynamic> upvote_session;
  final CollectionReference posts;
  final AsyncSnapshot<QuerySnapshot> snapshot;
  final int index;

  const UpDownButton(
    this.id,
    this.downvote_session,
    this.upvote_session,
    this.posts,
    this.snapshot,
    this.index, {
    Key? key,
  }) : super(key: key);

  @override
  State<UpDownButton> createState() => _UpDownButtonState();
}

class _UpDownButtonState extends State<UpDownButton> {
  bool _uphasBeenPressed = false;
  bool _downhasBeenPressed = false;
  @override
  Widget build(BuildContext context) {
    return Column(
        //Upvote Downvote
        children: [
          Row(
            children: [
              //upvotes
              ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _uphasBeenPressed = !_uphasBeenPressed;
                      _downhasBeenPressed = false;
                    });
                    if (widget.downvote_session.contains(widget.id)) {
                      widget.downvote_session.remove(widget.id);
                      await widget.posts.doc(widget.id).update({
                        'Votes': FieldValue.increment(2),
                      });
                      widget.upvote_session.add(widget.id);
                    } else if (widget.upvote_session.contains(widget.id)) {
                      widget.upvote_session.remove(widget.id);
                      await widget.posts.doc(widget.id).update({
                        'Votes': FieldValue.increment(-1),
                      });
                    } else {
                      await widget.posts.doc(widget.id).update({
                        'Votes': FieldValue.increment(1),
                      });
                      widget.upvote_session.add(widget.id);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: _uphasBeenPressed
                        ? Colors.deepPurpleAccent.shade100
                        : Color.fromARGB(255, 144, 148, 150),
                  ).copyWith(overlayColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent.shade100)),
                  child: Icon(Icons.arrow_upward_rounded)),
            ],
          ),
          Row(
            children: [
              Text(
                '${widget.snapshot.data?.docs[widget.index]['Votes']}',
                textAlign: TextAlign.center,
              )
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _downhasBeenPressed = !_downhasBeenPressed;
                      _uphasBeenPressed = false;
                    });
                    if (widget.upvote_session.contains(widget.id)) {
                      widget.upvote_session.remove(widget.id);
                      await widget.posts.doc(widget.id).update({
                        'Votes': FieldValue.increment(-2),
                      });
                      widget.downvote_session.add(widget.id);
                    } else if (widget.downvote_session.contains(widget.id)) {
                      widget.downvote_session.remove(widget.id);
                      await widget.posts.doc(widget.id).update({
                        'Votes': FieldValue.increment(1),
                      });
                    } else {
                      await widget.posts.doc(widget.id).update({
                        'Votes': FieldValue.increment(-1),
                      });
                      widget.downvote_session.add(widget.id);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: _downhasBeenPressed
                        ? Colors.orange.shade200
                        : Color.fromARGB(255, 144, 148, 150),
                  ).copyWith(overlayColor: MaterialStateProperty.all<Color>(Colors.orange.shade200)),
                  // Colors.deepOrange.shade400,
                  child: Icon(Icons.arrow_downward_rounded)),
            ],
          ),
        ]);
  }
}
