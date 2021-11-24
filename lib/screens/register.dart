import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutterdogtagapp/screens/appColors.dart';
import 'package:flutterdogtagapp/screens/registerDog_1.dart';
import 'package:flutterdogtagapp/stylingWidgets/button.dart';
import 'package:flutterdogtagapp/stylingWidgets/progressIndicator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //bilal auth login
  String _email, _password;
  final auth = FirebaseAuth.instance;
  //end bilal auth login

  // save data in database
  final formKey = GlobalKey<FormState>();
  String validator(text) {
    if (text.isEmpty) return 'Please fill this field';
  }

  TextEditingController _firstnameController = new TextEditingController();
  TextEditingController _lastnameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _zipcodeController = new TextEditingController();

  bool isLoading = false;
  // end save data in database
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Container(
                width: screen.width / 1.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Container(
                      height: screen.height / 5,
                      width: screen.width / 1.5,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'images/Dog_Tag-03.png',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Owner\'s Details',
                              style: GoogleFonts.poppins(
                                color: themeColor,
                                fontWeight: FontWeight.bold,
                                fontSize: screen.width / 15,
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              validator: (text) => validator(text),
                              controller: _firstnameController,
                              cursorColor: Colors.black,
                              // keyboardType: inputType,
                              // textAlign: TextAlign.start,

                              decoration: new InputDecoration(
                                // prefixIcon: Icon(
                                //   // econ,
                                //   Icons.person_pin,
                                //   color: Colors.themeColor,
                                // ),
                                labelText: "First Name",
                                labelStyle: GoogleFonts.poppins(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              validator: (text) => validator(text),
                              controller: _lastnameController,
                              cursorColor: Colors.black,
                              // keyboardType: inputType,
                              // textAlign: TextAlign.start,

                              decoration: new InputDecoration(
                                // prefixIcon: Icon(
                                //   // econ,
                                //   Icons.person_pin,
                                //   color: Colors.themeColor,
                                // ),
                                labelText: "Last Name",
                                labelStyle: GoogleFonts.poppins(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              validator: (email) => email != null &&
                                      !EmailValidator.validate(email.trim())
                                  ? 'Enter a valid Email'
                                  : null,
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              cursorColor: Colors.black,
                              // keyboardType: inputType,
                              // textAlign: TextAlign.start,

                              decoration: new InputDecoration(
                                // prefixIcon: Icon(
                                //   // econ,
                                //   Icons.person_pin,
                                //   color: Colors.themeColor,
                                // ),
                                labelText: "Email",
                                labelStyle: GoogleFonts.poppins(
                                  color: Colors.black,

                                  // fontWeight: FontWeight.bold,
                                ),

                                // focusedBorder: OutlineInputBorder(
                                //   color: myFocusNode.hasFocus ? Colors.blue : Colors.black
                                //   borderSide: BorderSide(color: Colors.themeColor),
                                // ),

                                // border: InputBorder.none,
                                // focusedBorder: InputBorder.none,
                                // enabledBorder: InputBorder.none,
                                // errorBorder: InputBorder.none,
                                // disabledBorder: InputBorder.none,
                                // contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                // hintText: "title",
                                // hintStyle: TextStyle(
                                //   color: Color.fromRGBO(186, 186, 186, 1),
                                // ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _email = value.trim();
                                });
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter name';
                                }
                                if (value.length <= 5) {
                                  return 'Password length shoudld be greater than 6';
                                }
                                return null;
                              },
                              // validator: (text)
                              //     // {
                              //     //   if (text.isEmpty) {
                              //     //     return 'Please fill this field';
                              //     //   }
                              //     //   if (text.trim().length < 6) {
                              //     //     return 'Password length should be atleast 6 ';
                              //     //   }
                              //     //   return '';
                              //     // },
                              //     =>
                              //     validator(text),
                              obscureText: true,
                              cursorColor: Colors.black,
                              controller: _passwordController,
                              // keyboardType: TextInputType,
                              // textAlign: TextAlign.start,

                              decoration: new InputDecoration(
                                // prefixIcon: Icon(
                                //   // econ,
                                //   Icons.person_pin,
                                //   color: Colors.themeColor,
                                // ),
                                labelText: "Password",
                                labelStyle: GoogleFonts.poppins(
                                  color: Colors.black,

                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _password = value.trim();
                                });
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              validator: (text) => validator(text),
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              cursorColor: Colors.black,
                              decoration: new InputDecoration(
                                labelText: "Phone No",
                                labelStyle: GoogleFonts.poppins(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              validator: (text) => validator(text),
                              controller: _addressController,
                              keyboardType: TextInputType.streetAddress,
                              cursorColor: Colors.black,
                              decoration: new InputDecoration(
                                labelText: "Address",
                                labelStyle: GoogleFonts.poppins(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              validator: (text) => validator(text),
                              // keyboardType: TextInputType,
                              controller: _zipcodeController,
                              cursorColor: Colors.black,
                              decoration: new InputDecoration(
                                // prefixIcon: Icon(
                                //   // econ,
                                //   Icons.person_pin,
                                //   color: Colors.themeColor,
                                // ),
                                labelText: "Zip Code",
                                labelStyle: GoogleFonts.poppins(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            ElevatedButton(
                              style: buttonDesign,
                              child: button_design(screen, "Register"),
                              onPressed: () {
                                if (formKey.currentState.validate()) {
                                  String usr_token;
                                  setState(() {
                                    isLoading = true;
                                    FirebaseMessaging.instance
                                        .getToken()
                                        .then((token) {
                                      print(token);
                                      usr_token = token;
                                    });
                                  });

                                  final String name =
                                      _firstnameController.text.trim() +
                                          " " +
                                          _lastnameController.text.trim();

                                  List array = name.toLowerCase().split("");
                                  List wordArray =
                                      name.toLowerCase().split(" ");
                                  String combine = array.first;

                                  for (var i = 1; i < array.length; i++) {
                                    wordArray.add(combine);
                                    combine = combine + array[i];
                                    print(wordArray);
                                  }
                                  wordArray.add(combine);

                                  print(wordArray);

                                  final String _name =
                                      _firstnameController.text.trim() +
                                          _lastnameController.text.trim();

                                  final String _firstname =
                                      _firstnameController.text.trim();

                                  final String _lastname =
                                      _lastnameController.text.trim();

                                  final String _email =
                                      _emailController.text.trim();

                                  final String _password =
                                      _passwordController.text.trim();

                                  final _phoneno = _phoneController.text.trim();
                                  final String _address =
                                      _addressController.text.trim();
                                  final String _zipcode =
                                      _zipcodeController.text.trim();
                                  try {
                                    auth
                                        .createUserWithEmailAndPassword(
                                            email: _email, password: _password)
                                        .then((value) async {
                                      User user =
                                          FirebaseAuth.instance.currentUser;
                                      user.updateDisplayName(_name);

                                      await FirebaseFirestore.instance
                                          .collection("tokens")
                                          .doc(user.uid)
                                          .set({
                                            'token': usr_token,
                                          });
                                      await FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(user.uid)
                                          .set({
                                        'name': _firstname + _lastname,
                                        'uid': user.uid,
                                        'firstname': _firstname,
                                        'wordArray': wordArray,
                                        'lastname': _lastname,
                                        'email': _email,
                                        'password': _password,
                                        'phoneno': _phoneno,
                                        'address': _address,
                                        'zipcode': _zipcode,
                                        'token': usr_token,
                                      }).then((value) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    registerDog_1()));
                                        setState(() {
                                          isLoading = false;
                                          _firstnameController.clear();
                                          _lastnameController.clear();
                                          _emailController.clear();
                                          _passwordController.clear();
                                          _phoneController.clear();
                                          _addressController.clear();
                                          _zipcodeController.clear();
                                        });
                                      }).catchError((e) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        final text = 'User already exists';
                                        final snackBar = SnackBar(
                                          content: Text(text),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      });
                                    }).catchError((e) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      final text = 'User already exists';
                                      final snackBar = SnackBar(
                                        content: Text(text),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    });
                                  } catch (e) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                } //remememe
                              },
                            ),
                            SizedBox(height: 30),
                            Center(
                              child: Text(
                                "terms and conditions / Privacy policy",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          progressIndicator(isLoading),
        ],
      ),
    );
  }
}
