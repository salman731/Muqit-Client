import 'dart:async';
import 'dart:isolate';
import 'package:Muqit/Screens/ClientScreens/ClientMainScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import './Screens/RegistrationScreen.dart';
import './Screens/ClientScreens/TaskerList.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:background_fetch/background_fetch.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelKey: 'big_picture',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ]);
//  final int helloAlarmID = 0;
  //await AndroidAlarmManager.initialize();

  runApp(MyApp());
  //await AndroidAlarmManager.periodic(
  //  const Duration(seconds: 1), helloAlarmID, printHello);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    print(FirebaseMessaging().getToken());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showDialog<bool>(
        context: context,
        builder: (c) => AlertDialog(
          title: Text('SP'),
          content: Text('Do you really want to exit'),
          actions: [
            FlatButton(
              child: Text('Yes'),
              onPressed: () => Navigator.pop(c, true),
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () => Navigator.pop(c, false),
            ),
          ],
        ),
      ),
      child: MaterialApp(
        initialRoute: '/',
        theme: ThemeData(primarySwatch: Colors.green),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    FirebaseMessaging().getToken().then((token) => print(token));
    super.initState();

    Timer(Duration(seconds: 3), () {
      checkLoginStatus();
    });
  }

  checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if ((prefs.getString('email')) != null &&
        prefs.getString('password') != null) {
      if (prefs.getString('userType') == 'Client') {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MainClientScreenSub(
                    prefs.getString('email'),
                    prefs.getString('name'),
                    prefs.getString('id'))));
      }
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.green[500]),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    child: Image.asset("asset/images/muqitlogo.jpg"),
                    backgroundColor: Colors.white,
                    radius: 35,
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text(
                    "Muqit",
                    style: TextStyle(
                        color: Colors.green[100],
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.green[900]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  Text(
                    "Service With Honesty",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[100]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    ));
  }
}
