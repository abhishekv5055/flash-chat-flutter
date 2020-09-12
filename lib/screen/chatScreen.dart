import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class ChatScreen extends StatefulWidget {
  static String id = 'chatScreen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    currentUser();
  }

  bool liveUser = false;
  String _textMessage;
  User loggedInUser;
  final textEditingController = TextEditingController();

  void currentUser() {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        loggedInUser = currentUser;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat ⚡'),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MessageStream(),
            Container(
              height: 2.0,
              color: Colors.blueAccent,
            ),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.blueAccent,
                      controller: textEditingController,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      onChanged: (value) {
                        _textMessage = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                    child: FlatButton(
                      child: Text(
                        'Send',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        textEditingController.clear();
                        _firestore.collection('messages').add(
                          {
                            'text': _textMessage,
                            'sender': loggedInUser.email,
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        List<MessageBubble> messageList = [];
        if (snapshot.hasData) {
          for (var message in snapshot.data.docs.reversed) {
            String textMessage = message.data()['text'];
            String userName = message.data()['sender'];
            String currentUser = _auth.currentUser.email;

            var messageText = MessageBubble(
              sender: userName,
              text: textMessage,
              liveUser: currentUser == userName,
            );
            messageList.add(messageText);
          }
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: messageList,
              ),
            ],
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final String sender;
  final bool liveUser;

  MessageBubble({this.text, this.sender, this.liveUser});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment:
            liveUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(fontSize: 12.0),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
            child: Material(
              color: liveUser ? Colors.blueAccent : Colors.white,
              borderRadius: liveUser
                  ? BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                    )
                  : BorderRadius.only(
                      bottomRight: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
              elevation: 5.0,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  text,
                  style: TextStyle(
                    color: liveUser ? Colors.white : Colors.black,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
