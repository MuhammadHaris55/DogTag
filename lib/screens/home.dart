import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import 'package:flutterdogtagapp/screens/appColors.dart';
import 'package:flutterdogtagapp/screens/dogInfo.dart';
import 'package:flutterdogtagapp/screens/registerDog_1.dart';
import 'package:flutterdogtagapp/stylingWidgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterdogtagapp/widget/catalog_product.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

final userRef = FirebaseFirestore.instance.collection('users');
final dogs = FirebaseFirestore.instance.collection('missingDogs');

String chatRoomId(String user1, String user2) {
  if (user1[0].toLowerCase().codeUnits[0] > user2.toLowerCase().codeUnits[0]) {
    return "$user1$user2";
  } else {
    return "$user2$user1";
  }
}

var dogsDetail;
Row drawerIconRow(String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 15,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      Icon(
        Icons.arrow_forward,
        color: Colors.black,
      ),
    ],
  );
}

Row drawerRow(String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 15,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

Container dataContainer(screen, documentSnapshot) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5.0),
    width: screen.width / 3,
    height: screen.width / 2.2,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 5.0,
          ),
        ]),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: screen.width / 3,
          height: screen.width / 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image(
              fit: BoxFit.fill,
              image: NetworkImage(
                documentSnapshot['ImageUrl'] != null
                    ? documentSnapshot['ImageUrl']
                    : 'https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_960_720.jpg',
              ),
            ),
          ),
        ),

        SizedBox(height: 10.0),
        Text(
          documentSnapshot['DogName'] != null
              ? documentSnapshot['DogName']
              : 'Zoey, Female',
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.0),
        Container(
          padding: EdgeInsets.only(left: 5.0),
          child: Text(
            documentSnapshot['DogDescription'] != null
                ? documentSnapshot['DogDescription']
                : 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod',
            // 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod',
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 10,
            ),
          ),
        ),
      ],
    ),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    print('hi there');
    print('FirstName');

    // Or call your function here
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  CollectionReference missingDogs =
      FirebaseFirestore.instance.collection('users');

  User user = FirebaseAuth.instance.currentUser;

  List<Offset> pointList;
  gettingdata() async {
    var result = await FirebaseFirestore.instance
        // firestoreInstance
        .collection("users")
        // .where("countryName", isEqualTo: "italy")
        .get();
    result.docs.forEach((res) {
      print(res.data());
      var yo = res.data();
      print('hi $result');
      print('yo $yo');
    });
  }

  combinefunc() {
    final userRef = FirebaseFirestore.instance.collection('users');

    userRef.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        print(doc.id);

        print('New data');
        dogsDetail =
            FirebaseFirestore.instance.collection('users').doc(user.uid);
        // dogsDetail = FirebaseFirestore.instance.collection('users').doc(doc.id);

        FirebaseFirestore.instance
            .collection('users')
            .doc(doc.id)
            // .doc('815WrH1wLAbFeiNWx5oRkxvQXUV2')
            .get()
            .then((value) {
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


  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final int length = 10;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: homeColor,
        endDrawer: MainDrawer(),
        appBar: AppBar(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          centerTitle: false,
          title: Image(
            image: AssetImage(
              'images/Dog_Tag-03.png',
            ),
            width: screen.width / 2,
          ),
          actions: [
            IconButton(
              onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
              icon: Icon(
                Icons.menu,
                color: themeColor,
              ),
            ),
          ],
          backgroundColor: Colors.white,
        ),
        body: Container(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    width: screen.width / 1.1,
                    color: homeColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'My report',
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: screen.width / 18,
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0),
                            boxShadow: [
                              BoxShadow(
                                color: shadowColor,
                                blurRadius: 5.0,
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 30.0),
                          child: Column(
                            children: [
                              Text(
                                'Add your lost dog \n report',
                                style: GoogleFonts.poppins(
                                  color: themeColor,
                                  fontSize: screen.width / 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              registerDog_1()));
                                },
                                child: Text(
                                  'ADD YOUR DOG ->',
                                  style: GoogleFonts.poppins(),
                                ),
                                style: ButtonStyle(
                                  // padding: MaterialStateProperty.all<EdgeInsets>(
                                  //     EdgeInsets.all(20.0)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: BorderSide(
                                        color: themeColor,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        RichText(
                          text: TextSpan(
                            text: 'Lost Dogs',
                            style: GoogleFonts.poppins(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: screen.width / 18,
                            ),
                            children: [
                              TextSpan(
                                text: ' Near Me',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: screen.width / 2.0,
                          child: CatalogProduct() ??
                              Center(
                                  child: Text(
                                "NO DATA AVAILABLE",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          //  StreamBuilder(
                          //   // stream: dogsDetail.snapshots(),
                          //   stream: dogs.snapshots(),
                          //   // stream: userRef.snapshots(),
                          //   builder: (context, streamSnapshot) {
                          //     if (streamSnapshot.hasData) {
                          //       return ListView.builder(
                          //         scrollDirection: Axis.horizontal,
                          //         itemCount: streamSnapshot.data.docs.length,
                          //         itemBuilder: (context, index) {
                          //           final DocumentSnapshot documentSnapshot =
                          //               streamSnapshot.data.docs[index];
                          //           // final ownerDetail;
                          //           // userRef
                          //           //     .doc(documentSnapshot['uid'])
                          //           //     .get();
                          //           //     .then((value) {
                          //           //   ownerDetail = value.data();
                          //           // });
                          //           // print(documentSnapshot['uid']);
                          //           // print(ownerDetail);
                          //           return documentSnapshot == null
                          //               ? Center(
                          //                   child: Text('No data found'),
                          //                   // CircularProgressIndicator(),
                          //                 )
                          //               : GestureDetector(
                          //                   onTap: () {
                          //                     Navigator.push(
                          //                       context,
                          //                       MaterialPageRoute(
                          //                         builder: (context) => dogInfo(
                          //                           detail: documentSnapshot,
                          //                         ),
                          //                       ),
                          //                     );
                          //                   },
                          //                   child: dataContainer(
                          //                       screen, documentSnapshot),
                          //                 );
                          //           //   Card(
                          //           //   margin: EdgeInsets.all(10),
                          //           //   child: ListTile(
                          //           //     title:
                          //           //         Text(documentSnapshot['firstname']),
                          //           //     subtitle: Text(
                          //           //         documentSnapshot['password']
                          //           //             .toString()),
                          //           //     trailing: SizedBox(
                          //           //       width: 50,
                          //           //       // child: Row(
                          //           //       //   children: [
                          //           //       //     // Press this button to edit a single product
                          //           //       //     IconButton(
                          //           //       //         icon: Icon(Icons.edit),
                          //           //       //         onPressed: () =>
                          //           //       //             _createOrUpdate(documentSnapshot)),
                          //           //       //     // This icon button is used to delete a single product
                          //           //       //     IconButton(
                          //           //       //         icon: Icon(Icons.delete),
                          //           //       //         onPressed: () =>
                          //           //       //             _deleteProduct(documentSnapshot.id)),
                          //           //       //   ],
                          //           //       // ),
                          //           //     ),
                          //           //   ),
                          //           // );
                          //         },
                          //       );
                          //     }
                          //
                          //     return Center(
                          //       child: Text('No data found'),
                          //       // CircularProgressIndicator(),
                          //     );
                          //   },
                          // ),
                          // child: Text('sf $dogs'),

                          // children: snapshot.data
                          //     .map((data) => _buildListItem(context, data))
                          //     .toList(),

                          // db.collection("restaurants").doc("123").collection("reviews").get()
                          //     .then(querySnapshot => {
                          // querySnapshot.forEach(doc => {
                          // console.log(doc.id, " => ", doc.data());
                          // });
                          // });

                          // child: StreamBuilder(
                          //   stream: FirebaseFirestore.instance
                          //       .collection('missingDogs')
                          //
                          //       // .collection('dogsDetail')
                          //       .snapshots(),
                          //   builder: (BuildContext context,
                          //       AsyncSnapshot<QuerySnapshot> snapshot) {
                          //     // QuerySnapshot snapshot = await FirebaseFirestore.instance
                          //     //     .collection('missingDogs')
                          //     //     .orderBy("createdAt", descending: true)
                          //     //     .getDocuments();
                          //     print(snapshot.data.docs.length);
                          //     if (!snapshot.hasData) {
                          //       return Center(
                          //         child: CircularProgressIndicator(),
                          //       );
                          //     }
                          //
                          //     return ListView(
                          //       children:
                          //           //                         void readData(){
                          //           // databaseReference.once().then((DataSnapshot snapshot) {
                          //           // print('Data : ${snapshot.value}');
                          //           // });
                          //           // }
                          //           // snapshot.data.docs.map((document) {
                          //           snapshot.data.docs.map((document) {
                          //         // snapshot.documents.forEach((document) {
                          //         //   Food food = Food.fromMap(document.data);
                          //         //   _foodList.add(food);
                          //         // });
                          //         // children: snapshot.data.docs.map((document) {
                          //         return Container(
                          //           child: Center(
                          //               child: Text(document['DogBreed'] +
                          //                   document['DogColor'])),
                          //           // child: Center(child: Text(document['text'])),
                          //         );
                          //       }).toList(),
                          //     );
                          //   },
                          // ),

                          // StreamBuilder(
                          //   stream: missingDogs.snapshots(),
                          //   builder: (context, streamSnapshot) {
                          //     if (streamSnapshot.hasData) {
                          //       return ListView.builder(
                          //         itemCount: streamSnapshot.data.docs.length,
                          //         itemBuilder: (context, index) {
                          //           print(index);
                          //           final DocumentSnapshot documentSnapshot =
                          //               // streamSnapshot.data.docs[index];
                          //               streamSnapshot.data.docs(user.uid);
                          //           return GestureDetector(
                          //             onTap: () {
                          //               Navigator.push(
                          //                   context,
                          //                   MaterialPageRoute(
                          //                       builder: (context) => dogInfo()));
                          //             },
                          //             child:
                          //                 dataContainer(screen, documentSnapshot),
                          //           );
                          //           //   Card(
                          //           //   margin: EdgeInsets.all(10),
                          //           //   child: ListTile(
                          //           //     title: Text(documentSnapshot['name']),
                          //           //     subtitle: Text(documentSnapshot['price'].toString()),
                          //           //     trailing: SizedBox(
                          //           //       width: 100,
                          //           //       child: Row(
                          //           //         children: [
                          //           //           // Press this button to edit a single product
                          //           //           IconButton(
                          //           //               icon: Icon(Icons.edit),
                          //           //               onPressed: () =>
                          //           //                   _createOrUpdate(documentSnapshot)),
                          //           //           // This icon button is used to delete a single product
                          //           //           IconButton(
                          //           //               icon: Icon(Icons.delete),
                          //           //               onPressed: () =>
                          //           //                   _deleteProduct(documentSnapshot.id)),
                          //           //         ],
                          //           //       ),
                          //           //     ),
                          //           //   ),
                          //           // );
                          //         },
                          //       );
                          //     }
                          //
                          //     return Center(
                          //       child: CircularProgressIndicator(),
                          //     );
                          //   },
                          // ),
                          //     FutureBuilder(
                          //   future: listBuilder(),
                          //   builder: (context, snapshot) {
                          //     if (snapshot.hasData == null) {
                          //       return Container();
                          //     }
                          //     return ListView(
                          //       padding: const EdgeInsets.only(top: 20.0),
                          //       children: snapshot
                          //           .data((data) => _buildListItem(context, data))
                          //           .toList(),
                          //     );
                          //   },
                          // ),

                          // child: ListView.builder(
                          //     // itemCount: _notes.length,
                          //     scrollDirection: Axis.horizontal,
                          //     shrinkWrap: true,
                          //     itemCount: length,
                          //     itemBuilder: (context, int index) {
                          //       return GestureDetector(
                          //         onTap: () {
                          //           Navigator.push(
                          //               context,
                          //               MaterialPageRoute(
                          //                   builder: (context) => dogInfo()));
                          //         },
                          //         child: dataContainer(screen),
                          //       );
                          //     }),
                        ),
                        SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0),
                            boxShadow: [
                              BoxShadow(
                                color: shadowColor,
                                blurRadius: 5.0,
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Seen a dog that looks lost?',
                                style: GoogleFonts.poppins(
                                  color: themeColor,
                                  fontSize: screen.width / 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                width: screen.width / 1.8,
                                child: Text(
                                  'Report it and help get them home',
                                  style: GoogleFonts.poppins(
                                    fontSize: screen.width / 24.0,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Center(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                registerDog_1()));
                                  },
                                  child: Text(
                                    'ADD REPORT     ->',
                                    style: GoogleFonts.poppins(),
                                  ),
                                  style: ButtonStyle(
                                    // padding: MaterialStateProperty.all<EdgeInsets>(
                                    //     EdgeInsets.all(20.0)),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        side: BorderSide(
                                          color: themeColor,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ),
              ),
              // Container(
              //   padding:
              //       EdgeInsets.only(left: 10, top: 30, right: 10, bottom: 10),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.only(
              //       bottomLeft: Radius.circular(30),
              //       bottomRight: Radius.circular(30),
              //     ),
              //     color: Colors.white,
              //     boxShadow: [
              //       BoxShadow(
              //         color: shadowColor,
              //         blurRadius: 5.0,
              //       ),
              //     ],
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Image(
              //         image: AssetImage(
              //           'images/Dog_Tag-03.png',
              //         ),
              //         width: screen.width / 2,
              //       ),
              //       Row(
              //         children: [
              //           // IconButton(
              //           //   icon: Icon(Icons.chat_bubble_outline),
              //           //   color: themeColor,
              //           //   onPressed: () {
              //           //     Navigator.push(
              //           //         context,
              //           //         // MaterialPageRoute(builder: (context) => Inbox()));
              //           //         MaterialPageRoute(builder: (context) => Inbox()));
              //           //   },
              //           // ),
              //           IconButton(
              //             icon: Icon(Icons.menu),
              //             color: themeColor,
              //             onPressed: () =>
              //                 _scaffoldKey.currentState.openEndDrawer(),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //     child: InkWell(
  //       child: Row(
  //         children: <Widget>[
  //           Expanded(
  //             child: ListTile(
  //               leading: Text(
  //                 snapshot.data['type'],
  //                 style: TextStyle(
  //                   fontSize: 30,
  //                 ),
  //               ),
  //               title: Text(snapshot.data['description'],
  //                   style: TextStyle(
  //                     fontSize: 30,
  //                   )),
  //               subtitle: Text(snapshot.data['time'].toDate().toString(),
  //                   style: TextStyle(
  //                     fontSize: 15,
  //                   )),
  //               trailing: Text(snapshot.data['value'].toString(),
  //                   style: TextStyle(
  //                     fontSize: 25,
  //                   )),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Future listBuilder() async {
  //   final User user = await FirebaseAuth.instance.currentUser();
  //   final String uid = user.uid;
  //   List<DocumentSnapshot> list = [];
  //   Firestore.instance
  //       .collection('entries')
  //       .where("uid", isEqualTo: uid)
  //       .snapshots()
  //       .listen((data) => data.documents.forEach((doc) => list.add(doc)));
  //
  //   print("------------------------------------------------------------------");
  //   return list;
  // }
}
