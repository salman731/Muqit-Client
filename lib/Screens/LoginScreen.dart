import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:Muqit/Models/GeneralResponse.dart';
import 'package:Muqit/Models/ClientLoginResponse.dart';
import 'package:Muqit/Models/TaskerLoginResponse.dart';
import 'package:Muqit/Screens/ClientScreens/ResetPassword.dart';
import 'package:Muqit/Screens/ClientScreens/TaskerList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'ClientScreens/ClientMainScreen.dart';
import './RegistrationScreen.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _auth = FirebaseAuth.instance;
  var email;
  var password;
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  ProgressDialog progressDialog;
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  String userType = 'Tasker';
  var userTypes = ["Tasker", "Client"];
  bool islogin = true;

  Future<ClientLoginModel> ClientLogin(
      String email, String password, String uri) async {
    http.Response response =
        await http.post(uri, body: {"email": email, "password": password});
    final String responseString = response.body;
    return clientLoginModelFromJson(responseString);
  }

  Future<TaskerLoginModel> TaskerLogin(
      String email, String password, String uri) async {
    http.Response response =
        await http.post(uri, body: {"email": email, "password": password});

    final String responseString = response.body;
    return taskerLoginModelFromJson(responseString);
  }

  setLoginSharedPref(String name, String email, String id, String password,
      bool login, String typeUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
    prefs.setString('email', email);
    prefs.setString('id', id);
    prefs.setString('password', password);
    prefs.setBool('islogin', login);
    prefs.setString('userType', typeUser);
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
    }
  }

  @override
  void initState() {
    //   checkLoginStatus();
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
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      labelText: "Email",
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
                    controller: passwordController,
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      labelText: "Password",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 4 / 100),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ResetPasswordScreen()));
                          },
                          child: Text("Forgot Password ?",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold))),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Login",
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
                    /* final user = await _auth
                        .createUserWithEmailAndPassword(
                            email: email, password: password)
                        .then((signInUser) => {
                              FirebaseFirestore.instance.collection("Users").add({
                                "email": email,
                                "password": password
                              }).then((value) => {if (signInUser != null) {}})
                            });*/
                    try {
                      progressDialog = new ProgressDialog(context);
                      progressDialog.style(
                          message: 'Logging In....',
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
                      if (emailController.text.isNotEmpty ||
                          passwordController.text.isNotEmpty) {
                        if (passwordController.text.length > 6) {
                          if (RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(emailController.text)) {
                            ClientLoginModel clientResposne = await ClientLogin(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                                'https://muqit.com/app/client_login.php');
                            print(clientResposne);
                            if (clientResposne.status) {
                              progressDialog.hide();
                              setLoginSharedPref(
                                  clientResposne.username.trim(),
                                  clientResposne.email.trim(),
                                  clientResposne.id.trim(),
                                  passwordController.text.trim(),
                                  true,
                                  'Client');
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainClientScreenSub(
                                          clientResposne.email.trim(),
                                          clientResposne.username.trim(),
                                          clientResposne.id.trim())));
                            } else {
                              progressDialog.hide();
                              Toast.show(clientResposne.message, context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.CENTER);
                            }
                          } else {
                            Toast.show(
                                "Enter Valid Email Address.....", context,
                                duration: Toast.LENGTH_SHORT,
                                gravity: Toast.BOTTOM);
                          }
                        } else {
                          Toast.show(
                              "Password Should Be Greate Than 6 Charaters..",
                              context,
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
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have a Account? "),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainScreenSub()));
                        },
                        child: Text("Sign Up",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold)))
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
