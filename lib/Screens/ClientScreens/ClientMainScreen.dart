import 'dart:convert';
import 'dart:ui';
import 'package:Muqit/ContactUs.dart';
import 'package:Muqit/Screens/ClientScreens/AppointmentList.dart';
import 'package:Muqit/Screens/ClientScreens/MapHome.dart';
import 'package:Muqit/Screens/ClientScreens/Setting.dart';
import 'package:Muqit/Screens/LoginScreen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:flutter/material.dart';
import 'package:minimize_app/minimize_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/DrawerBody.dart';
import '../../Utils/Map.dart';
import 'package:http/http.dart' as http;
import '../../Utils/TaskerCategory.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
showNotification(String title, String body) async {
  var android = AndroidNotificationDetails('10', 'channel ', 'description',
      priority: Priority.high, importance: Importance.max);
  var iOS = IOSNotificationDetails();
  var platform = new NotificationDetails(android: android, iOS: iOS);
  await flutterLocalNotificationsPlugin.show(0, title, body, platform,
      payload: 'Welcome to the Local Notification demo');
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  // SharedPreferences preferences = await SharedPreferences.getInstance();
  //preferences.setString("tasker_id", message['data']['id']);
  showNotification(message['data']['title'], message['data']['body']);

  // Or do other work.
}

class MainClientScreenSub extends StatefulWidget {
  final String email;
  final String username;
  final String id;
  MainClientScreenSub(this.email, this.username, this.id, {Key key})
      : super(key: key);

  @override
  __MainClientScreenState createState() => __MainClientScreenState();
}

class __MainClientScreenState extends State<MainClientScreenSub> {
  GlobalKey<SliderMenuContainerState> _key =
      new GlobalKey<SliderMenuContainerState>();
  var title = "Home";

  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  addToken() async {
    String token = await _firebaseMessaging.getToken();
    firestore.collection('Clients').doc(widget.id).set({'device_token': token});
  }

  @override
  void initState() {
    addToken();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOs);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: null);
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        //if (message['data']['id'] == widget.id) {
        AwesomeNotifications().createNotification(
            content: NotificationContent(
                id: 10,
                channelKey: 'big_picture',
                title: message['data']['title'],
                body: message['data']['body']));
        //}
        // _showItemDialog(message);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        //  if (message['data']['id'] == widget.id) {
        AwesomeNotifications().createNotification(
            content: NotificationContent(
                id: 10,
                channelKey: 'big_picture',
                title: message['data']['title'],
                body: message['data']['body']));
        //}
        //_navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // if (message['data']['id'] == widget.id) {
        AwesomeNotifications().createNotification(
            content: NotificationContent(
                id: 10,
                channelKey: 'big_picture',
                title: message['data']['title'],
                body: message['data']['body']));
        //}
        //_navigateToItemDetail(message);
      },
    );
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // Insert here your friendly dialog box before call the request method
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    //AwesomeNotifications().actionStream.listen((receivedNotification) {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => MinimizeApp.minimizeApp(),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: SliderMenuContainer(
              appBarColor: Colors.white,
              key: _key,
              sliderOpen: SliderOpen.LEFT_TO_RIGHT,
              appBarPadding: const EdgeInsets.only(top: 10),
              sliderMenuOpenOffset: 210,
              appBarHeight: 60,
              trailing: IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  //  await sendAndRetrieveMessage(
                  //  "testing", "testing notification");
                  logOut();
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  });
                },
              ),
              title: Text(
                title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              sliderMenu: MenuWidget(
                email: widget.email,
                name: widget.username,
                onItemClick: (title) {
                  _key.currentState.closeDrawer();
                  setState(() {
                    this.title = title;
                  });
                },
              ),
              sliderMain: Views(title, _key, context)),
        ),
      ),
    );
  }

  Widget Views(var _title, GlobalKey<SliderMenuContainerState> _key,
      BuildContext context) {
    switch (_title) {
      case "Home":
        {
          return HomeMapClass(widget.id);
        }
      case "Post Task":
        {
          return TaskerCategory(widget.id, widget.username);
        }
      case "All Appointments":
        {
          return AppointmentList(widget.id, widget.username);
        }
      case "Settings":
        {
          return Setting(widget.username, widget.email, widget.id);
        }
      case "Contact Us":
        {
          return ContactUs();
        }
    }
  }
}
