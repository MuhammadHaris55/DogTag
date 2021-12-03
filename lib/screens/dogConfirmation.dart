import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterdogtagapp/api/firebase_api.dart';
import 'package:flutterdogtagapp/screens/appColors.dart';
import 'package:flutterdogtagapp/screens/greatJob.dart';
import 'package:flutterdogtagapp/stylingWidgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

// ignore: camel_case_types
class dogConfirmation extends StatefulWidget {
  final String dogName;
  final String dogGender;
  final String dogBreed;
  final String dogColor;
  final String dogDescription;
  final String dogSize;
  final File dogImage;

  dogConfirmation({
    this.dogName,
    this.dogGender,
    this.dogBreed,
    this.dogColor,
    this.dogDescription,
    this.dogSize,
    this.dogImage,
  });

  @override
  _dogConfirmationState createState() => _dogConfirmationState();
}

class _dogConfirmationState extends State<dogConfirmation> {
  //UPLOADIND IMAGE ON FIREBASE -------------------------------------

  // Future<File> _imageFile;
  // bool isVideo = false;
  // // VideoPlayerController _controller;
  // VoidCallback listener;
  // bool showLoadingAnimation = false;
  //
  // void _onImageButtonPressed(ImageSource source) {
  //   setState(() {
  //     // if (_controller != null) {
  //     //   _controller.setVolume(0.0);
  //     //   _controller.removeListener(listener);
  //     // }
  //     // if (isVideo) {
  //     //   ImagePicker.pickVideo(source: source).then((File file) {
  //     //     if (file != null && mounted) {
  //     //       setState(() {
  //     //         _controller = VideoPlayerController.file(file)
  //     //           ..addListener(listener)
  //     //           ..setVolume(1.0)
  //     //           ..initialize()
  //     //           ..setLooping(true)
  //     //           ..play();
  //     //       });
  //     //     }
  //     //   });
  //     // } else {
  //     _imageFile = ImagePicker.pickImage(source: source);
  //     // _imageFile = dogImage;
  //     // }
  //   });
  // }
  //
  // // @override
  // // void deactivate() {
  // //   if (_controller != null) {
  // //     _controller.setVolume(0.0);
  // //     _controller.removeListener(listener);
  // //   }
  // //   super.deactivate();
  // // }
  //
  // // @override
  // // void dispose() {
  // //   if (_controller != null) {
  // //     _controller.dispose();
  // //   }
  // //   super.dispose();
  // // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   listener = () {
  //     setState(() {});
  //   };
  // }
  //
  // Widget _previewImage() {
  //   return FutureBuilder<File>(
  //       future: _imageFile,
  //       builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
  //         if (snapshot.connectionState == ConnectionState.done &&
  //             snapshot.data != null) {
  //           return Image.file(snapshot.data);
  //         } else if (snapshot.error != null) {
  //           return const Text(
  //             'Error picking image.',
  //             textAlign: TextAlign.center,
  //           );
  //         } else {
  //           return const Text(
  //             'You have not yet picked an image.',
  //             textAlign: TextAlign.center,
  //           );
  //         }
  //       });
  // }
  //
  //
  // _prepareImage(){
  //   print("Clicked on upload image button");
  //
  //   // setState(() {
  //   //   this.showLoadingAnimation = true;
  //   //   print("Loading animation started");
  //   // });
  //
  //   _imageFile.then((image) {
  //     // _imageFile.then((image) {
  //     print('Image file path : $image');
  //
  //     _uploadImage(image);
  //   });
  // }
  //
  //
  // // Method for uploading image
  // Future _uploadImage(File image) async {
  //   // fetch file name
  //   String fileName = p.basename(image.path);
  //   print('image base file name: ${fileName}');
  //
  //   final StorageReference ref = FirebaseStorage.instance.ref().child(
  //       "images/$fileName");
  //   final StorageUploadTask uploadTask = ref.putFile(image, StorageMetadata(contentLanguage: "en"));
  //   print('STEP 1 Done - ${new DateTime.now()} ');
  //
  //   final Uri downloadUrl = (await uploadTask.future).downloadUrl;
  //   print('STEP 2 Done - ${new DateTime.now()} ');
  //
  //   print('Download url received: $downloadUrl');
  //
  //   setState(() {
  //     this.showLoadingAnimation = false;
  //     print("Loading animation ended");
  //   });
  // }

  //UPLOADING IMAGE ON FIREBASE END ----------------------------------------

  //JOHANAS IMAGE UPLOAD
  UploadTask task;
  File file;

  var owner;
  String dogName;
  String dogGender;
  String dogBreed;
  String dogColor;
  String dogDescription;
  String dogSize;
  File dogImage;

