import 'package:flutter/material.dart';
import 'package:flutterdogtagapp/screens/appColors.dart';
import 'package:flutterdogtagapp/screens/home.dart';
import 'package:flutterdogtagapp/screens/registerDog_2.dart';
import 'package:flutterdogtagapp/stylingWidgets/button.dart';

class registerDog_1 extends StatefulWidget {
  @override
  _registerDog_1State createState() => _registerDog_1State();
}

class _registerDog_1State extends State<registerDog_1> {
  //FOR DROPDOWN
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
  String dogGender = 'Boy';
  String dogColor;
  String dogDescription;

  final formKey = GlobalKey<FormState>();
  String validator(text) {
    if (text.isEmpty) return 'Please fill this field';
  }

  @override
  Widget build(BuildContext context) {
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
                        Image(
                          image: AssetImage('images/reg_1.png'),
                        ),
                        Text(
                          'steps 1 of 3',
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
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tell us your dog\'s \nname',
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
                        decoration: new InputDecoration(
                          labelText: 'My dog\'s name is...',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        onChanged: (val) => dogName = val,
                      ),
                      //SENDING DATA ON NEXT PAGE
                      // TextField(
                      //   decoration: InputDecoration(labelText: 'Dog Name'),
                      //   onChanged: (val) => dogName = val,
                      // ),
                      SizedBox(height: 20.0),
                      Text('Is it a boy or a girl?'),
                      SizedBox(height: 20.0),
                      buildRadios(),
                      SizedBox(height: 20.0),

                      // Text('My dog\'s breed is...'),
                      // SizedBox(height: 10.0),
                      // DropdownButton(
                      //   isExpanded: true,
                      //   hint: Text(
                      //     'Select your dog\'s breed',
                      //     textAlign: TextAlign.center,
                      //   ),
                      //   value: dogBreed,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       dogBreed = value;
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
                      TextFormField(
                        cursorColor: Colors.black,
                        validator: (text) => validator(text),
                        decoration: new InputDecoration(
                          labelText: 'My dog\'s breed is...',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        onChanged: (val) => dogBreed = val,
                      ),

                      SizedBox(height: 10.0),
                      // R_textFormField('My dog\'s color'),
                      TextFormField(
                        cursorColor: Colors.black,
                        validator: (text) => validator(text),
                        decoration: new InputDecoration(
                          labelText: 'My dog\'s color',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        onChanged: (val) => dogColor = val,
                      ),
                      SizedBox(height: 20.0),
                      // R_textFormField('Description'),
                      TextFormField(
                        cursorColor: Colors.black,
                        validator: (text) => validator(text),
                        decoration: new InputDecoration(
                          labelText: 'Description',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        onChanged: (val) => dogDescription = val,
                      ),
                      SizedBox(height: 10.0),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          padding: EdgeInsets.only(right: 10.0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()));
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
                      SizedBox(height: 10.0),
                      ElevatedButton(
                        style: buttonDesign,
                        child: button_design(screen, "NEXT"),
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // builder: (context) => registerDog_2(
                                //   dog_Name: dogName,
                                // ),
                                builder: (context) => registerDog_2(
                                  dogName: dogName,
                                  dogGender: dogGender,
                                  dogBreed: dogBreed,
                                  dogColor: dogColor,
                                  dogDescription: dogDescription,
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
          // setState(() => dogGender = 'Boy');
          Flexible(
            fit: FlexFit.loose,
            child: RadioListTile<String>(
              value: 'Boy',
              activeColor: themeColor,
              groupValue: dogGender,
              title: Text('Boy'),
              onChanged: (value) => setState(() => dogGender = value),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: RadioListTile<String>(
              value: 'Girl',
              activeColor: themeColor,
              groupValue: dogGender,
              title: Text('Girl'),
              onChanged: (value) => setState(() => dogGender = value),
            ),
          ),
          // Spacer(),
        ],
      );
  //FOR RADIO BUTTON ---------------- END ----------------------------
}
