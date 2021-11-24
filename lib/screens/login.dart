import 'package:flutterdogtagapp/screens/appColors.dart';
import 'package:flutterdogtagapp/screens/home.dart';
import 'package:flutterdogtagapp/screens/register.dart';
import 'package:flutterdogtagapp/screens/reset.dart';
import 'package:flutterdogtagapp/stylingWidgets/button.dart';
import 'package:flutterdogtagapp/stylingWidgets/progressIndicator.dart';
import 'package:flutterdogtagapp/stylingWidgets/textField.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //bilal auth login
  String _email, _password;
  final auth = FirebaseAuth.instance;
  bool isLoading = false;
  //end bilal auth login
  final formKey = GlobalKey<FormState>();
  String validator(text) {
    if (text.isEmpty) return 'Please fill this field';
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return ScaffoldMessenger(
        child: Builder(
            builder: (context) => Scaffold(
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
                          child: Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 4.0,
                                child: Image(
                                  image: AssetImage(
                                    'images/Dog_Tag-02.png',
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.1,
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Login",
                                        style: GoogleFonts.poppins(
                                          color: themeColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              10,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Username",
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
                                                  !EmailValidator.validate(
                                                      email.trim())
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
                                                left: 15,
                                                bottom: 11,
                                                top: 11,
                                                right: 15),
                                            hintText: "Enter Your Email",
                                            hintStyle: GoogleFonts.poppins(
                                              color: Color.fromRGBO(
                                                  186, 186, 186, 1),
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
                                      Text(
                                        "Password",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        width: screen.width / 1.1,
                                        decoration: textFeildBoxDeco(),
                                        child: TextFormField(
                                          validator: (text) => validator(text),
                                          cursorColor: Colors.black,
                                          obscureText: true,
                                          // keyboardType: inputType,
                                          decoration: new InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.lock,
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
                                            hintText: "Enter Your Password",
                                            hintStyle: GoogleFonts.poppins(
                                              color: Color.fromRGBO(
                                                  186, 186, 186, 1),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              _password = value.trim();
                                            });
                                          },
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Reset()));
                                          },
                                          child: Text(
                                            "Forgot password?",
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
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
                                        child: button_design(screen, "Sign in"),
                                        onPressed: () {
                                          if (formKey.currentState.validate()) {
                                            setState(() {
                                              isLoading = true;
                                            });

                                            try {
                                              auth
                                                  .signInWithEmailAndPassword(
                                                      email: _email,
                                                      password: _password)
                                                  .then((_) async {
                                                //SharedPreference
                                                SharedPreferences pref =
                                                    await SharedPreferences
                                                        .getInstance();
                                                await pref.setString(
                                                    'email', _email);

                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Home()));
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              }).catchError((e) {
                                                setState(() {
                                                  isLoading = false;
                                                });
                                                final text =
                                                    'Invalid Email or Password';
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
                                          }
                                        },
                                      ),
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
                                                        builder: (context) =>
                                                            Register()));

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
                              ),
                            ],
                          ),
                        ),
                      ),
                      progressIndicator(isLoading),
                    ],
                  ),
                )));
  }
}
