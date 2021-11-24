import 'package:flutterdogtagapp/screens/appColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ---------------------------------- TEXTFEILD FOR LOGIN SCREEN  -------------- STARTS -----
BoxDecoration textFeildBoxDeco() {
  return BoxDecoration(
      color: Colors.white,
      border: Border(
        top: BorderSide(
          color: shadowColor,
          style: BorderStyle.solid,
        ),
        bottom: BorderSide(
          color: shadowColor,
        ),
        right: BorderSide(
          color: shadowColor,
        ),
        left: BorderSide(
          color: shadowColor,
        ),
      ),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          // color: Colors.themeColor,
          color: shadowColor,
          blurRadius: 10.0,
          // offset: Offset(0, 10),
        ),
      ]);
}

TextFormField textFieldDesign(title, econ) {
  return TextFormField(
    cursorColor: Colors.black,
    // keyboardType: inputType,
    decoration: new InputDecoration(
      prefixIcon: Icon(
        econ,
        // Icons.person_pin,

        color: themeColor,
      ),
      border: InputBorder.none,
      // focusedBorder: InputBorder.none,
      // enabledBorder: InputBorder.none,
      // errorBorder: InputBorder.none,
      // disabledBorder: InputBorder.none,
      contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
      hintText: title,
      hintStyle: TextStyle(
        color: Color.fromRGBO(186, 186, 186, 1),
      ),
    ),
  );
}
// ---------------------------------- TEXTFEILD FOR LOGIN SCREEN  -------------- ENDS -----

// ---------------------------------- TEXTFEILD FOR REGISTERATION SCREEN  -------------- STARTS -----
TextFormField R_textFormField(label) {
  return TextFormField(
    cursorColor: Colors.black,
    // keyboardType: inputType,
    // textAlign: TextAlign.start,

    decoration: new InputDecoration(
      // prefixIcon: Icon(
      //   // econ,
      //   Icons.person_pin,
      //   color: Colors.themeColor,
      // ),
      labelText: label,
      labelStyle: TextStyle(
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
  );
}
// ---------------------------------- TEXTFEILD FOR REGISTERATION SCREEN  -------------- STARTS -----
