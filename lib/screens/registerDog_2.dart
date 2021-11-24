import 'package:flutterdogtagapp/screens/appColors.dart';
import 'package:flutterdogtagapp/screens/registerDog_3.dart';
import 'package:flutterdogtagapp/stylingWidgets/button.dart';
import 'package:flutter/material.dart';

class registerDog_2 extends StatefulWidget {
  final String dogName;
  final String dogGender;
  final String dogBreed;
  final String dogColor;
  final String dogDescription;
  registerDog_2({
    this.dogName,
    this.dogGender,
    this.dogBreed,
    this.dogColor,
    this.dogDescription,
  });
  @override
  _registerDog_2State createState() => _registerDog_2State();
}

class _registerDog_2State extends State<registerDog_2> {
  // String dogName = widget.dogName;
  // String dogGender;
  // String dogBreed;
  // String dogColor;
  // String dogDescription;

  TextEditingController textEditingController = TextEditingController();

  bool tiny = false;
  bool small = false;
  bool medium = false;
  bool big = false;

  String dogSize = 'Don\'t know';
  @override
  Widget build(BuildContext context) {
    String dogName = widget.dogName;
    String dogGender = widget.dogGender;
    String dogBreed = widget.dogBreed;
    String dogColor = widget.dogColor;
    String dogDescription = widget.dogDescription;

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
                        //GETTING DATA FROM PREVIOUS PAGE
                        // Text(
                        //   widget.dogBreed == null ? 'no data' : widget.dogBreed,
                        // ),
                        Image(
                          width: screen.width / 2.0,
                          image: AssetImage(
                            'images/Dog_Tag-02.png',
                          ),
                        ),
                        Image(
                          image: AssetImage('images/reg_2.png'),
                        ),
                        Text(
                          'steps 2 of 3',
                          style: TextStyle(
                            fontSize: screen.width / 35,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How big is it?',
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontSize: screen.width / 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: themeColor,
                                    borderRadius: BorderRadius.circular(25.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: shadowColor,
                                        blurRadius: 5.0,
                                      ),
                                    ]),
                                width: screen.width / 2.7,
                                height: screen.width / 2.7,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image(
                                      image: AssetImage(
                                        'images/dog-size.png',
                                      ),
                                      height: screen.width / 6.0,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          dogSize = 'Tiny';
                                          tiny = true;
                                          small = false;
                                          medium = false;
                                          big = false;
                                        });
                                        // Navigator.push(context,MaterialPageRoute(builder: (context) => registerDog1()));
                                      },
                                      child: Text(
                                        'Tiny',
                                      ),
                                      style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(3),
                                        shadowColor: MaterialStateProperty.all(
                                            shadowColor),
                                        backgroundColor: tiny == true
                                            ? MaterialStateProperty.all<Color>(
                                                themeColor)
                                            : MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.black),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: themeColor,
                                    borderRadius: BorderRadius.circular(25.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: shadowColor,
                                        blurRadius: 5.0,
                                      ),
                                    ]),
                                width: screen.width / 2.7,
                                height: screen.width / 2.7,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image(
                                      image: AssetImage(
                                        'images/dog-size.png',
                                      ),
                                      height: screen.width / 6.0,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          dogSize = 'Small';
                                          tiny = false;
                                          small = true;
                                          medium = false;
                                          big = false;
                                        });
                                        // Navigator.push(context,MaterialPageRoute(builder: (context) => registerDog1()));
                                      },
                                      child: Text(
                                        'Small',
                                      ),
                                      style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(3),
                                        shadowColor: MaterialStateProperty.all(
                                            shadowColor),
                                        backgroundColor: small
                                            ? MaterialStateProperty.all<Color>(
                                                themeColor)
                                            : MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.black),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: themeColor,
                                    borderRadius: BorderRadius.circular(25.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: shadowColor,
                                        blurRadius: 5.0,
                                      ),
                                    ]),
                                width: screen.width / 2.7,
                                height: screen.width / 2.7,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image(
                                      image: AssetImage(
                                        'images/dog-size.png',
                                      ),
                                      height: screen.width / 6.0,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          dogSize = 'Medium';
                                          tiny = false;
                                          small = false;
                                          medium = true;
                                          big = false;
                                        });
                                        // Navigator.push(context,MaterialPageRoute(builder: (context) => registerDog1()));
                                      },
                                      child: Text(
                                        'Medium',
                                      ),
                                      style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(3),
                                        shadowColor: MaterialStateProperty.all(
                                            shadowColor),
                                        backgroundColor: medium
                                            ? MaterialStateProperty.all<Color>(
                                                themeColor)
                                            : MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.black),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: themeColor,
                                    borderRadius: BorderRadius.circular(25.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: shadowColor,
                                        blurRadius: 5.0,
                                      ),
                                    ]),
                                width: screen.width / 2.7,
                                height: screen.width / 2.7,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image(
                                      image: AssetImage(
                                        'images/dog-size.png',
                                      ),
                                      height: screen.width / 6.0,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          dogSize = 'Big';
                                          tiny = false;
                                          small = false;
                                          medium = false;
                                          big = true;
                                        });
                                        // Navigator.push(context,MaterialPageRoute(builder: (context) => registerDog1()));
                                      },
                                      child: Text(
                                        'Big',
                                      ),
                                      style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(3),
                                        shadowColor: MaterialStateProperty.all(
                                            shadowColor),
                                        backgroundColor: big
                                            ? MaterialStateProperty.all<Color>(
                                                themeColor)
                                            : MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.black),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              padding: EdgeInsets.only(right: 10.0),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => registerDog_3(
                                        dogName: dogName,
                                        dogGender: dogGender,
                                        dogBreed: dogBreed,
                                        dogColor: dogColor,
                                        dogDescription: dogDescription,
                                        dogSize: 'Don\'t Know',
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  'SKIP',
                                  style: TextStyle(
                                    color: Colors.black,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: buttonDesign,
                            child: button_design(screen, "NEXT"),
                            onPressed: () {
                              // Navigator.of(context).pushNamed('/register');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => registerDog_3(
                                    dogName: dogName,
                                    dogGender: dogGender,
                                    dogBreed: dogBreed,
                                    dogColor: dogColor,
                                    dogDescription: dogDescription,
                                    dogSize: dogSize,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
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
