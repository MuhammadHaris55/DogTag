import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterdogtagapp/screens/allDogsProfile.dart';
import 'package:flutterdogtagapp/screens/appColors.dart';
import 'package:flutterdogtagapp/screens/home.dart';
import 'package:flutterdogtagapp/stylingWidgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutterdogtagapp/screens/editProfile.dart';

// final FirebaseAuth _auth = FirebaseAuth.instance;
// final CurrDogData = FirebaseFirestore.instance.collection('missingDogs');
// Map<String, dynamic> userMap;

class MyProfile extends StatefulWidget {
  Map<String, dynamic> userMap;
  MyProfile({this.userMap});

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  // @override
  // void initState() {
  //   getUserById();
  //   // TODO: implement initState
  //   super.initState();
  // }
  var owner;
  var userMap;
  @override
  Widget build(BuildContext context) {
    userMap = widget.userMap;
    final screen = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AllDogsProfile()));
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        title: Text(
          "My Profile",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: appbarColor,
        actions: [
          userMap == null
              ? Container()
              : IconButton(
              icon: Icon(Icons.edit),
              color: themeColor,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditProfile(userMap: userMap)));
              })
        ],
      ),
      body: userMap == null
          ? Center(
        child: Text('You didn\'t register any dog yet'),
      )
          : Container(
        // height: screen.height/1.0,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                color: Colors.grey,
                child: Center(
                  child: Image(
                    fit: BoxFit.fill,
                    height: screen.height / 2.5,
                    // width: screen.width/1.0,
                    image: NetworkImage(userMap != null
                        ? userMap['ImageUrl']
                        : 'https://i.insider.com/5484d9d1eab8ea3017b17e29?width=600&format=jpeg&auto=webp'),
                  ),
                ),
              ),
              Center(
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(height: screen.width / 1.4),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0),
                            boxShadow: [
                              BoxShadow(
                                color: shadowColor,
                                blurRadius: 5.0,
                              ),
                            ]),
                        width: screen.width / 1.2,
                        height: screen.width / 3.2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  userMap != null
                                      ? userMap['DogName']
                                      : 'Spike',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screen.width / 18,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  userMap != null
                                      ? userMap['DogGender']
                                      : '',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screen.width / 25,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                userMap['DogGender'] == 'Boy'
                                    ? Image(
                                  image: AssetImage(
                                    // 'images/male-icon.png' :
                                      'images/female-icon.png'),
                                )
                                    : Image(
                                  image: AssetImage(
                                    // 'images/male-icon.png' :
                                      'images/female-icon.png'),
                                ),
                              ],
                            ),
                            Divider(),
                            Container(
                              width: screen.width / 1.3,
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        userMap != null
                                            ? userMap['DogBreed']
                                            : '',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: screen.width / 32,
                                        ),
                                      ),
                                      Text(' Breed'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        userMap != null
                                            ? userMap['DogColor']
                                            : '',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: screen.width / 32,
                                        ),
                                      ),
                                      Text(' Color')
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: screen.width / 1.2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Description",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screen.width / 15.0)),
                            // SizedBox(height: 10.0),
                            Divider(),
                            Text(
                              userMap != null
                                  ? userMap['DogDescription']
                                  : 'Spike',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Center(
                        child: TextButton(
                          onPressed: () async {
                            if(userMap['status'] == 0){
                              print(userMap['status']);
                              addMydog();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));

                              final text =
                                  'Your dog added to lost dog list';
                              final snackBar = SnackBar(
                                content: Text(text),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }else{
                              final text =
                                  'Your dog is already added to lost dog list';
                              final snackBar = SnackBar(
                                content: Text(text),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          child: Text(
                            'Dog Lost',
                          ),
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(
                                horizontal: 25.0,
                                vertical: 10.0,
                              ),
                            ),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                Colors.black),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(
                                  color: themeColor,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  // getUserById() async {
  //
  //   await FirebaseFirestore.instance
  //       .collection('missingDogs')
  //   // .where("email", isEqualTo: _search.text)
  //       .where("uid", isEqualTo: _auth.currentUser.uid)
  //       .get().then((value) {
  //     setState(() {
  //       userMap = value.docs[0].data();
  //
  //     });
  //   });
  // }


  Future addMydog() async {
    User user = FirebaseAuth.instance.currentUser;
    Timestamp createdAt;
    Timestamp updatedAt;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((value) async {
      owner = await value.data();
    }).then((value) async {

      setState(() {
        createdAt = Timestamp.now();
        updatedAt = Timestamp.now();
      });

      //---------------------------------------------------

      await FirebaseFirestore.instance
          .collection("dogsProfiles")
          .where("uid", isEqualTo: user.uid)
          .where("DogName", isEqualTo: userMap['DogName'])
          .where("DogDescription", isEqualTo: userMap['DogDescription'])

          .get().then((value){
        print('IDPRINT');
        print(value.docs[0].id);
        print('IDPRINT');
        FirebaseFirestore.instance
            .collection("dogsProfiles")
            .doc(value.docs[0].id)
            .update({
          "DogName": userMap['DogName'],
          "DogGender": userMap['DogGender'],
          "DogBreed": userMap['DogBreed'],
          "DogColor": userMap['DogColor'],
          "DogDescription": userMap['DogDescription'],
          "DogSize": userMap['DogSize'],
          // "DogImage": _dogImage,
          "DogImage": userMap['DogImage'],
          "createdAt": createdAt,
          "updatedAt": updatedAt,
          "uid": user.uid,
          "ImageUrl": userMap['ImageUrl'],
          "firstname": owner['firstname'],
          "lastname": owner['lastname'],
          "email": owner['email'],
          "phoneno": owner['phoneno'],
          "status": 1,
        }).catchError((e){print(e);});
      });



      //---------------------------------------------------

    await FirebaseFirestore.instance
    // .collection("missingDogs")
        .collection("missingDogs")
    // await FirebaseFirestore.instance.collection("users")
    // .doc("missingDogs")
    // .doc(user.uid)
    // .collection('dogsDetail')
        .doc()
        .set({
      "DogName": userMap['DogName'],
      "DogGender": userMap['DogGender'],
      "DogBreed": userMap['DogBreed'],
      "DogColor": userMap['DogColor'],
      "DogDescription": userMap['DogDescription'],
      "DogSize": userMap['DogSize'],
      // "DogImage": _dogImage,
      "DogImage": userMap['DogImage'],
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "uid": user.uid,
      "ImageUrl": userMap['ImageUrl'],
      "firstname": owner['firstname'],
      "lastname": owner['lastname'],
      "email": owner['email'],
      "phoneno": owner['phoneno'],
      "zipcode": owner['zipcode'],
    });
    });

    // Timestamp createdAt = Timestamp.now();
    // Timestamp updatedAt = Timestamp.now();
    //
    // await FirebaseFirestore.instance
    //     // .collection("missingDogs")
    //     .collection("newDog")
    // // await FirebaseFirestore.instance.collection("users")
    // // .doc("missingDogs")
    // // .doc(user.uid)
    // // .collection('dogsDetail')
    //     .doc()
    //     .set({
    //   "DogName": userMap['DogName'],
    //   "DogGender": userMap['DogGender'],
    //   "DogBreed": userMap['DogBreed'],
    //   "DogColor": userMap['DogColor'],
    //   "DogDescription": userMap['DogDescription'],
    //   "DogSize": userMap['DogSize'],
    //   // "DogImage": _dogImage,
    //   "DogImage": userMap['DogImage'],
    //   "createdAt": createdAt,
    //   "updatedAt": updatedAt,
    //   "uid": user.uid,
    //   "ImageUrl": userMap['ImageUrl'],
    //   "firstname": owner['firstname'],
    //   "lastname": owner['lastname'],
    //   "email": owner['email'],
    //   "phoneno": owner['phoneno'],
    // });

    // print('Download-Link: $urlDownload');
  }

}
