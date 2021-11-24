import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterdogtagapp/screens/appColors.dart';
import 'package:flutterdogtagapp/screens/blogPage.dart';
import 'package:flutterdogtagapp/stylingWidgets/textField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class EditBlogPage extends StatefulWidget {
  // Map<String, dynamic> userMap;
  // EditProfile({
  //   this.userMap
  // });
  //
  @override
  _EditBlogPageState createState() => _EditBlogPageState();
}

class _EditBlogPageState extends State<EditBlogPage> {
  TextEditingController _heading = TextEditingController();
  TextEditingController _post = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: themeColor,
        title: Text('Update Blog', style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black
        )),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Heading', style: GoogleFonts.poppins(
                    fontSize: 19,
                    fontWeight: FontWeight.bold

                ),),
                SizedBox(height: 10,),
                Container(
                  height: 50,
                  width: screen.width / 1.1,
                  decoration: textFeildBoxDeco(),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    // validator: (email) => email != null &&
                    //     !EmailValidator.validate(
                    //         email.trim())
                    //     ? 'Enter a valid Email'
                    //     : null,
                    // autofillHints: [AutofillHints.email],
                    // keyboardType: inputType,
                    controller: _heading,

                    decoration: new InputDecoration(
                      prefixIcon: Icon(
                        Icons.post_add_rounded,
                        // Icons.person_pin,

                        color: themeColor,
                      ),
                      border: InputBorder.none,
                      // focusedBorder: InputBorder.none,
                      // enabledBorder: InputBorder.none,
                      // errorBorder: InputBorder.none,
                      // disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15,
                          bottom: 11,
                          top: 11,
                          right: 15),
                      hintText: "Enter Your Heading",
                      hintStyle: GoogleFonts.poppins(
                        color: Color.fromRGBO(
                            186, 186, 186, 1),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        // _email = value.trim();
                      });
                    },
                  ),

                ),
                SizedBox(height: 10,),
                Text('Post', style: GoogleFonts.poppins(
                    fontSize: 19,
                    fontWeight: FontWeight.bold

                ),),
                SizedBox(height: 10,),
                Container(
                  // height:200,
                  width: screen.width / 1.1,
                  decoration: textFeildBoxDeco(),

                  child: TextFormField(
                    maxLines: null,
                    minLines: 3,
                    controller: _post,
                    cursorColor: Colors.black,
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      // focusedBorder: InputBorder.none,
                      // enabledBorder: InputBorder.none,
                      // errorBorder: InputBorder.none,
                      // disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15,
                          bottom: 11,
                          top: 11,
                          right: 15),
                      hintText: "Enter Your Description",

                      hintStyle: GoogleFonts.poppins(
                        color: Color.fromRGBO(
                            186, 186, 186, 1),
                      ),
                    ),
                  ),

                ),

              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: themeColor,
          child: Icon(Icons.subdirectory_arrow_left_outlined),

          onPressed: () async {

            // final text =
            //     'Invalid Email or Password';
            // final snackBar = SnackBar(
            //     content: Text(text),);
            // ScaffoldMessenger.of(context)
            //     .showSnackBar(snackBar);
            final String heading =
                _heading.text.trim();
            final String post =
            _post.text.trim();

            User user = FirebaseAuth.instance.currentUser;
            await FirebaseFirestore.instance.collection('blog').doc(user.uid).set({'heading': heading, 'content': post}).then((value){
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => BlogPage()));
            });

            // User user =
            //     FirebaseAuth.instance.currentUser;
            // await FirebaseFirestore.instance
            //     .collection("Blog")
            //     .doc(user.uid)
            //     .set({
            //   'heading': _heading,
            //   'post': _post
            // }).then((value) {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) =>
            //               BlogPage()));
            //   setState(() {
            //     // isLoading = false;
            //
            //     _heading.clear();
            //     _post.clear();
            //   });
            // }).catchError((e) {
            //   setState(() {
            //     // isLoading = false;
            //   });
            // },
            // );
          }


      ),
    );
  }
}
