import 'package:flutterdogtagapp/screens/appColors.dart';
import 'package:flutterdogtagapp/screens/home.dart';
import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: themeColor,
      //   leading: IconButton(
      //       icon: Icon(
      //         Icons.arrow_back_ios,
      //         color: Colors.black,
      //       ),
      //       onPressed: () {
      //         Navigator.of(context).pop();
      //       }),
      //   title: Text(
      //     'Contact us',
      //     style: TextStyle(
      //       color: Colors.black,
      //       fontWeight: FontWeight.bold,
      //       fontSize: 20,
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
      body: Stack(
        children: [
          Container(
            height: 150,
            padding: EdgeInsets.only(left: 10, top: 30, right: 10, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: 5.0,
                ),
              ],
              color: themeColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    Text(
                      'Contact us',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 80.0),
            width: screen.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor,
                    blurRadius: 5.0,
                  ),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3.5,
                    child: Image(
                      image: AssetImage(
                        'images/Dog_Tag-02.png',
                      ),
                      width: MediaQuery.of(context).size.height / 3.1,
                    ),
                  ),
                ),
                // Spacer(),
                Center(
                  child: Container(
                    width: screen.width / 1.1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Contact the team",
                          style: TextStyle(
                            color: themeColor,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width / 15,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod '
                          'tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. '
                          'At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea',
                        ),
                        SizedBox(height: 10.0),
                        ListTile(
                          leading: Icon(
                            Icons.phone,
                            color: themeColor,
                          ),
                          title: Text('+(123) 456-789'),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.email,
                            color: themeColor,
                          ),
                          title: Text('Loremipsum@gmail.com'),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: EdgeInsets.only(right: 10.0),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
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
    );
  }
}
