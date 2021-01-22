import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:Muqit/Models/GeneralResponse.dart';
import 'package:Muqit/Models/ClientLoginResponse.dart';
import 'package:Muqit/Models/TaskerLoginResponse.dart';
import 'package:Muqit/Screens/ClientScreens/ClientMainScreen.dart';
import 'package:Muqit/Screens/ClientScreens/PasswordRestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:random_string/random_string.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPassword createState() => _ResetPassword();
}

class _ResetPassword extends State<ResetPasswordScreen> {
  var email;
  var password;
  ProgressDialog progressDialog;
  final emailController = new TextEditingController();
  String userType = 'Tasker';
  var userTypes = ["Tasker", "Client"];
  bool islogin = true;
  bool isCodesent = false;
  bool codesent = false;
  StreamController<ErrorAnimationType> errorController;
  TextEditingController pintextEditingController = new TextEditingController();
  String emailValue;

  Future<GeneralResposne> sendCode(String email, String code) async {
    String url = "https://muqit.com/app/csendcode.php";
    http.Response response =
        await http.post(url, body: {'email': email, 'code': code});
    return generalResposneFromJson(response.body);
  }

  @override
  void initState() {}
  pinVerificationWidget(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: PinCodeTextField(
              appContext: context,
              length: 6,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  inactiveColor: Colors.green[500],
                  inactiveFillColor: Colors.green[200],
                  activeFillColor: Colors.green[600],
                  selectedColor: Colors.green[600]),
              animationDuration: Duration(milliseconds: 300),
              backgroundColor: Colors.green[50],
              enableActiveFill: true,
              errorAnimationController: errorController,
              controller: pintextEditingController,
              onCompleted: (v) {
                if (v == rndcode) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Passwordrestore(emailValue)));
                }
              },
              onChanged: (value) {
                print(value);
              },
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
            )),
        resendWidget()
      ],
    );
  }

  resendWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Didn't receive the Code? "),
        InkWell(
            onTap: () async {
              rndcode = randomNumeric(6);
              GeneralResposne generalResposne =
                  await sendCode(emailValue, rndcode);
            },
            child: Text("Resend",
                style: TextStyle(
                    color: Colors.green, fontWeight: FontWeight.bold)))
      ],
    );
  }

  String rndcode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                SizedBox(
                  height: 40,
                ),
                Container(
                  child: isCodesent
                      ? pinVerificationWidget(context)
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(8),
                              labelText: "Enter Email Address",
                              labelStyle: TextStyle(color: Colors.green),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                                // borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.green, width: 2),
                                //borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: isCodesent
                      ? Container()
                      : MaterialButton(
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Send",
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
                                  message: 'Sending......',
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

                              if (emailController.text.isNotEmpty) {
                                if (RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(emailController.text)) {
                                  await progressDialog.show();
                                  rndcode = randomNumeric(6);
                                  GeneralResposne generalResposne =
                                      await sendCode(
                                          emailController.text, rndcode);
                                  if (generalResposne.message !=
                                      'Email not found') {
                                    emailValue = emailController.text;
                                    setState(() {
                                      isCodesent = true;
                                    });
                                    Toast.show(generalResposne.message, context,
                                        gravity: Toast.CENTER,
                                        duration: Toast.LENGTH_LONG);
                                  } else {
                                    Toast.show(generalResposne.message, context,
                                        gravity: Toast.CENTER,
                                        duration: Toast.LENGTH_LONG);
                                  }
                                  await progressDialog.hide();
                                } else {
                                  Toast.show(
                                      "Enter Valid Email Address.....", context,
                                      duration: Toast.LENGTH_SHORT,
                                      gravity: Toast.BOTTOM);
                                }
                              } else {
                                Toast.show("Enter Email.....", context,
                                    duration: Toast.LENGTH_SHORT,
                                    gravity: Toast.BOTTOM);
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
