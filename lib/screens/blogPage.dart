import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterdogtagapp/screens/appColors.dart';
import 'package:flutterdogtagapp/screens/editBlog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterdogtagapp/screens/home.dart';
import 'package:google_fonts/google_fonts.dart';

final dogs = FirebaseFirestore.instance.collection('blog');
String uid;
String email;

class BlogPage extends StatefulWidget {
  const BlogPage({Key key}) : super(key: key);
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  Map<String, dynamic> userMap;

  @override
  void initState() {
    // getUsers();
    getUserById();
    uid = FirebaseAuth.instance.currentUser.uid;
    email = FirebaseAuth.instance.currentUser.email;
    print(email);

    print(uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        leading: IconButton(
            color: Colors.black,
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home()));
            }),
        title: Text(
          'Blog Page',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          // (uid == 'ZMW6xOymkUPMPPqX9JPqiVXx5kv2')
          (email == 'admin@gmail.com')
              ? IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditBlogPage()));
                  })
              : Container(),
        ],
      ),
      // Container(
      //   height: 150,
      //   padding: EdgeInsets.only(left: 10, top: 30, right: 10, bottom: 10),
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.only(
      //       bottomLeft: Radius.circular(30),
      //       bottomRight: Radius.circular(30),
      //     ),
      //     boxShadow: [
      //       BoxShadow(
      //         color: shadowColor,
      //         blurRadius: 5.0,
      //       ),
      //     ],
      //     color: themeColor,
      //   ),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Row(
      //         children: [
      //           IconButton(
      //               icon: Icon(
      //                 Icons.arrow_back_ios,
      //               ),
      //               onPressed: () {
      //                 Navigator.of(context).pop();
      //               }),
      //           Text(
      //             'Blog Page',
      //             style: TextStyle(
      //               color: Colors.black,
      //               fontWeight: FontWeight.bold,
      //               fontSize: 20,
      //             ),
      //           ),
      //           Spacer(),
      //           IconButton(
      //               icon: Icon(
      //                 Icons.edit,
      //                 color: Colors.white,
      //               ),
      //               onPressed: () {
      //                 Navigator.push(context, MaterialPageRoute(builder: (context)=> EditBlogPage()));
      //               }),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),

      body: Container(
        child: SingleChildScrollView(
          child: Container(
            // margin: EdgeInsets.only(top: 80.0),
            // width: screen.width,
            // decoration: BoxDecoration(
            //
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(25.0),
            //     boxShadow: [
            //       BoxShadow(
            //         color: shadowColor,
            //         blurRadius: 5.0,
            //       ),
            //     ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Center(
                //   child: Container(
                //     height: MediaQuery.of(context).size.height / 3.5,
                //     child: Image(
                //       image: AssetImage(
                //         'images/Dog_Tag-02.png',
                //       ),
                //       width: MediaQuery.of(context).size.height / 3.1,
                //     ),
                //   ),
                // ),
                // Spacer(),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 30.0),
                    width: screen.width / 1.1,
                    child: userMap != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  userMap != null ? userMap['heading'] : "",
                                  // Center(child: CircularProgressIndicator()),
                                  style: GoogleFonts.poppins(
                                    color: themeColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width / 15,
                                  ),
                                ),
                              ),
                              Divider(),
                              SizedBox(height: 10.0),
                              Text(
                                userMap != null ? userMap['content'] : "",
                                // Center(child: CircularProgressIndicator()),
                                // textAlign: TextAlign.justify,
                                style: GoogleFonts.poppins(fontSize: 19
                                    // fontWeight: FontWeight.bold
                                    ),
                              ),
                              SizedBox(height: 10.0),
                              // ListTile(
                              //   leading: Icon(
                              //     Icons.phone,
                              //     color: themeColor,
                              //   ),
                              //   title: Text('+(123) 456-789'),
                              // ),
                              // ListTile(
                              //   leading: Icon(
                              //     Icons.email,
                              //     color: themeColor,
                              //   ),
                              //   title: Text('Loremipsum@gmail.com'),
                              // ),
                            ],
                          )
                        : Text('Blog will be available soon for you'),
                  ),
                ),
                // Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getUserById() async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      await FirebaseFirestore.instance
          .collection('blog')
          // .where("email", isEqualTo: _search.text)
          //     .where("uid", isEqualTo: auth.currentUser.uid)
          //     .get().
          // .doc(_auth.currentUser.uid)
          .get()
          .then((value) {
        setState(() {
          userMap = value.docs[0].data();
          // userMap = value.data();
        });
      });
    } catch (e) {}
  }
}
