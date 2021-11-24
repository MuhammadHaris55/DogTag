import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterdogtagapp/screens/appColors.dart';
import 'package:flutterdogtagapp/screens/myProfile.dart';
import 'package:flutterdogtagapp/stylingWidgets/button.dart';
import 'package:flutterdogtagapp/stylingWidgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfile extends StatefulWidget {
  Map<String, dynamic> userMap;

  EditProfile({
    this.userMap

  });
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var DogName = userMap['DogName'];
  var DogDescription=userMap['DogDescription'];
  //FOR DROPDOWN
  var owner;
  String dogBreed = 'Labrador Retriever';
  List breedlist = [
    'Labrador Retriever',
    'French Bulldog.',
    'Doberman Pinschers',
    ' German Shepherd',
    'Golden Retriever.',
    'Siberian Huskies',
    ' Poodle',
  ];

  //FOR IconButton
  bool selected = false;
  Icon first_icon = Icon(
    Icons.circle,
    semanticLabel: 'sajdgh',
    color: themeColor,
  );
  Icon second_icon = Icon(
    Icons.check_circle,
    color: themeColor,
  );

  //FOR RADIO BUTTON
  String selectedValue = 'Boy';

  //FOR DATA PASSING
  TextEditingController textEditingController = TextEditingController();
  String dogName;
  String dogGender;
  String dogColor;
  String dogDescription;

  final formKey = GlobalKey<FormState>();
  String validator(text) {
    if (text.isEmpty) return 'Please fill this field';
  }

  @override
  Widget build(BuildContext context) {
    userMap = widget.userMap;
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 25.0, right: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      color: Colors.black,
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Column(
                      children: [
                        Image(
                          width: screen.width / 2.0,
                          image: AssetImage(
                            'images/Dog_Tag-02.png',
                          ),
                        ),

                      ],
                    ),
                    IconButton(icon: Icon(Icons.help), onPressed: () {})
                  ],
                ),
              ),
              Container(
                width: screen.width / 1.1,
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Edit Your Profile',
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: screen.width / 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      // R_textFormField('My dog name is...'),
                      TextFormField(
                        cursorColor: Colors.black,
                        validator: (text) => validator(text),
                        initialValue: userMap['DogName'],
                        decoration: new InputDecoration(
                          labelText: 'My dog\'s name is...',
                          labelStyle: GoogleFonts.poppins(
                            fontWeight:FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        onChanged: (val) => userMap['DogName'] = val,
                      ),
                      //SENDING DATA ON NEXT PAGE
                      // TextField(
                      //   decoration: InputDecoration(labelText: 'Dog Name'),
                      //   onChanged: (val) => dogName = val,
                      // ),
                      SizedBox(height: 20.0),
                      Text('Is it a boy or a girl?',style: GoogleFonts.poppins(
                          fontWeight:FontWeight.bold ),),
                      SizedBox(height: 20.0),
                      buildRadios(),
                      // SizedBox(height: 20.0),
                      // Row(
                      //   children: [],
                      // ),
                      // Text('My dog\'s breed is...',style: GoogleFonts.poppins(
                      //     fontWeight:FontWeight.bold),),
                      SizedBox(height: 10.0),
                      TextFormField(
                        cursorColor: Colors.black,
                        validator: (text) => validator(text),
                        initialValue: userMap['DogBreed'],
                        decoration: new InputDecoration(
                          labelText: 'My dog\'s breed is...',
                          labelStyle: GoogleFonts.poppins(
                            fontWeight:FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        onChanged: (val) => userMap['DogBreed'] = val,
                      ),
                      // DropdownButton(
                      //   isExpanded: true,
                      //   hint: Text(
                      //     'Select your dog\'s breed',
                      //     textAlign: TextAlign.center,
                      //   ),
                      //   value: userMap['DogBreed'],
                      //   onChanged: (value) {
                      //     setState(() {
                      //       userMap['DogBreed'] = value;
                      //     });
                      //   },
                      //   items: breedlist.map((value) {
                      //     return DropdownMenuItem(
                      //       value: value,
                      //       child: Text(
                      //         value,
                      //       ),
                      //     );
                      //   }).toList(),
                      // ),
                      // Row(
                      //   children: [
                      //     IconButton(
                      //       icon: selected ? second_icon : first_icon,
                      //       onPressed: () {
                      //         setState(() {
                      //           selected = !selected;
                      //           if (selected == true) {
                      //             dogBreed = 'Don\'t Know';
                      //           }
                      //         });
                      //       },
                      //     ),
                      //     Text('I don\'t know my dog\'s breed'),
                      //   ],
                      // ),
                      SizedBox(height: 10.0),
                      // R_textFormField('My dog\'s color'),
                      TextFormField(
                        cursorColor: Colors.black,
                        validator: (text) => validator(text),
                        initialValue: userMap['DogColor'],
                        decoration: new InputDecoration(
                          labelText: 'My dog\'s color',
                          labelStyle: GoogleFonts.poppins(
                            fontWeight:FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        onChanged: (val) => userMap['DogColor'] = val,
                      ),
                      SizedBox(height: 20.0),
                      // R_textFormField('Description'),
                      TextFormField(
                        cursorColor: Colors.black,
                        validator: (text) => validator(text),
                        initialValue: userMap['DogDescription'],
                        decoration: new InputDecoration(
                          labelText: 'Description',
                          labelStyle: GoogleFonts.poppins(
                            fontWeight:FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        onChanged: (val) => userMap['DogDescription'] = val,
                      ),

                      SizedBox(height: 10.0),
                      ElevatedButton(
                        style: buttonDesign,
                        child: button_design(screen, "Update"),
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            uploadFile();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // builder: (context) => registerDog_2(
                                //   dog_Name: dogName,
                                // ),
                                builder: (context) => MyProfile(
                                  userMap: userMap,

                                ),
                              ),
                            );
                          }
                        },
                      ),
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

  //FOR RADIO BUTTON ---------------- START ----------------------------
  Widget buildRadios() => Row(
    children: [
      Flexible(
        fit: FlexFit.loose,
        child: RadioListTile<String>(
          value: 'Boy',
          activeColor: themeColor,
          groupValue: userMap['DogGender'],
          title: Text('Boy'),
          onChanged: (value) => setState(() => userMap['DogGender'] = value),
        ),
      ),
      Flexible(
        fit: FlexFit.tight,
        child: RadioListTile<String>(
          value: 'Girl',
          activeColor: themeColor,
          groupValue: userMap['DogGender'],
          title: Text('Girl'),
          onChanged: (value) => setState(() => userMap['DogGender'] = value),
        ),
      ),
      // Spacer(),
    ],
  );
//FOR RADIO BUTTON ---------------- END ----------------------------

  //
  // Future<void> update(Map data) async {
  //   final user = await FirebaseAuth.instance.currentUser;
  //   return FirebaseFirestore.instance.collection('Users').doc(user.uid).updateData(data);
  // }

Future uploadFile() async {


  User user = FirebaseAuth.instance.currentUser;

  FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .get()
      .then((value) {
     owner = value.data();
  });
  // User missingDogs = FirebaseAuth.instance.currentUser;

  //TO UPLOAD THE FORM
  final String _dogName =  userMap['DogName'];
  final String _dogGender = userMap['DogGender'];
  final String _dogBreed = userMap['DogBreed'];
  final String _dogColor = userMap['DogColor'];
  final String _dogDescription = userMap['DogDescription'];
  final String _dogSize = userMap['DogSize'];
  final String _dogImage = userMap['DogImage'];
  final String urlDownload = userMap['ImageUrl'];
  Timestamp createdAt = Timestamp.now();
  Timestamp updatedAt = Timestamp.now();

  // DocumentSnapshot dogDetails = await user.doc("userDetail").get();

  //trying to get id
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  await _firestore
      .collection('users')
  // .where("email", isEqualTo: _search.text)
  //     .where("name", isEqualTo: _search.text)
      .get()
      .then((value) {
    setState(() {
      // _search.clear();
      userMap = value.docs[0].data();
    });
  });

  //--------------------

  await FirebaseFirestore.instance
      .collection("dogsProfiles")
      .where("uid", isEqualTo: user.uid)
      .where("DogName", isEqualTo: DogName)
      .where("DogDescription", isEqualTo: DogDescription)
  // await FirebaseFirestore.instance.collection("users")
  // .doc("missingDogs")
  // .doc(user.uid)
  // .collection('dogsDetail')
  //     .doc()

      .get().then((value){
        print('IDPRINT');
        print(value.docs[0].id);
        print('IDPRINT');
  FirebaseFirestore.instance
        .collection("dogsProfiles")
    .doc(value.docs[0].id)
        .update({
      "DogName": _dogName,
      "DogGender": _dogGender,
      "DogBreed": _dogBreed,
      "DogColor": _dogColor,
      "DogDescription": _dogDescription,
      "DogSize": _dogSize,
      "DogImage": _dogImage,
      // "DogImage": fileName,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "uid": user.uid,
      "ImageUrl": urlDownload,
      "firstname": owner['firstname'],
      "lastname": owner['lastname'],
      "email": owner['email'],
      "phoneno": owner['phoneno'],
    }).catchError((e){print(e);});
  });
  //     .update({
  //   "DogName": _dogName,
  //   "DogGender": _dogGender,
  //   "DogBreed": _dogBreed,
  //   "DogColor": _dogColor,
  //   "DogDescription": _dogDescription,
  //   "DogSize": _dogSize,
  //   "DogImage": _dogImage,
  //   // "DogImage": fileName,
  //   "createdAt": createdAt,
  //   "updatedAt": updatedAt,
  //   "uid": user.uid,
  //   "ImageUrl": urlDownload,
  //   "firstname": owner['firstname'],
  //   "lastname": owner['lastname'],
  //   "email": owner['email'],
  //   "phoneno": owner['phoneno'],
  // }).catchError((e){print(e);});

  // print('Download-Link: $urlDownload');
}
  //
  //
  // getUserById() async {
  //
  //     await FirebaseFirestore.instance
  //         .collection('missingDogs')
  //     // .where("email", isEqualTo: _search.text)
  //         .where("uid", isEqualTo: _auth.currentUser.uid)
  //         .where("DogName", isEqualTo: DogName)
  //         .where("DogDescription", isEqualTo: DogDescription)
  //         .get().then((value) {
  //       setState(() {
  //         userMap = value.docs[0].data();
  //
  //       });
  //     });
  //   }
}