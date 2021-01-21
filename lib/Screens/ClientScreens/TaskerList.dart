import 'dart:ui';
import 'package:Muqit/Models/TaskerListModel.dart';
import 'package:Muqit/Screens/ClientScreens/ChatScreen.dart';
import 'package:Muqit/Utils/PostTask.dart';
import 'package:toast/toast.dart';
import '../../Utils/Map.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Taskerlist extends StatefulWidget {
  final String workCategory;
  final String clientID, name;
  Taskerlist(this.workCategory, this.clientID, this.name, {Key key})
      : super(key: key);
  @override
  _TaskerlistState createState() => _TaskerlistState();
}

class _TaskerlistState extends State<Taskerlist> {
  List array = new List();
  List<Tasker> taskersList = new List<Tasker>();
  bool isloading = true;

  Future<void> getTaskerList(String category, String url) async {
    http.Response response = await http.post(url, body: {"work": category});
    if (response.body.toString().trim() != "null") {
      taskersList = taskerFromJson(response.body);
    }
  }

  @override
  void initState() {
    loadData(widget.workCategory);
  }

  void loadData(String category) async {
    final String url = 'https://muqit.com/app/tasker_list.php';
    await getTaskerList(category, url);
    setState(() {
      isloading = false;
    });
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
            "Taskers",
            style: TextStyle(fontSize: 22, color: Colors.black),
          ),
        ),
        backgroundColor: Colors.green[50],
        body: isloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : taskersList.length == 0
                ? Center(
                    child: Text(
                      "No Tasker Found",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                : ListView.builder(
                    itemCount: taskersList.length,
                    itemBuilder: (BuildContext context, int index) {
                      //itemCount: dummyData.length;

                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[400],
                                offset: Offset(3, 3),
                                blurRadius: 1.0,
                                spreadRadius: 1.0)
                          ],
                          color: Color.fromRGBO(243, 245, 248, 1),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: CircleAvatar(
                                          child: Icon(Icons.person,
                                              color: Colors.white, size: 30),
                                          radius: 34,
                                          backgroundColor: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Name",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.green[700]),
                                          ),
                                          Container(
                                            width: 250,
                                            height: 30,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.account_circle,
                                                  color: Colors.black,
                                                  size: 15,
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    taskersList
                                                        .elementAt(index)
                                                        .name,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            "Email",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.green[700]),
                                          ),
                                          Container(
                                            width: 250,
                                            height: 30,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.email,
                                                  color: Colors.black,
                                                  size: 15,
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    taskersList
                                                        .elementAt(index)
                                                        .email,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            "Address",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.green[700]),
                                          ),
                                          Container(
                                            width: 250,
                                            height: 30,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.location_pin,
                                                  color: Colors.black,
                                                  size: 15,
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    taskersList
                                                        .elementAt(index)
                                                        .address,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            "Work",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.green[700]),
                                          ),
                                          Container(
                                            width: 250,
                                            height: 30,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.work,
                                                  color: Colors.black,
                                                  size: 15,
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    taskersList
                                                        .elementAt(index)
                                                        .work,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            "Rating",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.green[700]),
                                          ),
                                          Container(
                                            width: 250,
                                            height: 30,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.star_rate,
                                                  color: Colors.black,
                                                  size: 15,
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    '4/5',
                                                    overflow:
                                                        TextOverflow.visible,
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                MaterialButton(
                                    elevation: 10,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Set Appointment",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                    color: Colors.green,
                                    splashColor: Colors.lightGreen,
                                    onPressed: () {
                                      print("at Tasker list" +
                                          widget.clientID +
                                          " " +
                                          taskersList.elementAt(index).id);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PostTaskSF(
                                                  widget.clientID,
                                                  taskersList
                                                      .elementAt(index)
                                                      .id,
                                                  widget.workCategory)));
                                    }),
                                MaterialButton(
                                    elevation: 10,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Chat",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                    color: Colors.green,
                                    splashColor: Colors.lightGreen,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ChatScreen(
                                                  taskersList
                                                      .elementAt(index)
                                                      .id,
                                                  widget.clientID,
                                                  'ClienttoTasker',
                                                  widget.name)));
                                    }),
                              ],
                            )
                          ],
                        ),
                      );
                    }));
  }
}
