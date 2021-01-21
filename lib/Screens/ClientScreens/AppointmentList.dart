import 'dart:ui';
import 'package:Muqit/Models/ApointmentList.dart';
import 'package:Muqit/Models/GeneralResponse.dart';
import 'package:Muqit/Screens/ClientScreens/EditAppointment.dart';
import 'package:Muqit/Utils/Map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toast/toast.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AppointmentList extends StatefulWidget {
  final String clientid, clientname;
  AppointmentList(this.clientid, this.clientname, {Key key}) : super(key: key);
  @override
  _appointment_listState createState() => _appointment_listState();
}

class _appointment_listState extends State<AppointmentList> {
  List array = new List();
  List<AppointmentListModel> appointmentList = new List<AppointmentListModel>();
  bool isloading = true;
  double ratingValue = 1;
  TextEditingController reviewtextEditingController =
      new TextEditingController();

  Future<void> getAppointments(String clientID) async {
    final String url = 'https://muqit.com/app/appointments.php';
    http.Response response = await http.post(url, body: {'from_id': clientID});

    if (response.body.toString().trim() != "Not Found") {
      appointmentList = appointmentListModelFromJson(response.body);
    }
  }

  Future<GeneralResposne> giveReview(
      String clientid, String taskerid, String rating, String review) async {
    final String url = 'https://muqit.com/app/giveReview.php';
    http.Response response = await http.post(url, body: {
      'RatedIndex': review,
      'tid': taskerid,
      'uid': clientid,
      'review': review
    });
    return generalResposneFromJson(response.body);
  }

  Future<GeneralResposne> sendworkDonemail(
      String clientName, String taskerName) async {
    final String url = 'https://muqit.com/app/email.php';
    http.Response response =
        await http.post(url, body: {'name': clientName, 'tname': taskerName});
    return generalResposneFromJson(response.body);
  }

  Future<GeneralResposne> sendtaskerArrivemail(
      String clientName, String taskerName) async {
    final String url = 'https://muqit.com/app/taskerarrive.php';
    http.Response response =
        await http.post(url, body: {'name': clientName, 'tname': taskerName});
    return generalResposneFromJson(response.body);
  }

  loadData(String clientid) async {
    await getAppointments(clientid);
    setState(() {
      isloading = false;
    });
  }