  //JOHANAS IMAGE UPLOAD
  @override
  Widget build(BuildContext context) {
    // String dogName = widget.dogName;
    // String dogGender = widget.dogGender;
    // String dogBreed = widget.dogBreed;
    // String dogColor = widget.dogColor;
    // String dogDescription = widget.dogDescription;
    // String dogSize = widget.dogSize;
    // File dogImage = widget.dogImage;
    dogName = widget.dogName;
    dogGender = widget.dogGender;
    dogBreed = widget.dogBreed;
    dogColor = widget.dogColor;
    dogDescription = widget.dogDescription;
    dogSize = widget.dogSize;
    dogImage = widget.dogImage;
    file = widget.dogImage;

    final screen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        title: Center(
          child: Container(
            padding: EdgeInsets.only(right: screen.width / 8),
            child: Text(
              'Confirmation',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      // Container(
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     borderRadius: BorderRadius.circular(25.0),
      //     boxShadow: [
      //       BoxShadow(
      //         color: shadowColor,
      //         blurRadius: 5.0,
      //       ),
      //     ],
      //   ),
      //   child: Column(
      //     children: [
      //       Stack(
      //         children: [
      //           Container(
      //             // width: screen.width / 3,
      //             height: screen.width / 1.5,
      //             child: widget.dogImage != null
      //                 ? Image.file(
      //               widget.dogImage,
      //             )
      //                 : Image(
      //               image: AssetImage(
      //                 // 'images/confirmationPic.png',
      //                 widget.dogImage == null
      //                     ? 'images/confirmationPic.png'
      //                     : widget.dogImage,
      //               ),
      //               height: screen.width / 1.7,
      //             ),
      //           ),
      //           Positioned(
      //             bottom: 20.0,
      //             left: 20.0,
      //             child: Text(
      //               // 'I\'m Spike',
      //               dogName == null ? 'no name' : dogName,
      //               style: TextStyle(
      //                 fontWeight: FontWeight.bold,
      //                 fontSize: screen.width / 15,
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: screen.width,
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
                  child: Container(
                    // width: screen.width / 3,
                    height: screen.width / 1.5,
                    child: widget.dogImage != null
                        ? Image.file(
                            widget.dogImage,
                          )
                        : Image(
                            image: AssetImage(
                              // 'images/confirmationPic.png',
                              widget.dogImage == null
                                  ? 'images/confirmationPic.png'
                                  : widget.dogImage,
                            ),
                            height: screen.width / 1.7,
                          ),
                  ),
                ),
                Positioned(
                  bottom: 20.0,
                  left: 20.0,
                  child: Text(
                    // 'I\'m Spike',
                    dogName == null ? 'no name' : dogName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screen.width / 15,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Center(
              child: Container(
                width: screen.width / 1.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // R_textFormField('My dog\'s breed is...'),
                    TextFormField(
                      readOnly: true,
                      cursorColor: Colors.black,
                      decoration: new InputDecoration(
                        labelText: 'My dog\'s breed is...',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      initialValue: dogBreed,
                      onChanged: (val) => dogBreed = val,
                    ),
                    SizedBox(height: 10.0),
                    // R_textFormField('Description'),
                    TextFormField(
                      cursorColor: Colors.black,
                      decoration: new InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      initialValue: dogDescription,
                      onChanged: (val) => dogDescription = val,
                    ),
                    SizedBox(height: 30.0),
                    Text(
                      'Dog details',
                      style: TextStyle(
                        color: themeColor,
                        fontWeight: FontWeight.bold,
                        fontSize: screen.width / 18,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    // R_textFormField('Size'),
                    TextFormField(
                      readOnly: true,
                      cursorColor: Colors.black,
                      decoration: new InputDecoration(
                        labelText: 'Size',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      initialValue: dogSize == null ? 'undefine' : dogSize,
                      onChanged: (val) => dogSize = val,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Gender',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Image(
                          image: dogGender == 'Boy'
                              ? AssetImage(
                                  'images/male-icon.png',
                                )
                              : AssetImage(
                                  'images/female-icon.png',
                                ),
                        ),
                        SizedBox(width: 20.0),
                        Text(
                          dogGender == null ? 'undefine' : dogGender,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Your profile is almost complete',
                      style: TextStyle(
                        color: themeColor,
                        fontWeight: FontWeight.bold,
                        fontSize: screen.width / 15,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    // ElevatedButton(
                    //   style: buttonDesign,
                    //   child: button_design(screen, "Select File"),
                    //   onPressed: () {
                    //     selectFile();
                    //     //   Navigator.push(context,
                    //     //       MaterialPageRoute(builder: (context) => GreatJob()));
                    //   },
                    // ),
                    ElevatedButton(
                      style: buttonDesign,
                      child: button_design(screen, "Register"),
                      onPressed: () {
                        uploadFile();
                        Navigator.pushAndRemoveUntil(
                        //     context, newRoute, (route) => false)
                        // Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GreatJob()), (route) => false);
                      },
                    ),
                    // ElevatedButton(
                    //   style: buttonDesign,
                    //   child: button_design(screen, "Upload File"),
                    //   onPressed: () {
                    //     uploadFile();
                    //     Navigator.push(context,
                    //         MaterialPageRoute(builder: (context) => GreatJob()));
                    //   },
                    // ),
//                   ElevatedButton(
//                     style: buttonDesign,
//                     child: button_design(screen, "Register"),
//                     onPressed: () {
// //UPLOADING IMAGE ON FIREBASE ----------------------------------------------------------------------------------
//                       setState(() {
//                         this.isLoading = true;
//                       });
//                       listOfStr.forEach((img) async {
//                         String imageName = img!
//                             .substring(
//                                 img.lastIndexOf("/"), img.lastIndexOf("."))
//                             .replaceAll("/", "");
//
//                         final Directory systemTempDir = Directory.systemTemp;
//                         final byteData = await rootBundle.load(img);
//
//                         final file =
//                             File('${systemTempDir.path}/$imageName.jpeg');
//                         await file.writeAsBytes(byteData.buffer.asUint8List(
//                             byteData.offsetInBytes, byteData.lengthInBytes));
//                         TaskSnapshot snapshot = await storage
//                             .ref()
//                             .child("images/$imageName")
//                             .putFile(file);
//                         if (snapshot.state == TaskState.success) {
//                           final String downloadUrl =
//                               await snapshot.ref.getDownloadURL();
//                           await FirebaseFirestore.instance
//                               .collection("images")
//                               .add({"url": downloadUrl, "name": imageName});
//                           setState(() {
//                             isLoading = false;
//                           });
//                           final snackBar =
//                               SnackBar(content: Text('Yay! Success'));
//                           ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                         } else {
//                           print(
//                               'Error from image repo ${snapshot.state.toString()}');
//                           throw ('This file is not an image');
//                         }
//                       });
//
// //UPLOADING IMAGE ON FIREBASE
//
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) => GreatJob()));
//                     },
//                   ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future selectFile() async {
  //   final result = await FilePicker.platform.pickFiles(allowMultiple: false);
  //
  //   if (result == null) return;
  //   final path = result.files.single.path;
  //
  //   setState(() => file = File(path));
  // }

  Future uploadFile() async {
    if (file == null) return;

    // final fileName = basename(file.path);
    final fileName = basename(file.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file);
    setState(() {});

    if (task == null) return;

    User user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((value) {
      owner = value.data();
    });
    // User missingDogs = FirebaseAuth.instance.currentUser;
    final snapshot = await task.whenComplete(() async {});
    print(snapshot);

    final urlDownload = await snapshot.ref.getDownloadURL();

    //TO UPLOAD THE FORM
    final String _dogName = dogName;
    final String _dogGender = dogGender;
    final String _dogBreed = dogBreed;
    final String _dogColor = dogColor;
    final String _dogDescription = dogDescription;
    final String _dogSize = dogSize;
    final File _dogImage = dogImage;

    Timestamp createdAt = Timestamp.now();
    Timestamp updatedAt = Timestamp.now();

    // DocumentSnapshot dogDetails = await user.doc("userDetail").get();

    await FirebaseFirestore.instance
        .collection("dogsProfiles")
        // await FirebaseFirestore.instance.collection("users")
        // .doc("missingDogs")
        // .doc(user.uid)
        // .collection('dogsDetail')
        .doc()
        .set({
      "DogName": _dogName,
      "DogGender": _dogGender,
      "DogBreed": _dogBreed,
      "DogColor": _dogColor,
      "DogDescription": _dogDescription,
      "DogSize": _dogSize,
      // "DogImage": _dogImage,
      "DogImage": fileName,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "uid": user.uid,
      "ImageUrl": urlDownload,
      "firstname": owner['firstname'],
      "lastname": owner['lastname'],
      "email": owner['email'],
      "phoneno": owner['phoneno'],
      "status": 0,
    });

    print('Download-Link: $urlDownload');
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );

  // final String _dogName = dogName;
  // final String _dogGender = dogGender;
  // final String _dogBreed = dogBreed;
  // final String _dogColor = dogColor;
  // final String _dogDescription = dogDescription;
  // final String _dogSize = dogSize;
  // final File _dogImage = dogImage;
  //
  // // final String name = _nameController.text;
  // // final double price = double.tryParse(_priceController.text);
  //
  // // if (dogName != null && price != null) {
  // //   if (action == 'create') {
  // // Persist a new product to Firestore
  //
  // await _productss.add(
  //     {
  //       "DogName": _dogName,
  //       "DogGender": _dogGender,
  //       "DogBreed": _dogBreed,
  //       "DogColor": _dogColor,
  //       "DogDescription": _dogDescription,
  //       "DogSize": _dogSize,
  //       "DogImage": _dogImage
  //     });
  // }

  // if (action == 'update') {
  //   // Update the product
  //   await _productss
  //       .doc(documentSnapshot.id)
  //       .update({"name": name, "price": price});
  // }

  // Clear the text fields

  // _nameController.text = '';
  // _priceController.text = '';

  // Hide the bottom sheet
//       Navigator.of(context).pop();
//
//   },
// )
//   };
}
