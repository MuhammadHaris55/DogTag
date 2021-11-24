import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterdogtagapp/screens/allDogsProfile.dart';
import 'package:flutterdogtagapp/screens/appColors.dart';
import 'package:flutterdogtagapp/screens/blogPage.dart';
import 'package:flutterdogtagapp/screens/contactUs.dart';
import 'package:flutterdogtagapp/screens/dogTagMission.dart';
import 'package:flutterdogtagapp/screens/home.dart';
import 'package:flutterdogtagapp/screens/inbox.dart';
import 'package:flutterdogtagapp/screens/login.dart';
import 'package:flutterdogtagapp/screens/myProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterdogtagapp/screens/privacyPolicy.dart';
import 'package:flutterdogtagapp/screens/termsAndConditions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final CurrDogData = FirebaseFirestore.instance.collection('dogsProfiles');
Map<String, dynamic> userMap;
var userDogs = [];



class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  void initState() {
    // getUsers();
    getUserById();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Drawer(
      child: Container(
        padding: EdgeInsets.only(top: 30, left: 15),
        color: themeColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: screen.width / 1.3,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: userMap == null
                        ? AssetImage('images/dog-profile.png')
                        : NetworkImage(
                            userMap['ImageUrl'],
                          ),
                    backgroundColor: Colors.white,
                    radius: 25,
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // _auth.currentUser.displayName,
                          userMap != null ? userMap['DogName'] : 'Spike',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1,
                          ),
                          maxLines: 1,
                        ),
                        Text(
                          _auth.currentUser.email != null
                              ? _auth.currentUser.email
                              : 'Lorem ipsum',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            letterSpacing: 1,
                          ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    iconSize: 50,
                    icon: Icon(
                      Icons.cancel_sharp,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            Container(
              width: screen.width / 1.8,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                child: drawerIconRow('Home'),
              ),
            ),
            Container(
              width: screen.width / 1.8,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Inbox(
                                image: userMap == null
                                    ? null
                                    : userMap['ImageUrl'],
                              )));
                },
                child: drawerIconRow('Inbox'),
              ),
            ),
            Container(
              width: screen.width / 1.8,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      // MaterialPageRoute(
                      //     builder: (context) => MyProfile(
                      //           userMap: userMap,
                      //         )));
                      MaterialPageRoute(
                          builder: (context) => AllDogsProfile(
                            userDogs: userDogs,
                          )));
                },
                child: drawerIconRow('My dogs'),
              ),
            ),
            Container(
              width: screen.width / 1.8,
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BlogPage()));
                },
                child: drawerRow('Blog Page'),
              ),
            ),
            Divider(
              thickness: 2.0,
              color: Colors.black,
              endIndent: screen.width / 8,
            ),
            Container(
              width: screen.width / 1.8,
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DogTagMission()));
                },
                child: drawerRow('The Dog Tag Mission'),
              ),
            ),
            Container(
              width: screen.width / 1.8,
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ContactUs()));
                },
                child: drawerRow('Contact us'),
              ),
            ),
            Container(
              width: screen.width / 1.8,
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PrivacyPolicy()));
                },
                child: drawerRow('Privacy policy'),
              ),
            ),
            Container(
              width: screen.width / 1.8,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TermsAndConditions()));
                },
                child: drawerRow('Term and conditions'),
              ),
            ),
            Divider(
              thickness: 2.0,
              color: Colors.black,
              endIndent: screen.width / 8,
            ),
            Container(
              width: screen.width / 1.8,
              child: TextButton(
                onPressed: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  await pref.clear();
                  // Navigator.pushReplacement(context,
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Login()),
                      (route) => false);
                  userMap = null;

                },
                child: drawerRow('Log out'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getUserById() async {
    setState(() {
      userDogs = [];
    });
    await FirebaseFirestore.instance
        .collection('dogsProfiles')
    // .where("email", isEqualTo: _search.text)
        .where("uid", isEqualTo: _auth.currentUser.uid)
        .get()
        .then((value) {
          value.docs.forEach((element) {
            // userMap = element.data();
            // userDogs.add(userMap);
            setState(() {
              userMap = element.data();
              // userMap = value.docs[0].data();
              userDogs.add(userMap);
            });
          });
          setState(() {
            userMap = userDogs.first;
          });
      // print(userMap);
      print(userDogs);
      print(userDogs.length);
    });
  }
}
