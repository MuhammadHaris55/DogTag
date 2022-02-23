import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterdogtagapp/controller/firebase_product_controller.dart';
import 'package:flutterdogtagapp/screens/appColors.dart';
import 'package:flutterdogtagapp/stylingWidgets/drawer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class dogInfo extends StatelessWidget {
  // const dogInfo({Key key}) : super(key: key);

  Future<void> _launched;
//TO MAKE CALL
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //TO TEXT
  Future<void> _textMe(String uri) async {
    // Android
    // const uri = 'sms:+39 348 060 888?body=hello%20there';
    // if (await canLaunch(uri)) {
    if (Platform.isAndroid) {
      await launch(uri);
    } else
    // iOS
    // const uri = 'sms:0039-222-060-888?body=hello%20there';
    if (Platform.isIOS) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  final ProductController productController = Get.find();
  final int index;
  dogInfo({
    Key key,
    this.index,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
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
        color: homeColor,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor,
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(
                        top: 20.0,
                        // top: screen.width / 5.0,
                        bottom: 10.0),
                    child: Column(
                      children: [
                        Container(
                          height: screen.width,
                          child: Image(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              // documentSnapshot['ImageUrl'] != null
                              productController.products[index].ImageUrl ??
                                  // documentSnapshot != null
                                  //     ? documentSnapshot['ImageUrl']:
                                  'https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_960_720.jpg',
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          width: screen.width / 1.1,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    // documentSnapshot != null
                                    //     ? documentSnapshot['DogName']
                                    //     :
                                    productController.products[index].DogName ??
                                        'Zoey, ',
                                    style: GoogleFonts.poppins(
                                      color: themeColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: screen.width / 18,
                                    ),
                                  ),
                                  Text(
                                    // documentSnapshot['DogGender'] == 'Boy'
                                    // documentSnapshot == 'Boy'
                                    //     ? ', Male'
                                    //     :
                                    ', ${productController.products[index].DogGender}' ??
                                        ', Female',
                                    style: GoogleFonts.poppins(
                                      color: themeColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: screen.width / 18,
                                    ),
                                  ),
                                  Spacer(),
                                  Image(
                                    // image: documentSnapshot['DogGender'] ==
                                    image: productController
                                                .products[index].DogGender ==
                                            'Boy'
                                        ? AssetImage(
                                            'images/male-icon.png',
                                          )
                                        : AssetImage(
                                            'images/female-icon.png',
                                          ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                width: screen.width / 1.3,
                                child: Text(
                                  // documentSnapshot['DogDescription'] != null
                                  // documentSnapshot != null
                                  //     ? documentSnapshot['DogDescription']
                                  //     :
                                  productController
                                          .products[index].DogDescription ??
                                      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod',
                                  style: GoogleFonts.poppins(
                                    fontSize: screen.width / 28,
                                  ),
                                ),
                              ),
                              // SizedBox(height: 10.0),
                              // Row(
                              //   children: [
                              //     Icon(
                              //       Icons.location_on_outlined,
                              //       color: Colors.amberAccent,
                              //     ),
                              //     // Text(
                              //     //   documentSnapshot['address'] != null
                              //     //       ? documentSnapshot['address']
                              //     //       : 'No Input From User',
                              //     // ),
                              //     // Text(
                              //     //   getUserData['address'] != null
                              //     //       ? getUserData['address']
                              //     //       : 'No Input From User',
                              //     //   style: GoogleFonts.poppins(),
                              //     // ),
                              //   ],
                              // ),
                              SizedBox(height: 20.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: screen.width / 1.1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Dog details',
                          style: GoogleFonts.poppins(
                            color: themeColor,
                            fontWeight: FontWeight.bold,
                            fontSize: screen.width / 18,
                          ),
                        ),
                        // R_textFormField('Description'),
                        SizedBox(height: 10),
                        TextFormField(
                          readOnly: true,
                          initialValue:
                              productController.products[index].DogSize,
                          cursorColor: Colors.black,
                          decoration: new InputDecoration(
                            labelText: 'Size',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Gender',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Image(
                              // image: documentSnapshot['DogGender'] == 'Boy'
                              image:
                                  productController.products[index].DogGender ==
                                          'Boy'
                                      ? AssetImage(
                                          'images/male-icon.png',
                                        )
                                      : AssetImage(
                                          'images/female-icon.png',
                                        ),
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              // documentSnapshot != null
                              //     ? documentSnapshot['DogGender']
                              //     :
                              productController.products[index].DogGender ?? '',
                            ),
                          ],
                        ),

                        // Container(
                        //   width: screen.width / 1.3,
                        //   child: Row(
                        //     mainAxisAlignment:
                        //         MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text(
                        //         'Dog Size',
                        //         style: TextStyle(
                        //           fontSize: screen.width / 28,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //       Text(
                        //         documentSnapshot['DogSize'] != null
                        //             ? documentSnapshot['DogSize']
                        //             : 'Not Define',
                        //         style: TextStyle(
                        //           fontSize: screen.width / 28,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(height: 30),

                        Text(
                          'Owner\'s Details',
                          style: GoogleFonts.poppins(
                            color: themeColor,
                            fontWeight: FontWeight.bold,
                            fontSize: screen.width / 15,
                          ),
                        ),

                        SizedBox(height: 10),
                        // StreamBuilder(
                        //     stream: FirebaseFirestore.instance
                        //         .collection('users')
                        //         // .doc(user.uid)
                        //         .doc(documentSnapshot['uid'])
                        //         .snapshots(),
                        //     builder: (context, snapshot) {
                        //       if (!snapshot.hasData) {
                        //         return new Text("Loading");
                        //       }
                        //       getUserData = snapshot.data;
                        //       return TextFormField(
                        //         readOnly: true,
                        //         initialValue: (getUserData['firstname']),
                        //         cursorColor: Colors.black,
                        //         decoration: new InputDecoration(
                        //           labelText: 'First Name',
                        //           labelStyle: TextStyle(
                        //             color: Colors.black,
                        //             fontWeight: FontWeight.bold,
                        //           ),
                        //         ),
                        //       );
                        //     }),
                        TextFormField(
                          readOnly: true,
                          initialValue:
                              productController.products[index].firstname,
                          cursorColor: Colors.black,
                          decoration: new InputDecoration(
                            labelText: 'First Name',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

                        TextFormField(
                          readOnly: true,
                          initialValue:
                              productController.products[index].lastname,
                          cursorColor: Colors.black,
                          decoration: new InputDecoration(
                            labelText: 'Last Name',
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          readOnly: true,
                          initialValue: productController.products[index].email,
                          cursorColor: Colors.black,
                          decoration: new InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        // // TextFormField(
                        // //   readOnly: true,
                        // //   initialValue: (documentSnapshot['zipcode']),
                        // //   cursorColor: Colors.black,
                        // //   decoration: new InputDecoration(
                        // //     labelText: 'Zip Code',
                        // //     labelStyle: TextStyle(
                        // //       color: Colors.black,
                        // //     ),
                        // //   ),
                        // // ),
                        // SizedBox(height: 10),
                        TextFormField(
                          readOnly: true,
                          initialValue:
                              productController.products[index].phoneno,
                          cursorColor: Colors.black,
                          decoration: new InputDecoration(
                            labelText: 'Phone No',
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(
                                child: TextButton(
                                  onPressed: () async {
                                    // setState(() {
                                    //   _launched =
                                    _textMe('sms:' +
                                        (productController
                                            .products[index].phoneno));
                                    // });
                                  },
                                  child: Text(
                                    'Text owner',
                                  ),
                                  style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.symmetric(
                                        horizontal: 20.0,
                                        vertical: 10.0,
                                      ),
                                    ),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        side: BorderSide(
                                          color: themeColor,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: TextButton(
                                  onPressed: () async {
                                    // setState(() {
                                    //   _launched =
                                    _makePhoneCall('tel:' +
                                        (productController
                                            .products[index].phoneno));
                                    // });
                                  },
                                  child: Text(
                                    'Call owner',
                                  ),
                                  style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.symmetric(
                                        horizontal: 20.0,
                                        vertical: 10.0,
                                      ),
                                    ),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
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
                        // Center(
                        //   child: TextButton(
                        //     onPressed: () {},
                        //     child: Text(
                        //       'Chats',
                        //     ),
                        //     style: ButtonStyle(
                        //       padding:
                        //           MaterialStateProperty.all<EdgeInsets>(
                        //         EdgeInsets.symmetric(
                        //           horizontal: 25.0,
                        //           vertical: 10.0,
                        //         ),
                        //       ),
                        //       foregroundColor:
                        //           MaterialStateProperty.all<Color>(
                        //               Colors.black),
                        //       shape: MaterialStateProperty.all<
                        //           RoundedRectangleBorder>(
                        //         RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(20.0),
                        //           side: BorderSide(
                        //             color: themeColor,
                        //             width: 2,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
// }

// User user = FirebaseAuth.instance.currentUser;
// final getText = FirebaseFirestore.instance.collection('users');
// var getUserData;
// // Map<String, dynamic> getUserData;
//
// class dogInfo extends StatefulWidget {
//   final ProductController productController = Get.put(ProductController());
//   // final ProductController productController = Get.find();
//   final int index;
//   dogInfo({
//     Key key,
//     this.index,
//   }) : super(key: key);
//
//   // final ProductController productController = Get.find();
//   // final index;
//   // dogInfo({
//   //   this.index,
//   // index});
//
//   @override
//   _dogInfoState createState() => _dogInfoState();
// }
//
// class _dogInfoState extends State<dogInfo> {
//   Future<void> _launched;
//
//   Future<void> _makePhoneCall(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     print('FirstName');
//
//     // Or call your function here
//
//     // //To get user data
//     // FirebaseFirestore _firestore = FirebaseFirestore.instance;
//     // // try {
//     // await _firestore
//     //     .collection('users')
//     //     // .where("email", isEqualTo: _search.text)
//     //     .where("uid", isEqualTo: widget.detail['uid'].text)
//     //     .get()
//     //     .then((value) {
//     //   setState(() {
//     //     // _search.clear();
//     //     userMap = value.docs[0].data();
//     //     // isLoading = false;
//     //   });
//     // });
//     // // ;}catch (e) {
//     // //     .catchError((e) {
//     // // setState(() {
//     // // isLoading = false;
//     // // });
//     // // print(e);
//     // // });
//   }
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context) {
//     final index = widget.index;
//     final screen = MediaQuery.of(context).size;
//     FirebaseFirestore.instance.collection('users').doc(
//         // productCon
//         documentSnapshot['uid']).get().then((value) {
//       getUserData = value;
//     });
//     return Scaffold(
//       key: _scaffoldKey,
//       endDrawer: MainDrawer(),
//       body: Container(
//         color: homeColor,
//         child: Stack(
//           children: [
//             SizedBox(height: 50),
//             Align(
//               alignment: Alignment.center,
//               child: SingleChildScrollView(
//                 child: Container(
//                   child: Column(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(30),
//                             bottomRight: Radius.circular(30),
//                           ),
//                           color: Colors.white,
//                           boxShadow: [
//                             BoxShadow(
//                               color: shadowColor,
//                               blurRadius: 15,
//                             ),
//                           ],
//                         ),
//                         margin: EdgeInsets.only(
//                             top: screen.width / 5.0, bottom: 10.0),
//                         child: Column(
//                           children: [
//                             Container(
//                               height: screen.width,
//                               child: Image(
//                                 fit: BoxFit.fill,
//                                 image: NetworkImage(
//                                   // documentSnapshot['ImageUrl'] != null
//                                   documentSnapshot != null
//                                       ? documentSnapshot['ImageUrl']
//                                       : 'https://cdn.pixabay.com/photo/2017/09/25/13/12/dog-2785074_960_720.jpg',
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 10.0),
//                             Container(
//                               width: screen.width / 1.1,
//                               padding: EdgeInsets.symmetric(horizontal: 10.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Text(
//                                         // documentSnapshot['DogName'] != null
//                                         documentSnapshot != null
//                                             ? documentSnapshot['DogName']
//                                             : 'Zoey, ',
//                                         style: GoogleFonts.poppins(
//                                           color: themeColor,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: screen.width / 18,
//                                         ),
//                                       ),
//                                       Text(
//                                         // documentSnapshot['DogGender'] == 'Boy'
//                                         documentSnapshot == 'Boy'
//                                             ? ', Male'
//                                             : ', Female',
//                                         style: GoogleFonts.poppins(
//                                           color: themeColor,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: screen.width / 18,
//                                         ),
//                                       ),
//                                       Spacer(),
//                                       Image(
//                                         // image: documentSnapshot['DogGender'] ==
//                                         image: documentSnapshot == 'Boy'
//                                             ? AssetImage(
//                                                 'images/male-icon.png',
//                                               )
//                                             : AssetImage(
//                                                 'images/female-icon.png',
//                                               ),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: 10.0),
//                                   Container(
//                                     width: screen.width / 1.3,
//                                     child: Text(
//                                       // documentSnapshot['DogDescription'] != null
//                                       documentSnapshot != null
//                                           ? documentSnapshot['DogDescription']
//                                           : 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod',
//                                       style: GoogleFonts.poppins(
//                                         fontSize: screen.width / 28,
//                                       ),
//                                     ),
//                                   ),
//                                   // SizedBox(height: 10.0),
//                                   // Row(
//                                   //   children: [
//                                   //     Icon(
//                                   //       Icons.location_on_outlined,
//                                   //       color: Colors.amberAccent,
//                                   //     ),
//                                   //     // Text(
//                                   //     //   documentSnapshot['address'] != null
//                                   //     //       ? documentSnapshot['address']
//                                   //     //       : 'No Input From User',
//                                   //     // ),
//                                   //     // Text(
//                                   //     //   getUserData['address'] != null
//                                   //     //       ? getUserData['address']
//                                   //     //       : 'No Input From User',
//                                   //     //   style: GoogleFonts.poppins(),
//                                   //     // ),
//                                   //   ],
//                                   // ),
//                                   SizedBox(height: 20.0),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width: screen.width / 1.1,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(height: 20),
//                             Text(
//                               'Dog details',
//                               style: GoogleFonts.poppins(
//                                 color: themeColor,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: screen.width / 18,
//                               ),
//                             ),
//                             // R_textFormField('Description'),
//                             SizedBox(height: 10),
//                             TextFormField(
//                               readOnly: true,
//                               initialValue: (documentSnapshot['DogSize']),
//                               cursorColor: Colors.black,
//                               decoration: new InputDecoration(
//                                 labelText: 'Size',
//                                 labelStyle: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 20),
//                             Text(
//                               'Gender',
//                               style: GoogleFonts.poppins(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(height: 20),
//                             Row(
//                               children: [
//                                 Image(
//                                   // image: documentSnapshot['DogGender'] == 'Boy'
//                                   image: documentSnapshot == 'Boy'
//                                       ? AssetImage(
//                                           'images/male-icon.png',
//                                         )
//                                       : AssetImage(
//                                           'images/female-icon.png',
//                                         ),
//                                 ),
//                                 SizedBox(width: 5.0),
//                                 Text(
//                                   documentSnapshot != null
//                                       ? documentSnapshot['DogGender']
//                                       : '',
//                                 ),
//                               ],
//                             ),
//
//                             // Container(
//                             //   width: screen.width / 1.3,
//                             //   child: Row(
//                             //     mainAxisAlignment:
//                             //         MainAxisAlignment.spaceBetween,
//                             //     children: [
//                             //       Text(
//                             //         'Dog Size',
//                             //         style: TextStyle(
//                             //           fontSize: screen.width / 28,
//                             //           fontWeight: FontWeight.bold,
//                             //         ),
//                             //       ),
//                             //       Text(
//                             //         documentSnapshot['DogSize'] != null
//                             //             ? documentSnapshot['DogSize']
//                             //             : 'Not Define',
//                             //         style: TextStyle(
//                             //           fontSize: screen.width / 28,
//                             //         ),
//                             //       ),
//                             //     ],
//                             //   ),
//                             // ),
//                             SizedBox(height: 30),
//
//                             Text(
//                               'Owner\'s Details',
//                               style: GoogleFonts.poppins(
//                                 color: themeColor,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: screen.width / 15,
//                               ),
//                             ),
//
//                             SizedBox(height: 10),
//                             // StreamBuilder(
//                             //     stream: FirebaseFirestore.instance
//                             //         .collection('users')
//                             //         // .doc(user.uid)
//                             //         .doc(documentSnapshot['uid'])
//                             //         .snapshots(),
//                             //     builder: (context, snapshot) {
//                             //       if (!snapshot.hasData) {
//                             //         return new Text("Loading");
//                             //       }
//                             //       getUserData = snapshot.data;
//                             //       return TextFormField(
//                             //         readOnly: true,
//                             //         initialValue: (getUserData['firstname']),
//                             //         cursorColor: Colors.black,
//                             //         decoration: new InputDecoration(
//                             //           labelText: 'First Name',
//                             //           labelStyle: TextStyle(
//                             //             color: Colors.black,
//                             //             fontWeight: FontWeight.bold,
//                             //           ),
//                             //         ),
//                             //       );
//                             //     }),
//                             TextFormField(
//                               readOnly: true,
//                               initialValue: (documentSnapshot['firstname']),
//                               cursorColor: Colors.black,
//                               decoration: new InputDecoration(
//                                 labelText: 'First Name',
//                                 labelStyle: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 10),
//
//                             TextFormField(
//                               readOnly: true,
//                               initialValue: (documentSnapshot['lastname']),
//                               cursorColor: Colors.black,
//                               decoration: new InputDecoration(
//                                 labelText: 'Last Name',
//                                 labelStyle: TextStyle(
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 10),
//                             TextFormField(
//                               readOnly: true,
//                               initialValue: (documentSnapshot['email']),
//                               cursorColor: Colors.black,
//                               decoration: new InputDecoration(
//                                 labelText: 'Email',
//                                 labelStyle: TextStyle(
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 10),
//                             // // TextFormField(
//                             // //   readOnly: true,
//                             // //   initialValue: (documentSnapshot['zipcode']),
//                             // //   cursorColor: Colors.black,
//                             // //   decoration: new InputDecoration(
//                             // //     labelText: 'Zip Code',
//                             // //     labelStyle: TextStyle(
//                             // //       color: Colors.black,
//                             // //     ),
//                             // //   ),
//                             // // ),
//                             // SizedBox(height: 10),
//                             TextFormField(
//                               readOnly: true,
//                               initialValue: (documentSnapshot['phoneno']),
//                               cursorColor: Colors.black,
//                               decoration: new InputDecoration(
//                                 labelText: 'Phone No',
//                                 labelStyle: TextStyle(
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 20),
//                             Center(
//                               child: TextButton(
//                                 onPressed: () async {
//                                   setState(() {
//                                     _launched = _makePhoneCall(
//                                         'tel:' + (documentSnapshot['phoneno']));
//                                   });
//                                 },
//                                 // },
//                                 child: Text(
//                                   'Contact owner',
//                                 ),
//                                 style: ButtonStyle(
//                                   padding:
//                                       MaterialStateProperty.all<EdgeInsets>(
//                                     EdgeInsets.symmetric(
//                                       horizontal: 25.0,
//                                       vertical: 10.0,
//                                     ),
//                                   ),
//                                   foregroundColor:
//                                       MaterialStateProperty.all<Color>(
//                                           Colors.black),
//                                   shape: MaterialStateProperty.all<
//                                       RoundedRectangleBorder>(
//                                     RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(20.0),
//                                       side: BorderSide(
//                                         color: themeColor,
//                                         width: 2,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             // Center(
//                             //   child: TextButton(
//                             //     onPressed: () {},
//                             //     child: Text(
//                             //       'Chats',
//                             //     ),
//                             //     style: ButtonStyle(
//                             //       padding:
//                             //           MaterialStateProperty.all<EdgeInsets>(
//                             //         EdgeInsets.symmetric(
//                             //           horizontal: 25.0,
//                             //           vertical: 10.0,
//                             //         ),
//                             //       ),
//                             //       foregroundColor:
//                             //           MaterialStateProperty.all<Color>(
//                             //               Colors.black),
//                             //       shape: MaterialStateProperty.all<
//                             //           RoundedRectangleBorder>(
//                             //         RoundedRectangleBorder(
//                             //           borderRadius: BorderRadius.circular(20.0),
//                             //           side: BorderSide(
//                             //             color: themeColor,
//                             //             width: 2,
//                             //           ),
//                             //         ),
//                             //       ),
//                             //     ),
//                             //   ),
//                             // ),
//                             SizedBox(height: 20),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.topCenter,
//               child: Container(
//                 padding:
//                     EdgeInsets.only(left: 10, top: 30, right: 10, bottom: 10),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(30),
//                       bottomRight: Radius.circular(30),
//                     ),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: shadowColor,
//                         blurRadius: 5.0,
//                       ),
//                     ]),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Image(
//                       image: AssetImage(
//                         'images/Dog_Tag-03.png',
//                       ),
//                       width: screen.width / 2,
//                     ),
//                     Row(
//                       children: [
//                         // IconButton(
//                         //     icon: Icon(Icons.chat_bubble_outline),
//                         //     color: themeColor,
//                         //     onPressed: () {
//                         //       Navigator.push(
//                         //           context,
//                         //           MaterialPageRoute(
//                         //               builder: (context) => Inbox()));
//                         //     }),
//                         IconButton(
//                           icon: Icon(Icons.menu),
//                           color: themeColor,
//                           onPressed: () {
//                             _scaffoldKey.currentState.openEndDrawer();
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
}
// List getTexts() {
//   child:
//   StreamBuilder(
//     // stream: dogsDetail.snapshots(),
//     stream: getText.snapshots(),
//     // stream: userRef.snapshots(),
//     builder: (context, streamSnapshot) {
//       if (streamSnapshot.hasData) {
//         return ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: streamSnapshot.data.docs.length,
//           itemBuilder: (context, index) {
//             final DocumentSnapshot documentSnapshot =
//                 streamSnapshot.data.docs[index];
//             return GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => dogInfo(
//                       index: documentSnapshot,
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         );
//       }
//
//       return Center(
//         child: Text('No data found'),
//         // CircularProgressIndicator(),
//       );
//     },
//   );
// }
