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
              SizedBox(height: 30.0,),
              Text(
                'Dog Tag Mission',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 30),
              ),
                SizedBox(height: 30.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'To safely recover missing, endangered, or abducted dogs through the coordinated efforts of people in your zip code and to inform dog owners about the latest health research to ensure your furry loved ones a long, happy and healthy life.',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.normal, fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
