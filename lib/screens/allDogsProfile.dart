import 'package:flutterdogtagapp/screens/appColors.dart';
import 'package:flutterdogtagapp/screens/home.dart';
import 'package:flutterdogtagapp/screens/myProfile.dart';
import 'package:flutterdogtagapp/stylingWidgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutterdogtagapp/screens/editProfile.dart';

// final FirebaseAuth _auth = FirebaseAuth.instance;
// final CurrDogData = FirebaseFirestore.instance.collection('missingDogs');
// Map<String, dynamic> userMap;

class AllDogsProfile extends StatefulWidget {
  // Map<String, dynamic> userMap;
  // AllDogsProfile({this.userMap});
  var userDogs;
  AllDogsProfile({this.userDogs});

  @override
  _AllDogsProfileState createState() => _AllDogsProfileState();
}

class _AllDogsProfileState extends State<AllDogsProfile> {
  // @override
  // void initState() {
  //   getUserById();
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        title: Text(
          "My Dogs",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: appbarColor,
        // actions: [
        //   userMap == null
        //       ? Container()
        //       : IconButton(
        //           icon: Icon(Icons.edit),
        //           color: themeColor,
        //           onPressed: () {
        //             Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                     builder: (context) =>
        //                         EditProfile(userMap: userMap)));
        //           })
        // ],
      ),
      body: userMap == null
          ? Center(
              child: Text('You didn\'t register any dog yet'),
            )
          : Container(
              // height: screen.height/1.0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                child: ListView.builder(
                    // scrollDirection: Axis.horizontal,
                    itemCount: userDogs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyProfile(
                                userMap: userDogs[index],
                              ),
                            ),
                          );
                        },
                        child: Container(
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
                                height: screen.width / 1.5,
                                child: Image(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    userDogs[index]['ImageUrl'] ??
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
                                          userDogs[index]['DogName'] ??
                                              'Zoey, ',
                                          style: GoogleFonts.poppins(
                                            color: themeColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: screen.width / 18,
                                          ),
                                        ),
                                        Text(
                                          ', ${userDogs[index]['DogGender']}' ??
                                              ', Female',
                                          style: GoogleFonts.poppins(
                                            color: themeColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: screen.width / 18,
                                          ),
                                        ),
                                        Spacer(),
                                        Image(
                                          image: userDogs[index]['DogGender'] ==
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
                                        userDogs[index]['DogDescription'] ??
                                            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod',
                                        style: GoogleFonts.poppins(
                                          fontSize: screen.width / 28,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20.0),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
    );
  }
}
