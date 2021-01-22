import 'package:Muqit/Models/GeneralResponse.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class Passwordrestore extends StatefulWidget {
  String email;
  Passwordrestore(this.email, {Key key}) : super(key: key);
  @override
  _PasswordrestoreState createState() => _PasswordrestoreState();
}

class _PasswordrestoreState extends State<Passwordrestore> {
  final repasswordController = new TextEditingController();
  final passwordController = new TextEditingController();
  ProgressDialog progressDialog;

  Future<GeneralResposne> resetPassword(String email, String password) async {
    String url = "https://muqit.com/app/cpasswordreset.php";
    http.Response response =
        await http.post(url, body: {'email': email, 'password': password});
    return generalResposneFromJson(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: 0,
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.red),
                  height: 80.0,
                  width: 80.0,
                  child: Center(
                    child: Image.asset(
                      "asset/images/muqitlogo.jpg",
                      height: 120.0,
                      width: 120.0,
                    ),
                  ),
                ),

                // Here default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor

                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    controller: passwordController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.green),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        // borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2),
                        //borderRadius: BorderRadius.circular(10.0),
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: repasswordController,
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      labelText: "Re-Password",
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
                        Icons.lock,
                        color: Colors.green,
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
                      "Reset",
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
                    try {
                      progressDialog = new ProgressDialog(context);
                      progressDialog.style(
                          message: 'Resetting.....',
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

                      if (repasswordController.text.isNotEmpty ||
                          passwordController.text.isNotEmpty) {
                        if (repasswordController.text ==
                            passwordController.text) {
                          await progressDialog.show();
                          GeneralResposne generalResposne = await resetPassword(
                              widget.email, passwordController.text);

                          Toast.show(generalResposne.message, context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                          progressDialog.hide();
                          Navigator.pop(context);
                        } else {
                          Toast.show("Password does not match", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                        }
                      } else {
                        Toast.show("Enter Email and Password......", context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM);
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
