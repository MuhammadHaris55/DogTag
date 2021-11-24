import 'dart:async';
import 'dart:io';
// import 'package:dog_tag/services/notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdogtagapp/screens/appColors.dart';
import 'package:flutterdogtagapp/screens/helloworld.dart';
import 'package:flutterdogtagapp/screens/home.dart';
import 'package:flutterdogtagapp/screens/welcome.dart';
import 'package:flutterdogtagapp/services/local_notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:provider/provider.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print("backgroundhandler");
  if (message.notification != null) {
    print(message.notification.title);
    print(message.data.toString());
  }
}

void main() async {
// Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationService.initialize();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print(messaging);
  runApp(MyApp());
}

// FOR SHARED PREFERENCES
setVisitingFlag() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setBool("alreadyVisited", true);
}

getVisitingFlag() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool alreadyVisited = preferences.getBool("alreadyVisited") ?? false;
  return alreadyVisited;
}
// FOR SHARED PREFERENCES

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () =>
          //   MultiProvider(
          // child:
          MaterialApp(
            theme: ThemeData(
              primaryColor: themeColor,
              primarySwatch: themeColor,
            ),
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),

      // providers: [
      // ChangeNotifierProvider(create: (_) => LocalNotificationService.instantNofitication()),
      // ],
      // ),
      designSize: Size(428, 926),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checklogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String email = pref.getString('email');
    if (email != null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Home()), (route) => false);
    }
  }

  @override
  void initState() {
    // LocalNotificationService.initialize();
    checklogin();

    super.initState();

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMessage = message.data["route"];
        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    ///Forground Work
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification.title);
        print(message.notification.body);
      }

      // LocalNotificationService.instantNofitication();
      if (Platform.isAndroid) {
        LocalNotificationService.display(message);
      }
    });

    ///When the app is open in background not in screen
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];
      Navigator.of(context).pushNamed(routeFromMessage);
    });

    Timer(Duration(seconds: 3), () async {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Welcome()));
      // }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColor,
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
          colors: [
            Colors.white,
            themeColor,
          ],
        )),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'images/Dog_Tag-01.png',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
