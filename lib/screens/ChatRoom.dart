import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterdogtagapp/screens/appColors.dart';
import 'package:flutterdogtagapp/screens/inbox.dart';
import 'package:flutterdogtagapp/stylingWidgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatRoom extends StatefulWidget {
  final Map<String, dynamic> userMap;
  final String chatRoomId;

  ChatRoom({this.chatRoomId, this.userMap});

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Map<String, dynamic> recieverDog;
  Map<String, dynamic> senderDog;
  Map<String, dynamic> recieverDogs;

  final TextEditingController _message = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void onSendMessage() async {
    String senderimage;
    String recieverimage;
    // getUserById() async {
    await FirebaseFirestore.instance
        .collection('missingDogs')
        // .where("email", isEqualTo: _search.text)
        .where("uid", isEqualTo: widget.userMap['uid'])
        // .where("uid", isEqualTo: _auth.currentUser.uid)
        .get()
        .then((value) {
      setState(() {
        // if(value != null){
        // if(value.docs != null) {
        if (value.docs.length > 0) {
          if (value.docs[0].data() != null) {
            //   recieverDog = value.docs[0].data();
            recieverimage = value.docs[0].data()['ImageUrl'];
            // }
          }
          // }else{
          //   recieverDog = null;
        }
      });
      // print(recieverDog['image']);
    });
    // }

    await FirebaseFirestore.instance
        .collection('missingDogs')
        // .where("email", isEqualTo: _search.text)
        //     .where("uid", isEqualTo: userMap['uid'])
        .where("uid", isEqualTo: _auth.currentUser.uid)
        .get()
        .then((value) {
      setState(() {
        try {
          if (value.docs[0].data()['ImageUrl'] != null) {
            senderimage = value.docs[0].data()['ImageUrl'];
          } else {
            senderimage =
                'https://avatars.mds.yandex.net/i?id=46eb477969056c7195a94293be54e7f5-4599759-images-thumbs&n=13';
          }
          if (value.docs[0].data() == null) {
            senderDog = value.docs[0].data();
          } else {
            senderDog = null;
          }
        } catch (e) {
          print(e);
        }
      });
      // print(senderDog['image']);
    });

    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "recieverid": widget.userMap['uid'],
        // "recieverimage": recieverDog != null ? recieverDog['ImageUrl'] : 'http://www.clker.com/cliparts/u/f/b/K/M/e/dog-head-profile-md.png',
        "recieverimage": recieverimage != null
            ? recieverimage
            : 'http://www.clker.com/cliparts/u/f/b/K/M/e/dog-head-profile-md.png',
        // "senderimage": senderDog!=null?senderDog['ImageUrl'] : 'http://www.clker.com/cliparts/u/f/b/K/M/e/dog-head-profile-md.png',
        "senderimage": senderimage != null
            ? senderimage
            : 'http://www.clker.com/cliparts/u/f/b/K/M/e/dog-head-profile-md.png',
        "senderid": _auth.currentUser.uid,
        "sendby": _auth.currentUser.displayName,
        "message": _message.text,
        "time": FieldValue.serverTimestamp(),
      };

      _message.clear();

      await _firestore
          .collection('chatroom')
          // .add(messages);
          .doc(widget.chatRoomId)
          .set({
        "recieverid": widget.userMap['uid'],
        "recievername": widget.userMap['name'],
        "recieveremail": widget.userMap['email'],
        "recieverimage": recieverDog != null ? recieverDog['ImageUrl'] : '',
        "recieverstatus": 0,
        "senderstatus": 0,
        "senderid": _auth.currentUser.uid,
        "sendername": _auth.currentUser.displayName,
        "senderemail": _auth.currentUser.email,
        "senderimage": senderDog != null ? senderDog['ImageUrl'] : '',
      });

      await _firestore
          .collection('chatroom')
          .doc(widget.chatRoomId)
          .collection('chats')
          .add(messages);
    } else {
      print("Enter Some Text");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        )),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            color: Colors.black,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Inbox(
                        image: userMap == null
                            ? null
                            : userMap['ImageUrl'],
                      )));
              // Navigator.of(context)..pop();
            }),
        backgroundColor: themeColor,
        title: StreamBuilder<DocumentSnapshot>(
          stream: _firestore
              .collection("users")
              .doc(widget.userMap['uid'])
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return Container(
                child: Column(
                  children: [
                    Text(
                      widget.userMap['name'],
                      style: GoogleFonts.poppins(color: Colors.black),
                    ),
                    // Text(
                    //   // 'status',
                    //   snapshot.data['status'],
                    //   style: TextStyle(fontSize: 14),
                    // ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage(
              'images/chat-profile-pic.png',
              // 'images/drawer-profile-pic.png',
              // 'images/My_profile.png',
            ),
            // fit: BoxFit.fill,
            // child: Image(
            //   image: AssetImage(
            //     'images/drawer-profile-pic.png',
            //   ),
            //   fit: BoxFit.fill,
            // ),
            radius: 28,
          ),
          SizedBox(width: 20.0),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: size.height / 11),
              child: Container(
                // height: size.height - 80 - size.height / 7,
                // height: size.height / 1.3,
                width: size.width,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('chatroom')
                      .doc(widget.chatRoomId)
                      .collection('chats')
                      .orderBy("time", descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.data != null) {
                      return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> map =
                              snapshot.data.docs[index].data();
                          return messages(size, map);
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Container(
                margin: EdgeInsets.only(top: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: shadowColor,
                        blurRadius: 5.0,
                      ),
                    ]),
                height: size.height / 12,
                width: size.width,
                alignment: Alignment.center,
                child: Container(
                  // height: size.height / 12,
                  width: size.width / 1.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: size.height / 17,
                        width: size.width / 1.3,
                        child: TextField(
                          controller: _message,
                          style: GoogleFonts.poppins(),
                          decoration: InputDecoration(
                            hintText: "Type message",
                            hintStyle: GoogleFonts.poppins(),
                            // border: OutlineInputBorder(
                            //   borderSide: BorderSide(
                            //     color: themeColor,
                            //   ),
                            //   borderRadius: BorderRadius.circular(8),
                            // ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.send,
                            color: themeColor,
                          ),
                          onPressed: onSendMessage),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // bottomNavigationBar: BottomAppBar(
      //   child: Container(
      //     height: size.height / 10,
      //     width: size.width,
      //     alignment: Alignment.center,
      //     child: Container(
      //       height: size.height / 12,
      //       width: size.width / 1.1,
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Container(
      //             height: size.height / 17,
      //             width: size.width / 1.3,
      //             child: TextField(
      //               controller: _message,
      //               decoration: InputDecoration(
      //                 hintText: "Type message",
      //                 border: InputBorder.none,
      //
      //                 // border: OutlineInputBorder(
      //                 //   borderSide: BorderSide(
      //                 //     color: themeColor,
      //                 //   ),
      //                 //   borderRadius: BorderRadius.circular(8),
      //                 // ),
      //               ),
      //             ),
      //           ),
      //           IconButton(
      //               icon: Icon(
      //                 Icons.send_rounded,
      //                 color: themeColor,
      //               ),
      //               onPressed: onSendMessage),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  Widget messages(Size size, Map<String, dynamic> map) {
    var sender = map['sendby'] == _auth.currentUser.displayName ? true : false;
    return Container(
      width: size.width,

      alignment: sender
          ? Alignment.bottomRight
          // centerRight
          : Alignment.bottomLeft,
      // centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(15),
          borderRadius: sender
              ? BorderRadius.circular(12)
                  .subtract(BorderRadius.only(bottomRight: Radius.circular(12)))
              : BorderRadius.circular(12)
                  .subtract(BorderRadius.only(bottomLeft: Radius.circular(12))),
          color: sender ? themeColor : Colors.grey[400],
        ),
        child: Text(
          map['message'],
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  getUserById() async {
    await FirebaseFirestore.instance
        .collection('missingDogs')
        // .where("email", isEqualTo: _search.text)
        .where("uid", isEqualTo: _auth.currentUser.uid)
        .get()
        .then((value) {
      setState(() {
        recieverDogs = value.docs[0].data();
      });
    });
  }
}

//
