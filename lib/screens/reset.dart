import 'package:flutterdogtagapp/screens/appColors.dart';
import 'package:flutterdogtagapp/screens/register.dart';
import 'package:flutterdogtagapp/stylingWidgets/button.dart';
import 'package:flutterdogtagapp/stylingWidgets/textField.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Reset extends StatefulWidget {
  @override
  _ResetState createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  //bilal auth login
  String _email;
  final auth = FirebaseAuth.instance;
  //end bilal auth login
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Image(
              image: AssetImage(
                'images/login-top-paw.png',
              ),
              width: MediaQuery.of(context).size.height / 4.1,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image(
              image: AssetImage(
                'images/login-bottom-paw.png',
              ),
              width: MediaQuery.of(context).size.height / 6.0,
            ),
          ),
          Align(
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 4.0,
                      child: Image(
                        image: AssetImage(
                          'images/Dog_Tag-02.png',
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Reset Password",
                            style: GoogleFonts.poppins(
                              color: themeColor,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width / 12,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Email",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: screen.width / 1.1,
                            decoration: textFeildBoxDeco(),
                            child: TextFormField(
                              cursorColor: Colors.black,
                              validator: (email) => email != null &&
                                      !EmailValidator.validate(email)
                                  ? 'Enter a valid Email'
                                  : null,
                              autofillHints: [AutofillHints.email],
                              // keyboardType: inputType,
                              decoration: new InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  // Icons.person_pin,

                                  color: themeColor,
                                ),
                                border: InputBorder.none,
                                // focusedBorder: InputBorder.none,
                                // enabledBorder: InputBorder.none,
                                // errorBorder: InputBorder.none,
                                // disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: "Enter Your Email",
                                hintStyle: GoogleFonts.poppins(
                                  color: Color.fromRGBO(186, 186, 186, 1),
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _email = value.trim();
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          // Text(
                          //   "Password",
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          // SizedBox(height: 10),
                          // Container(
                          //   width: screen.width / 1.1,
                          //   decoration: textFeildBoxDeco(),
                          //   child: TextFormField(
                          //     cursorColor: Colors.black,
                          //     // keyboardType: inputType,
                          //     decoration: new InputDecoration(
                          //       prefixIcon: Icon(
                          //         Icons.lock,
                          //         // Icons.person_pin,
                          //
                          //         color: themeColor,
                          //       ),
                          //       border: InputBorder.none,
                          //       // focusedBorder: InputBorder.none,
                          //       // enabledBorder: InputBorder.none,
                          //       // errorBorder: InputBorder.none,
                          //       // disabledBorder: InputBorder.none,
                          //       contentPadding: EdgeInsets.only(
                          //           left: 15, bottom: 11, top: 11, right: 15),
                          //       hintText: "Enter Your Password",
                          //       hintStyle: TextStyle(
                          //         color: Color.fromRGBO(186, 186, 186, 1),
                          //       ),
                          //     ),
                          //     onChanged: (value) {
                          //       setState(() {
                          //         _password = value.trim();
                          //       });
                          //     },
                          //   ),
                          // ),
                          // Align(
                          //   alignment: Alignment.centerRight,
                          //   child: TextButton(
                          //     onPressed: () {},
                          //     child: Text(
                          //       "Forgot password?",
                          //       style: TextStyle(
                          //         color: Colors.black,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // Center(
                          //   child: IconButton(
                          //     icon: Icon(
                          //       Icons.mail_outline,
                          //       color: Colors.red,
                          //     ),
                          //     onPressed: () {},
                          //   ),
                          // ),
                          SizedBox(height: 10),
                          ElevatedButton(
                              style: buttonDesign,
                              child: button_design(screen, "Reset Password"),
                              onPressed: () {
                                if (formkey.currentState.validate()) {
                                  // if (_email.isEmpty) {
                                  //   print("Email is Empty");
                                  // } else {
                                  auth
                                      .sendPasswordResetEmail(email: _email)
                                      .then((_) {
                                    Navigator.of(context).pop();
                                    //   push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //           builder: (context) => pop()));
                                  });
                                  // }
                                }
                              }),
                          SizedBox(height: 10),
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  "Don't have an account",
                                  style: GoogleFonts.poppins(),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Register()));

                                    // Navigator.of(context).pushNamed('/register');
                                  },
                                  child: Text(
                                    "Create Account",
                                    style: GoogleFonts.poppins(),
                                  ),
                                ),
                                Text(
                                  "terms and conditions / Privacy policy",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