  _taskerTrackingScreen(int indx) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MapClass(appointmentList.elementAt(indx).tid)));
  }

  ProgressDialog showProgressDialog(String message) {
    ProgressDialog progressDialog = new ProgressDialog(context);
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
            color: Colors.black, fontSize: 10.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w600));
    return progressDialog;
  }

  void showDialog(String clientId, String taskerId) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 400),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: 300,
            width: 300,
            child: Column(
              children: [
                SizedBox(height: 10),
                Material(
                  child: Text(
                    "Rating",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                SizedBox(height: 10),
                RatingBar.builder(
                  initialRating: 1,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.green,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      ratingValue = rating;
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Material(
                  child: Text(
                    "Review",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    child: TextField(
                      controller: reviewtextEditingController,
                      obscureText: false,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        labelText: "Review",
                        labelStyle: TextStyle(color: Colors.green),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          //borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green, width: 2),
                          // borderRadius: BorderRadius.circular(10.0)
                        ),
                        prefixIcon: Icon(
                          Icons.rate_review,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
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
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  minWidth: 250,
                  color: Colors.green,
                  splashColor: Colors.lightGreen,
                  onPressed: () async {
                    ProgressDialog progressDialog = new ProgressDialog(context);
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
                    GeneralResposne generalResposne = await giveReview(
                        clientId,
                        taskerId,
                        ratingValue.toString(),
                        reviewtextEditingController.text);
                    if (generalResposne.status) {
                      progressDialog.hide();
                      Toast.show(generalResposne.message, context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                    } else {
                      progressDialog.hide();
                      Toast.show(generalResposne.message, context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                    }
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    loadData(widget.clientid);
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    // monitor network fetch
    await loadData(widget.clientid);
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await loadData(widget.clientid);
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green[50],
        body: isloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : appointmentList.length == 0
                ? Center(
                    child: Text("No Appointments Found"),
                  )
                : SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: false,
                    header: WaterDropHeader(),
                    footer: CustomFooter(
                      builder: (BuildContext context, LoadStatus mode) {
                        Widget body;
                        if (mode == LoadStatus.idle) {
                          body = Text("pull up load");
                        } else if (mode == LoadStatus.loading) {
                          body = CupertinoActivityIndicator();
                        } else if (mode == LoadStatus.failed) {
                          body = Text("Load Failed!Click retry!");
                        } else if (mode == LoadStatus.canLoading) {
                          body = Text("release to load more");
                        } else {
                          body = Text("No more Data");
                        }
                        return Container(
                          height: 55.0,
                          child: Center(child: body),
                        );
                      },
                    ),
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    child: ListView.builder(
                        itemCount: appointmentList.length,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: CircleAvatar(
                                              child: Icon(Icons.assignment_ind,
                                                  color: Colors.white,
                                                  size: 30),
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
                                                "Sr #",
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
                                                      Icons
                                                          .format_list_numbered,
                                                      color: Colors.black,
                                                      size: 18,
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        (index + 1).toString(),
                                                        overflow: TextOverflow
                                                            .visible,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
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
                                                      size: 18,
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        appointmentList
                                                            .elementAt(index)
                                                            .name,
                                                        overflow: TextOverflow
                                                            .visible,
                                                        maxLines: 3,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                "Work Type",
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
                                                      size: 18,
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        appointmentList
                                                            .elementAt(index)
                                                            .work,
                                                        overflow: TextOverflow
                                                            .visible,
                                                        maxLines: 10,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                "Date",
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
                                                      Icons
                                                          .calendar_today_outlined,
                                                      color: Colors.black,
                                                      size: 18,
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        appointmentList
                                                            .elementAt(index)
                                                            .fixdate,
                                                        overflow: TextOverflow
                                                            .visible,
                                                        maxLines: 3,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black),
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
                                                      size: 18,
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        appointmentList
                                                            .elementAt(index)
                                                            .workaddress,
                                                        overflow: TextOverflow
                                                            .visible,
                                                        maxLines: 3,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                "Status",
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
                                                      Icons
                                                          .priority_high_outlined,
                                                      color: Colors.black,
                                                      size: 18,
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        appointmentList
                                                            .elementAt(index)
                                                            .status,
                                                        overflow: TextOverflow
                                                            .visible,
                                                        maxLines: 3,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                "Initial Quote",
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
                                                      Icons.format_quote,
                                                      color: Colors.black,
                                                      size: 18,
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        appointmentList
                                                            .elementAt(index)
                                                            .initialQuote,
                                                        overflow: TextOverflow
                                                            .visible,
                                                        maxLines: 3,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                "Final Quote",
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
                                                      Icons.format_quote_sharp,
                                                      color: Colors.black,
                                                      size: 18,
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        appointmentList
                                                            .elementAt(index)
                                                            .finalQuote,
                                                        overflow: TextOverflow
                                                            .visible,
                                                        maxLines: 3,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                "Description",
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
                                                      Icons.description,
                                                      color: Colors.black,
                                                      size: 18,
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        appointmentList
                                                            .elementAt(index)
                                                            .description,
                                                        overflow: TextOverflow
                                                            .visible,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    MaterialButton(
                                        elevation: 10,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            "Re-Schedule",
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
                                                  builder: (context) =>
                                                      EditAppointment(
                                                          appointmentList
                                                              .elementAt(index)
                                                              .id,
                                                          appointmentList
                                                              .elementAt(index)
                                                              .tid,
                                                          widget.clientname)));
                                        }),
                                    MaterialButton(
                                        elevation: 10,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            "Tasker Arrive",
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
                                        onPressed: () async {
                                          ProgressDialog progressDialog =
                                              new ProgressDialog(context);
                                          progressDialog.style(
                                              message: 'Sending.....',
                                              borderRadius: 10.0,
                                              backgroundColor: Colors.white,
                                              progressWidget:
                                                  CircularProgressIndicator(),
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

                                          GeneralResposne generalResposne =
                                              await sendtaskerArrivemail(
                                                  widget.clientname,
                                                  appointmentList
                                                      .elementAt(index)
                                                      .name);
                                          progressDialog.hide();
                                          Toast.show(
                                              generalResposne.message, context,
                                              duration: Toast.LENGTH_LONG,
                                              gravity: Toast.CENTER);
                                        }),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    MaterialButton(
                                        elevation: 10,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            "Work Done",
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
                                        onPressed: () async {
                                          ProgressDialog progressDialog =
                                              new ProgressDialog(context);
                                          progressDialog.style(
                                              message: 'Sending.....',
                                              borderRadius: 10.0,
                                              backgroundColor: Colors.white,
                                              progressWidget:
                                                  CircularProgressIndicator(),
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

                                          GeneralResposne generalResposne =
                                              await sendworkDonemail(
                                                  widget.clientname,
                                                  appointmentList
                                                      .elementAt(index)
                                                      .name);
                                          progressDialog.hide();
                                          Toast.show(
                                              generalResposne.message, context,
                                              duration: Toast.LENGTH_LONG,
                                              gravity: Toast.CENTER);
                                        }),
                                    MaterialButton(
                                        elevation: 10,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            "Give Review ",
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
                                          showDialog(
                                              widget.clientid,
                                              appointmentList
                                                  .elementAt(index)
                                                  .tid);
                                        }),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    MaterialButton(
                                        elevation: 10,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            "Cancel",
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
                                        onPressed: () {}),
                                    MaterialButton(
                                      elevation: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(
                                          "Track Tasker",
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
                                      color: appointmentList
                                                  .elementAt(index)
                                                  .status !=
                                              'Accept'
                                          ? Colors.grey
                                          : Colors.green,
                                      splashColor: appointmentList
                                                  .elementAt(index)
                                                  .status !=
                                              'Accept'
                                          ? Colors.grey
                                          : Colors.lightGreen,
                                      onPressed: () => appointmentList
                                                  .elementAt(index)
                                                  .status !=
                                              'Accept'
                                          ? null
                                          : _taskerTrackingScreen(index),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                  ));
  }
}
