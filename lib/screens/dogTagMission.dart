import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'appColors.dart';

class DogTagMission extends StatelessWidget {
  const DogTagMission({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          'DOG TAG MISSION',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: themeColor,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              Text(
                'Dog Tag Mission',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.normal, fontSize: 15),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
