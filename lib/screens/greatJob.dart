import 'package:flutterdogtagapp/screens/appColors.dart';
import 'package:flutterdogtagapp/screens/home.dart';
import 'package:flutter/material.dart';

class GreatJob extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                Image(
                  image: AssetImage(
                    'images/GreatJob.png',
                  ),
                ),
                Spacer(),
                Container(
                  width: screen.width / 1.7,
                  child: Column(
                    children: [
                      Text(
                        'Great job!',
                        style: TextStyle(
                          color: themeColor,
                          fontWeight: FontWeight.bold,
                          fontSize: screen.width / 9,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'You Have Successfully Created Your Dog\'s Profile',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screen.width / 20,

                        ),
                      ),
                      SizedBox(height: 20.0),
                      // Text(
                      //   'You can share this app with your friends and family members to help find the missing dogs.',
                      //   textAlign: TextAlign.center,
                      // ),
                      SizedBox(height: 10.0),
                      // TextButton(
                      //   onPressed: () {},
                      //   child: Text(
                      //     'Share Now',
                      //   ),
                      //   style: ButtonStyle(
                      //     padding: MaterialStateProperty.all<EdgeInsets>(
                      //         EdgeInsets.symmetric(
                      //             horizontal: 40.0, vertical: 10.0)),
                      //     foregroundColor:
                      //         MaterialStateProperty.all<Color>(Colors.black),
                      //     shape:
                      //         MaterialStateProperty.all<RoundedRectangleBorder>(
                      //       RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(15.0),
                      //         side: BorderSide(
                      //           color: Colors.themeColor,
                      //           width: 2,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: EdgeInsets.only(right: 10.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                      child: Text(
                        'GO TO HOME',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Image(
              width: screen.width,
              image: AssetImage(
                'images/GreatJob_1.png',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
