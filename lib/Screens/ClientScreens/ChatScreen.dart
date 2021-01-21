import 'dart:async';
import 'dart:convert';

import 'package:Muqit/Models/ChatMessageModel.dart';
import 'package:Muqit/Models/ChatModel.dart';
import 'package:Muqit/Models/GeneralResponse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

class ChatScreen extends StatefulWidget {
  final String taskerid, clientid, chatFlow, name;
  ChatScreen(this.taskerid, this.clientid, this.chatFlow, this.name, {Key key})
      : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isloading = true;
  TextEditingController messageController = new TextEditingController();
  List<ChatMessage> messageList = new List<ChatMessage>();
  List<Message> allMessageList = new List<Message>();

  Future<void> getMessages(String taskerID) async {
    final String url = 'https://muqit.com/app/fetch_user_chat_history.php';
    http.Response response = await http.post(url, body: {'t_id': taskerID});
    if (response.body.toString() == "null") {
    } else {
      messageList = chatMessageFromJson(response.body);
    }
  }

  Future<void> getAllMessages() async {
    final String url = 'https://muqit.com/app/chathistory.php';
    http.Response response = await http.get(url);
    if (response.body.toString() == "null") {
    } else {
      allMessageList = messageFromJson(response.body);
    }
  }

  Future<GeneralResposne> sendMessage(
      String fromid, String toid, String message) async {
    print(toid + " " + fromid);
    final String url = 'https://muqit.com/app/insert_chat.php';
    http.Response response = await http.post(url, body: {
      'to_user_id': toid,
      'from_user_id': fromid,
      'chat_message': message
    });
    return generalResposneFromJson(response.body);
  }

  loadMessages() async {
    await getAllMessages();
    setState(() {
      isloading = false;
    });
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
    String token;
    await FirebaseFirestore.instance
        .collection('Taskers')
        .doc(widget.taskerid)
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

  Timer timer;
  ProgressDialog progressDialog;
  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      loadMessages();
    });
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: messageController,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () async {
              progressDialog = new ProgressDialog(context);
              progressDialog.style(
                  message: 'Sending....',
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
              GeneralResposne response = await sendMessage(widget.clientid,
                  widget.taskerid, messageController.text.trim());
              if (response.status == true) {
                await sendAndRetrieveMessage(
                    "You got new message from " + widget.name,
                    messageController.text,
                    widget.taskerid);
                progressDialog.hide();
                messageController.clear();
              }
            },
          ),
        ],
      ),
    );
  }

  _buildMessage(String fromid, String toid, String message, String time,
      bool isMe, String chatFlow) {
    bool isValidMessage = false;
    if (fromid == widget.clientid && toid == widget.taskerid) {
      isValidMessage = true;
      isMe = true;
    } else if (fromid == widget.taskerid && toid == widget.clientid) {
      isMe = false;
      isValidMessage = true;
    }
    // if (chatFlow == 'ClienttoTasker') {

    /*} else if (chatFlow == 'TaskertoClient') {
      if (fromid == widget.clientid && toid == widget.taskerid) {
        isValidMessage = true;
        isMe = true;
      } else if (fromid == widget.taskerid && toid == widget.clientid) {
        isMe = false;
        isValidMessage = true;
      }
    }*/
    return isValidMessage
        ? Container(
            margin: isMe
                ? EdgeInsets.only(
                    top: 8.0,
                    bottom: 8.0,
                    left: 80.0,
                  )
                : EdgeInsets.only(top: 8.0, bottom: 8.0, right: 80.0),
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: BoxDecoration(
                color: isMe ? Colors.green[100] : Colors.green[200],
                borderRadius: isMe
                    ? BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                      )
                    : BorderRadius.only(
                        topRight: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        : Container();
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
            "Chat",
            style: TextStyle(fontSize: 22, color: Colors.black),
          ),
        ),
        backgroundColor: Colors.green[50],
        body: Column(
          children: <Widget>[
            Expanded(
                child: Container(
              child: isloading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : allMessageList.length == 0
                      ? Center(
                          child: Text(
                            "No Chat History",
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.only(top: 15.0),
                          itemCount: allMessageList.length,
                          itemBuilder: (BuildContext context, int index) {
                            /* print(allMessageList.elementAt(index).fromUserId +
                                ' ' +
                                allMessageList.elementAt(index).toUserId +
                                ' ' +
                                allMessageList.length.toString());*/

                            return _buildMessage(
                                allMessageList.elementAt(index).fromUserId,
                                allMessageList.elementAt(index).toUserId,
                                allMessageList.elementAt(index).chatMessage,
                                allMessageList
                                    .elementAt(index)
                                    .timestamp
                                    .toString(),
                                false,
                                widget.chatFlow);
                          },
                        ),
            )),
            _buildMessageComposer(),
          ],
        ));
  }
}
