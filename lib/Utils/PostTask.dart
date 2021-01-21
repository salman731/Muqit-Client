import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:Muqit/Models/GeneralResponse.dart';
import 'package:Muqit/Models/TAppointmentListModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:Muqit/Screens/ClientScreens/TaskerList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_counter/flutter_counter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:http/http.dart' as http;

class PostTaskSF extends StatefulWidget {
  final String clientID;
  final String taskerID;
  final String workCategory;
  PostTaskSF(this.clientID, this.taskerID, this.workCategory, {Key key})
      : super(key: key);
  @override
  _PostTaskSFState createState() => _PostTaskSFState();
}

class _PostTaskSFState extends State<PostTaskSF> {
  int _defaultValue = 0;
  String dropdownValue = '1';
  var datetime = "";
  final tasktitle = new TextEditingController();
  final taskdetail = new TextEditingController();
  final location = new TextEditingController();
  final budget = new TextEditingController();
  String noofpeople = '1';
  List<String> taskduration = [
    'Small(1hr to 3hr)',
    'Medium(3hr to 5hr)',
    'Large(5hr to 10hr)'
  ];
  int durationSelectedIndex = 0;

  Future<GeneralResposne> bookAppointment(
      String clientID,
      String taskerID,
      String jobRate,
      String workAddress,
      String taskDescription,
      String taskCategory,
      String taskDate) async {
    final String url = 'https://muqit.com/app/set_appointment.php';
    http.Response response = await http.post(url, body: {
      'jobRateOffered': jobRate,
      'work_address': workAddress,
      'description': taskDescription,
      'work_type': taskCategory,
      'to_id': taskerID,
      'from_id': clientID,
      'fix_date': taskDate
    });
    final String responseString = response.body;
    GeneralResposne generalResposne = generalResposneFromJson(responseString);
    return generalResposne;
    if (generalResposne.status) {
      Toast.show(generalResposne.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
    } else {
      Toast.show(generalResposne.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
    }
  }

  final String serverToken =
      'AAAAJd3SDkE:APA91bHQyeYop_KITZh928KGibEFIZQ1fFYCdhRiBmoQaqwjq1Awg3rhQXBmppRJSZX9v9w9OqjYEfVKc9w0fJqj-pyH4leyx8W2FlfxmJyv1ePkHYVesYmxzk_HnCTMiFtRBS7fJSed';
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  Future<Map<String, dynamic>> sendAndRetrieveMessage(
      String title, String body, String taskerID) async {
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );

    print("Sending Notification......");
    String token = await firebaseMessaging.getToken();
    await FirebaseFirestore.instance
        .collection('Taskers')
        .doc(widget.taskerID)
        .get()
        .then((querysnapsht) {
      token = querysnapsht.data()['device_token'];
    });
    print("Printing Token......" + token);
    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'priority': 'high',
          'restricted_package_name': 'com.example.MuqitTasker',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'tid': taskerID,
            'status': 'done',
            'title': title,
            'body': body
          },
          'to': token,
        },
      ),
    );
    print("Notification Sent......");
    //  final Completer<Map<String, dynamic>> completer =
    //    Completer<Map<String, dynamic>>();

    //return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Post Task",
          style: TextStyle(fontSize: 22, color: Colors.black),
        ),
      ),
      backgroundColor: Colors.green[50],
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Describe your task in detail:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  minLines: 5,
                  maxLines: null,
                  controller: taskdetail,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "Please do not share Your Personal information",
                    hintStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "Select Your Location:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextField(
                    controller: location,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ToggleSwitch(
                  initialLabelIndex: 0,
                  minWidth: 99,
                  fontSize: 8,
                  inactiveBgColor: Colors.green[200],
                  labels: [
                    'Small(1hr to 3hr)',
                    'Medium(3hr to 5hr)',
                    'Large(5hr to 10hr)'
                  ],
                  onToggle: (index) {
                    durationSelectedIndex = index;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        width: 100,
                        child: Text(
                          '$datetime',
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )),
                    SizedBox(
                      width: 150,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        color: Colors.green,
                        splashColor: Colors.lightGreen,
                        onPressed: () {
                          DatePicker.showDateTimePicker(context,
                              showTitleActions: true,
                              onChanged: (date) {}, onConfirm: (date) {
                            setState(() {
                              datetime =
                                  DateFormat().add_yMd().add_jm().format(date);
                            });
                            FocusScope.of(context).unfocus();
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        },
                        elevation: 10,
                        child: Text(
                          "Select Date and Time",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "What's your estimated Budget?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Rs:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: SizedBox(
                          width: 80,
                          child: TextField(
                            controller: budget,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                  borderRadius:
                                      new BorderRadius.circular(20.0)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    minWidth: 250,
                    color: Colors.green,
                    splashColor: Colors.lightGreen,
                    onPressed: () async {
                      print(taskduration[durationSelectedIndex]);
                      if (taskdetail.text.isNotEmpty &&
                          location.text.isNotEmpty &&
                          datetime.isNotEmpty &&
                          budget.text.isNotEmpty) {
                        ProgressDialog progressDialog =
                            new ProgressDialog(context);
                        progressDialog.style(
                            message: 'Submitting....',
                            borderRadius: 10.0,
                            backgroundColor: Colors.white,
                            progressWidget: CircularProgressIndicator(),
                            elevation: 10.0,
                            insetAnimCurve: Curves.easeInOut,
                            progress: 0.0,
                            maxProgress: 100.0,
                            progressTextStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 10.0,
                                fontWeight: FontWeight.w400),
                            messageTextStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600));
                        await progressDialog.show();
                        GeneralResposne generalResposne = await bookAppointment(
                            widget.clientID,
                            widget.taskerID,
                            budget.text,
                            location.text,
                            taskdetail.text,
                            taskduration[durationSelectedIndex],
                            datetime);

                        if (generalResposne.status) {
                          progressDialog.hide();
                          await sendAndRetrieveMessage("New Appointment",
                              taskdetail.text, widget.taskerID);
                          Toast.show(generalResposne.message, context,
                              gravity: Toast.CENTER,
                              duration: Toast.LENGTH_LONG);
                        } else {
                          progressDialog.hide();
                          Toast.show(generalResposne.message, context,
                              gravity: Toast.CENTER,
                              duration: Toast.LENGTH_LONG);
                        }
                      } else {
                        Toast.show('Enter Complete Details of Task', context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                      }
                    },
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
