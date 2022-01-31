import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterdogtagapp/screens/ChatRoom.dart';
import 'package:flutterdogtagapp/screens/appColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterdogtagapp/screens/home.dart';
import 'package:google_fonts/google_fonts.dart';

final chat = FirebaseFirestore.instance.collection('chatroom');
final users = FirebaseFirestore.instance.collection('users');
final chats =
    FirebaseFirestore.instance.collection('chatroom').doc().collection('chats');
final dogs = FirebaseFirestore.instance.collection('missingDogs');
List usersDocs;
List<String> userIds = [];

class Inbox extends StatefulWidget {
  String image;
  Inbox({
    this.image,
  });

  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> with WidgetsBindingObserver {
  //for chat

  dataRetriever() {
    chat.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        print(doc.id);

        print(doc.id);
        print(doc);
        // dogsDetail =
        //     FirebaseFirestore.instance.collection('users').doc(user.uid);
        // dogsDetail = FirebaseFirestore.instance.collection('users').doc(doc.id);
        // return doc;
        FirebaseFirestore.instance
            .collection('chatroom')
            .doc(doc.id)
            // .doc('815WrH1wLAbFeiNWx5oRkxvQXUV2')
            .get()
            .then((value) {
          print(value);
          // // userdata = value as List<Object>
          // setState(() {
          //   // first add the data to the Offset object
          //   List.from(value.data['user']).forEach((element) {
          //     Offset data = new Offset(element);
          //
          //     //then add the data to the List<Offset>, now we have a type Offset
          //     pointList.add(data);
          //   });
          // });
          // print("Fetched ==>>>" + value.data()["address"])
        });

        // FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(doc.id)
        //     // .doc('815WrH1wLAbFeiNWx5oRkxvQXUV2')
        //     .get()
        //     .then((value) => print("Fetched ==>>>" + value.data()["address"]));
      });
    });
  }

  Map<String, dynamic> userMap;
  var searchList = [];
  bool isLoading = false;

  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus("Online");
    dataRetriever();
    searchList.clear();
    print(searchList.length);
  }

  void setStatus(String status) async {
    await _firestore.collection('users').doc(_auth.currentUser.uid).update({
      "status": status,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      setStatus("Online");
    } else {
      // offline
      setStatus("Offline");
    }
  }

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      print(user1[0].toLowerCase().codeUnits[0]);
      print(user2.toLowerCase().codeUnits[0]);
      print("if");
      print('$user1$user2');
      return "$user1$user2";
    } else {
      print(user1[0].toLowerCase().codeUnits[0]);
      print(user2.toLowerCase().codeUnits[0]);
      print("else");
      print('$user2$user1');
      return "$user2$user1";
    }
  }

  void onSearch() async {
    setState(() {
      isLoading = true;
      searchList.clear();
    });
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    // try {
    await _firestore
        .collection('users')

        //     .where('firstname', isEqualTo: _search.text)
        //     .get()
        //     .then((value) {
        //   setState(() {
        //     userMap = value.docs[0].data();

        .where("wordArray", arrayContains: _search.text.toLowerCase())
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        var user = doc.data();
        // print('dataaa ->0-- ${user.toString()[0] }');
        searchList.add(doc.data());
        print('dataaa ->0-- ${searchList.last['name'] }');
        if(searchList.last['name'] == _auth.currentUser.displayName){
          searchList.removeLast();
        }
      });
    }).then((value) {
      setState(() {
        // userMap = value.docs[0].data();
        print(searchList);
        isLoading = false;
      });
    }).catchError((e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    });
  }

  // void onClickChat(name) async {
  //   FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //   setState(() {
  //     isLoading = true;
  //   });
  //   // Timer(Duration(seconds: 3), () {
  //   //   setState(() {
  //   //     isLoading = false;
  //   //   });
  //   // });
  //   await _firestore
  //       .collection('users')
  //       // .where("email", isEqualTo: _search.text)
  //       .where("name", isEqualTo: name.toString())
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       userMap = value.docs[0].data();
  //       isLoading = false;
  //     });
  //
  //     // Timer(Duration(seconds: 1), () {
  //     print(userMap);
  //     //   isLoading = false;
  //     // });
  //   }).catchError((e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   });
  // }
  //end.

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
              // Navigator.of(context).pop();
            }),
        title: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: widget.image == null
              ? AssetImage(
            'images/dog-profile.png',
          )
              : NetworkImage(widget.image),
          // fit: BoxFit.fill,
          // child: Image(
          //   image: AssetImage(
          //     'images/drawer-profile-pic.png',
          //   ),
          //   fit: BoxFit.fill,
          // ),
          radius: 28,
        ),
        centerTitle: false,
        actions: [
          isLoading
              ? Center(
            child: Container(
              height: size.height / 20,
              width: size.height / 20,
              child: CircularProgressIndicator(),
            ),
          )
              : Row(
            // : Column(
            children: [
              SizedBox(
                height: size.height / 70,
              ),
              Container(
                height: size.height / 14,
                width: size.width / 1.9,
                // width: size.width / 5.3,
                alignment: Alignment.center,

                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  height: size.height / 17,
                  width: size.width / 1.15,
                  child: TextField(
                    controller: _search,
                    style: GoogleFonts.poppins(),
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: GoogleFonts.poppins(),
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 50,
              ),
              // ElevatedButton(
              //   onPressed: onSearch,
              //   child: Text("Search"),
              // ),
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: onSearch,
                // onPressed: () {Navigator.of(context).pop();}
              ),
              SizedBox(
                height: size.height / 30,
              ),
              // userMap != null
              //     ?
              // ListTile(
              //   onTap: () {
              //     String roomId = chatRoomId(
              //         _auth.currentUser.displayName,
              //         // userMap['name']);
              //         userMap['firstname']);
              //
              //     Navigator.of(context).push(
              //       MaterialPageRoute(
              //         builder: (_) => ChatRoom(
              //           chatRoomId: roomId,
              //           userMap: userMap,
              //         ),
              //       ),
              //     );
              //   },
              //   leading: Icon(Icons.account_box,
              //       color: Colors.black),
              //   title: Text(
              //     // userMap['name'],
              //     userMap['firstname'],
              //     style: TextStyle(
              //       color: Colors.black,
              //       fontSize: 17,
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ),
              //   // subtitle: Text(userMap['email']),
              //   subtitle: Text(userMap['email']),
              //   trailing:
              //       Icon(Icons.chat, color: Colors.black),
              // )
              // : Container(
              //     child: Text('data not found'),
              //   ),
            ],
          ),
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            // Container(
            //   height: size.height / 5,
            //   padding:
            //       EdgeInsets.only(left: 10, top: 30, right: 10, bottom: 10),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.only(
            //         bottomLeft: Radius.circular(30),
            //         bottomRight: Radius.circular(30),
            //       ),
            //       color: themeColor,
            //       boxShadow: [
            //         BoxShadow(
            //           color: shadowColor,
            //           blurRadius: 5.0,
            //         ),
            //       ]),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Row(
            //         children: [
            //           IconButton(
            //               icon: Icon(
            //                 Icons.arrow_back_ios,
            //               ),
            //               onPressed: () {
            //                 Navigator.of(context).pop();
            //               }),
            //           CircleAvatar(
            //             backgroundColor: Colors.white,
            //             backgroundImage: widget.image == null
            //                 ? AssetImage(
            //                     'images/dog-profile.png',
            //                   )
            //                 : NetworkImage(widget.image),
            //
            //             // fit: BoxFit.fill,
            //             // child: Image(
            //             //   image: AssetImage(
            //             //     'images/drawer-profile-pic.png',
            //             //   ),
            //             //   fit: BoxFit.fill,
            //             // ),
            //             radius: 28,
            //           ),
            //           Spacer(),
            //           isLoading
            //               ? Center(
            //                   child: Container(
            //                     height: size.height / 20,
            //                     width: size.height / 20,
            //                     child: CircularProgressIndicator(),
            //                   ),
            //                 )
            //               : Row(
            //                   // : Column(
            //                   children: [
            //                     SizedBox(
            //                       height: size.height / 70,
            //                     ),
            //                     Container(
            //                       height: size.height / 14,
            //                       width: size.width / 1.9,
            //                       // width: size.width / 5.3,
            //                       alignment: Alignment.center,
            //
            //                       child: Container(
            //                         decoration: BoxDecoration(
            //                           borderRadius: BorderRadius.circular(12),
            //                           color: Colors.white,
            //                         ),
            //                         height: size.height / 17,
            //                         width: size.width / 1.15,
            //                         child: TextField(
            //                           controller: _search,
            //                           style: GoogleFonts.poppins(),
            //                           decoration: InputDecoration(
            //                             hintText: "Search",
            //                             hintStyle: GoogleFonts.poppins(),
            //                             border: OutlineInputBorder(
            //                               borderRadius:
            //                                   BorderRadius.circular(12),
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                     SizedBox(
            //                       height: size.height / 50,
            //                     ),
            //                     // ElevatedButton(
            //                     //   onPressed: onSearch,
            //                     //   child: Text("Search"),
            //                     // ),
            //                     IconButton(
            //                       icon: Icon(
            //                         Icons.search,
            //                         color: Colors.white,
            //                       ),
            //                       onPressed: onSearch,
            //                       // onPressed: () {Navigator.of(context).pop();}
            //                     ),
            //                     SizedBox(
            //                       height: size.height / 30,
            //                     ),
            //                     // userMap != null
            //                     //     ?
            //                     // ListTile(
            //                     //   onTap: () {
            //                     //     String roomId = chatRoomId(
            //                     //         _auth.currentUser.displayName,
            //                     //         // userMap['name']);
            //                     //         userMap['firstname']);
            //                     //
            //                     //     Navigator.of(context).push(
            //                     //       MaterialPageRoute(
            //                     //         builder: (_) => ChatRoom(
            //                     //           chatRoomId: roomId,
            //                     //           userMap: userMap,
            //                     //         ),
            //                     //       ),
            //                     //     );
            //                     //   },
            //                     //   leading: Icon(Icons.account_box,
            //                     //       color: Colors.black),
            //                     //   title: Text(
            //                     //     // userMap['name'],
            //                     //     userMap['firstname'],
            //                     //     style: TextStyle(
            //                     //       color: Colors.black,
            //                     //       fontSize: 17,
            //                     //       fontWeight: FontWeight.w500,
            //                     //     ),
            //                     //   ),
            //                     //   // subtitle: Text(userMap['email']),
            //                     //   subtitle: Text(userMap['email']),
            //                     //   trailing:
            //                     //       Icon(Icons.chat, color: Colors.black),
            //                     // )
            //                     // : Container(
            //                     //     child: Text('data not found'),
            //                     //   ),
            //                   ],
            //                 ),
            //           // IconButton(
            //           //     icon: Icon(
            //           //       Icons.search,
            //           //       color: Colors.white,
            //           //     ),
            //           //     onPressed: () {
            //           //       Navigator.of(context).pop();
            //           //     }),
            //         ],
            //       ),
            //       SizedBox(height: 5.0),
            //       Container(
            //         padding: EdgeInsets.only(left: 10.0),
            //         child: Text(
            //           'Message',
            //           style: GoogleFonts.poppins(
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              color: themeColor,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 10.0,top: 10.0,bottom: 30.0,),
              child: Text(
                'Message',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor,
                    blurRadius: 5.0,
                  ),
                ],
                color: Colors.white,
              ),
              margin: EdgeInsets.only(top: 50.0),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
              // child: SingleChildScrollView(
              child:
                  // Column(
                  //   children: [
                  isLoading
                      ? Center(child: Text("Searching data"))
                      : searchList.length != 0
                          ?
                          // (searchList[1]['uid'] == _auth.currentUser.uid)
                          //             ? Center(child: Text("Data not found"))
                          //             :
                          ListView.builder(
                              itemCount: searchList.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    ListTile(
                                      onTap: () async {
                                        // print("uid -----> ${searchList[index]['uid']}");
                                        // print("uid auth -----> ${_auth.currentUser.uid}");
                                        String roomId = chatRoomId(
                                            // _auth.currentUser.displayName,
                                            // searchList[index]['name']
                                            _auth.currentUser.uid,
                                            searchList[index]['uid']
                                        );
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => ChatRoom(
                                              chatRoomId: roomId,
                                              userMap: searchList[index],
                                            ),
                                          ),
                                        );
                                        _search.clear();
                                        // searchList = null;
                                      },
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        backgroundImage: NetworkImage(
                                          searchList[index]['image'] != null
                                              ? searchList[index]['image']
                                              : 'http://www.clker.com/cliparts/u/f/b/K/M/e/dog-head-profile-md.png',
                                        ),
                                        // AssetImage(
                                        //   'images/chat-profile-pic.png',
                                        //   // 'images/drawer-profile-pic.png',
                                        //   // 'images/My_profile.png',
                                        // ),
                                        radius: 28,
                                      ),
                                      // Icon(Icons.account_box,
                                      //                   color: Colors.black),
                                      title: Text(
                                        searchList[index]['name'] != null
                                            ? '${searchList[index]['firstname']} ${searchList[index]['lastname']}'
                                            : 'No first name',
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      // subtitle: Text(userMap['email']),
                                      subtitle: Text(
                                          searchList[index] != null
                                              ? searchList[index]['email'] !=
                                                      null
                                                  ? searchList[index]['email']
                                                  : 'No Email'
                                              : 'No Email',
                                          style: GoogleFonts.poppins()),
                                      trailing: Text(
                                        'Now',
                                        style: GoogleFonts.poppins(),
                                      ),
                                      // Icon(Icons.chat, color: Colors.black),
                                    )
                                  ],
                                );
                              })
                          // ListTile(
                          //                 onTap: () async {
                          //                   String roomId = chatRoomId(
                          //                       _auth.currentUser.displayName,
                          //                       userMap['name']);
                          //                   Navigator.of(context).push(
                          //                     MaterialPageRoute(
                          //                       builder: (_) => ChatRoom(
                          //                         chatRoomId: roomId,
                          //                         userMap: userMap,
                          //                       ),
                          //                     ),
                          //                   );
                          //                 },
                          //                 leading: CircleAvatar(
                          //                   backgroundColor: Colors.white,
                          //                   backgroundImage:
                          //                       // NetworkImage(
                          //                       // userMap['image'] != null
                          //                       //     ?
                          //                       // userMap['image']
                          //                       // : 'http://www.clker.com/cliparts/u/f/b/K/M/e/dog-head-profile-md.png',
                          //                       // ),
                          //                       userMap['image'] == null
                          //                           ? AssetImage(
                          //                               'images/dog-profile.png',
                          //                             )
                          //                           : NetworkImage(
                          //                               userMap['image'],
                          //                             ),
                          //                   // AssetImage(
                          //                   //   'images/chat-profile-pic.png',
                          //                   //   // 'images/drawer-profile-pic.png',
                          //                   //   // 'images/My_profile.png',
                          //                   // ),
                          //                   radius: 28,
                          //                 ),
                          //                 // Icon(Icons.account_box,
                          //                 //                   color: Colors.black),
                          //                 title: Text(
                          //                   userMap['name'] != null
                          //                       ? userMap['name']
                          //                       : 'No first name',
                          //                   style: GoogleFonts.poppins(
                          //                     color: Colors.black,
                          //                     fontSize: 17,
                          //                     fontWeight: FontWeight.w500,
                          //                   ),
                          //                 ),
                          //                 // subtitle: Text(userMap['email']),
                          //                 subtitle: Text(
                          //                     userMap != null
                          //                         ? userMap['email'] != null
                          //                             ? userMap['email']
                          //                             : 'No Email'
                          //                         : 'No Email',
                          //                     style: GoogleFonts.poppins()),
                          //                 trailing: Text(
                          //                   'Now',
                          //                   style: GoogleFonts.poppins(),
                          //                 ),
                          //                 // Icon(Icons.chat, color: Colors.black),
                          //               )
                          :
                          // chat.get().then((QuerySnapshot snapshot) {
                          // snapshot.docs.forEach((DocumentSnapshot doc) {
                          StreamBuilder(
                              // stream: dogs.snapshots(),
                              stream: chat.snapshots(),
                              builder: (context, streamSnapshot) {
                                if (streamSnapshot.hasData) {
                                  return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: streamSnapshot.data.docs.length,
                                    itemBuilder: (context, index) {
                                      final DocumentSnapshot documentSnapshot =
                                          streamSnapshot.data.docs[index];

                                      String id;
                                      String name;
                                      String email;
                                      String image =
                                          'http://www.clker.com/cliparts/u/f/b/K/M/e/dog-head-profile-md.png';
                                      // String userimage = 'http://www.clker.com/cliparts/u/f/b/K/M/e/dog-head-profile-md.png';
                                      String userimage = '';
                                      if (documentSnapshot['senderid'] ==
                                          _auth.currentUser.uid) {
                                        // userIds.add(
                                        //     documentSnapshot['recieverid']);
                                        id = documentSnapshot['recieverid'];
                                        name = documentSnapshot['recievername'];
                                        email =
                                            documentSnapshot['recieveremail'];
                                        // image = documentSnapshot['recieverimage'];
                                        userimage =
                                            documentSnapshot['recieverimage'];
                                        // image = documentSnapshot['senderimage'];

                                        print('its sender');
                                      }

                                      if (documentSnapshot['recieverid'] ==
                                          _auth.currentUser.uid) {
                                        // userIds
                                        //     .add(documentSnapshot['senderid']);
                                        id = documentSnapshot['senderid'];
                                        name = documentSnapshot['sendername'];
                                        email = documentSnapshot['senderemail'];
                                        // image = documentSnapshot['senderimage'];
                                        userimage =
                                            documentSnapshot['senderimage'];
                                        // image = documentSnapshot['recieverimage'];

                                        print('its reciever');
                                      }

                                      // data.docs[0]['senderid'])

                                      //                     //
                                      //                     DocumentSnapshot doc await firestore.collection(users).document(id).get();
                                      // void AddObjectToArray() { Set set Set(10,35); Firestore.instance.collection("exercises")
                                      // Steps 9: use StreamBuilder widget to access data using stream: Ref.snapshots() child: ListView.builder(
                                      //
                                      // let collectionRef firestore.collection('col/doc/subcollection'); console.log(`ID of the Add a new document to this collection with the specified data
                                      //                     //
                                      if (id != null &&
                                          name != null &&
                                          email != null) {
                                        return Column(
                                          children: [
                                            ListTile(
                                              onTap: () async {
                                                Map<String, dynamic> userMap = {
                                                  "uid": id,
                                                  "name": name,
                                                  "email": email,
                                                  // "message": _message.text,
                                                  // "time": FieldValue.serverTimestamp(),
                                                };
                                                // onClickChat(name);
                                                print(id);
                                                String roomId = chatRoomId(
                                                    // _auth.currentUser
                                                    //     .displayName,
                                                    // name.toString()
                                                    _auth.currentUser.uid,
                                                    id.toString()
                                                    );
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (_) => ChatRoom(
                                                      chatRoomId: roomId,
                                                      userMap: userMap,
                                                      // userMap: ,
                                                    ),
                                                  ),
                                                );
                                              },

                                              leading: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                backgroundImage: userimage == ''
                                                    ? AssetImage(
                                                        'images/dog-profile.png',
                                                      )
                                                    : NetworkImage(userimage),
                                                // backgroundImage: NetworkImage(
                                                //   userimage.isNotEmpty ? userimage :
                                                //   // userimage != null ? userimage :
                                                //     'http://www.clker.com/cliparts/u/f/b/K/M/e/dog-head-profile-md.png',
                                                // ),
                                                // 'https://i.insider.com/5484d9d1eab8ea3017b17e29?width=600&format=jpeg&auto=webp',
                                                // image != null ? image : 'images/drawer-profile-pic.png',
                                                // backgroundImage: NetworkImage(
                                                //   // image != null ? image :
                                                //   'http://www.clker.com/cliparts/u/f/b/K/M/e/dog-head-profile-md.png',
                                                //   // '{$image}',
                                                // ),
                                                radius: 28,
                                              ),

                                              // Icon(Icons.account_box,
                                              //     color: Colors.black),

                                              title: Text(
                                                name != null
                                                    ? name
                                                    : 'No first name',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  // fontWeight: FontWeight.w500,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              // subtitle: Text(userMap['email']),
                                              subtitle: Text(email != null
                                                  ? email
                                                  : 'No Email'),
                                              trailing: Text('Now'),
                                              // Icon(Icons.chat,
                                              //     color: themeColor),
                                            ),
                                            Divider(
                                              color: Colors.black,
                                              thickness: 1.0,
                                              indent: size.width / 6,
                                              endIndent: 20.0,
                                            ),
                                          ],
                                        );
                                      }
                                      return Container();
                                    },
                                  );
                                }

                                return Center(
                                  child: Text('No data found'),
                                  // CircularProgressIndicator(),
                                );
                              },
                            ),
              // Text('aewe'),

              //   ],
              // ),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
