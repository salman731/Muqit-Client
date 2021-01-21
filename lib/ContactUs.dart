import 'package:Muqit/Models/GeneralResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class ContactUs extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ContactUs> {
  final fullname = new TextEditingController();
  final email = new TextEditingController();
  final phoneno = new TextEditingController();
  final subject = new TextEditingController();
  final message = new TextEditingController();

  Future<GeneralResposne> sendEmail(String name, String phone, String email,
      String subject, String message) async {
    final String url = 'https://muqit.com/app/Contact.php';
    http.Response response = await http.post(url, body: {
      'name': name,
      'email': email,
      'phone': phone,
      'subject': subject,
      'message': message
    });
    return generalResposneFromJson(response.body);
  }

  ProgressDialog progressDialog;
  showProgressDialog(String text) {
    progressDialog = new ProgressDialog(context);
    progressDialog.style(
        message: text,
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
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Container(
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    controller: fullname,
                    onChanged: (data) {
                      setState(() {});
                    },
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: Colors.green,
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Full Name',
                        labelStyle: TextStyle(color: Colors.green),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.green,
                            width: 2.0,
                          ),
                        )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.green,
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.green),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.green, width: 2.0),
                        )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    controller: phoneno,
                    keyboardType: TextInputType.phone,
                    cursorColor: Colors.green,
                    obscureText: false,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        prefixIcon: Icon(
                          Icons.local_phone,
                          color: Colors.green,
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Phone No',
                        labelStyle: TextStyle(color: Colors.green),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.green, width: 2.0),
                        )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    controller: subject,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        prefixIcon: Icon(
                          Icons.subject,
                          color: Colors.green,
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Subject',
                        labelStyle: TextStyle(color: Colors.green),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.green, width: 2.0),
                        )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    controller: message,
                    cursorColor: Colors.green,
                    keyboardType: TextInputType.multiline,
                    minLines: 5,
                    maxLines: null,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        prefixIcon: Icon(
                          Icons.message,
                          color: Colors.green,
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Message',
                        labelStyle: TextStyle(color: Colors.green),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.green, width: 2.0),
                        )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: MaterialButton(
                    padding: EdgeInsets.all(10),
                    elevation: 8,
                    minWidth: 250,
                    child: Text(
                      "Send",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    onPressed: () async {
                      if (email.text.isNotEmpty &&
                          fullname.text.isNotEmpty &&
                          phoneno.text.isNotEmpty &&
                          subject.text.isNotEmpty &&
                          message.text.isNotEmpty) {
                        if (RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(email.text)) {
                          showProgressDialog('Sending......');
                          await progressDialog.show();
                          GeneralResposne generalresponse = await sendEmail(
                              fullname.text,
                              phoneno.text,
                              email.text,
                              subject.text,
                              message.text);

                          Toast.show(generalresponse.message, context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.CENTER);
                          progressDialog.hide();
                        } else {
                          Toast.show("Email is Invalid......", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.CENTER);
                        }
                      } else {
                        Toast.show("Enter Complete Data.", context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                      }
                    },
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
