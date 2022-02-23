import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterdogtagapp/screens/appColors.dart';
import 'package:flutterdogtagapp/screens/dogConfirmation.dart';
import 'package:flutterdogtagapp/stylingWidgets/button.dart';
import 'package:image_picker/image_picker.dart';

class registerDog_3 extends StatefulWidget {
  final String dogName;
  final String dogGender;
  final String dogBreed;
  final String dogColor;
  final String dogDescription;
  final String dogSize;

  registerDog_3({
    this.dogName,
    this.dogGender,
    this.dogBreed,
    this.dogColor,
    this.dogDescription,
    this.dogSize,
  });

  @override
  _registerDog_3State createState() => _registerDog_3State();
}

class _registerDog_3State extends State<registerDog_3> {
//FUNCTIONS AND VARIABLES TO CHOOSE AND CLICK IMAGE  AND IT ON FIRESTORE------------ STARTS -----------------------
  File dogImage = null;
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    setState(() {
      dogImage = File(pickedFile.path);
    });
  }

  Future clickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      dogImage = File(pickedFile.path);
    });
  }

//TO UPLOAD IMAGE ON FIRESTORE
// Future uploadImageToFirebase(BuildContext context) async {
//   String fileName = basename(dogImage.path);
//   StorageReference firebaseStorageRef =
//       FirebaseStorage,instance.ref().child('uploads/$fileName');
//   StorageUploadTask uploadTask = firebaseStorageRef.putFile(dogImage);
//   StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
//   taskSnapshot.ref.getDownloadURL().then(
//   (value) => print("Done: $value"),
//   );
// }

//FUNCTIONS AND VARIABLES TO CHOOSE AND CLICK IMAGE  AND IT ON FIRESTORE ------------ ENDS -----------------------

  @override
  Widget build(BuildContext context) {
    String dogName = widget.dogName;
    String dogGender = widget.dogGender;
    String dogBreed = widget.dogBreed;
    String dogColor = widget.dogColor;
    String dogDescription = widget.dogDescription;
    String dogSize = widget.dogSize;

    final screen = MediaQuery.of(context).size;
    return Scaffold(
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
                        Image(
                          image: AssetImage('images/reg_3.png'),
                        ),
                        Text(
                          'steps 3 of 3',
                          style: TextStyle(
                            fontSize: screen.width / 35,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.help,
                          color: Colors.white,
                        ),
                        onPressed: () {})
                  ],
                ),
              ),
              Container(
                width: screen.width / 1.1,
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        // 'Show us what tom \n looks like',
                        'Show me your dog',
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: screen.width / 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Center(
                      child: Container(
                        width: screen.width / 1.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              width: screen.width / 3,
                              height: screen.width / 2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: shadowColor,
                                //     blurRadius: 5.0,
                                //   ),
                                // ],
                              ),
                              child: dogImage != null
                                  ? Image.file(
                                      dogImage,
                                    )
                                  : TextButton(
                                      child: Icon(
                                        Icons.add_a_photo,
                                        size: 50,
                                        color: Colors.black,
                                      ),
                                      onPressed: clickImage,
                                    ),
                            ),
                            SizedBox(height: 10.0),
                            TextButton(
                              onPressed: pickImage,
                              //     () {
                              //   // Navigator.push(context, MaterialPageRoute(builder: (context) => registerDog1()));
                              // },
                              child: Text(
                                'Choose from gallery',
                              ),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.symmetric(vertical: 15.0),
                                ),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    side: BorderSide(
                                      color: themeColor,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            TextButton(
                              onPressed: clickImage,
                              //     () {
                              //   // Navigator.push(context, MaterialPageRoute(builder: (context) => registerDog1()));
                              // },
                              child: Text(
                                'Take a photo',
                              ),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(vertical: 15.0)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
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
                    ),
                    SizedBox(height: 30.0),
                    ElevatedButton(
                      style: buttonDesign,
                      child: button_design(screen, "NEXT"),
                      onPressed: () {
                        // Navigator.of(context).pushNamed('/register');
                        if (dogImage != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => dogConfirmation(
                                dogName: dogName,
                                dogGender: dogGender,
                                dogBreed: dogBreed,
                                dogColor: dogColor,
                                dogDescription: dogDescription,
                                dogSize: dogSize,
                                dogImage: dogImage,
                              ),
                            ),
                          );
                        } else {
                          final snackBar = SnackBar(
                              content:
                                  Text('Warning!, Please select the image'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
