import 'package:Muqit/Models/EditProfile.dart';
import 'package:Muqit/Models/GeneralResponse.dart';
import 'package:Muqit/Screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  final String id;
  EditProfile(this.id, {Key key}) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final c_nameController = new TextEditingController();
  final c_emailController = new TextEditingController();
  final c_passwordController = new TextEditingController();
  final c_mobilenoController = new TextEditingController();
  final c_addressController = new TextEditingController();
  List<EditProfileModel> editprofileModel = new List();
  bool isloading = true;

  ProgressDialog progressDialog;

  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<void> getProfile(String id) async {
    final String url = 'https://muqit.com/app/client_profile_edit.php';
    http.Response response = await http.post(url, body: {
      'id': id,
    });
    final String responseString = response.body;
    editprofileModel = editProfileModelFromJson(responseString);
  }

  Future<GeneralResposne> updateProfile(String username, String email,
      String password, String contact, String address, String id) async {
    final String url = 'https://muqit.com/app/client_profile_update.php';
    http.Response response = await http.post(url, body: {
      "id": id,
      "username": username,
      "email": email,
      "password": password,
      "contact": contact,
      "address": address
    });
    final String responseString = response.body;
    return generalResposneFromJson(responseString);
  }

  loadData(String id) async {
    await getProfile(id);
    setState(() {
      isloading = false;
    });
    c_nameController.text = editprofileModel.elementAt(0).username;
    c_emailController.text = editprofileModel.elementAt(0).email;
    c_mobilenoController.text = editprofileModel.elementAt(0).contact;
    c_addressController.text = editprofileModel.elementAt(0).address;
  }

  @override
  void initState() {
    loadData(widget.id);
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
            "Edit Profile",
            style: TextStyle(fontSize: 22, color: Colors.black),
          ),
        ),
        backgroundColor: Colors.green[50],
        body: isloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          child: TextField(
                            controller: c_nameController,
                            cursorColor: Colors.green,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8),
                                prefixIcon: Icon(
                                  Icons.account_circle,
                                  color: Colors.green,
                                ),
                                border: OutlineInputBorder(),
                                labelText: 'Name',
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
                            controller: c_emailController,
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
                                  borderSide: const BorderSide(
                                      color: Colors.green, width: 2.0),
                                )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: TextField(
                            controller: c_passwordController,
                            cursorColor: Colors.green,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.green,
                                ),
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                                labelStyle: TextStyle(color: Colors.green),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.green, width: 2.0),
                                )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: TextField(
                            controller: c_mobilenoController,
                            cursorColor: Colors.green,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8),
                                prefixIcon: Icon(
                                  Icons.local_phone,
                                  color: Colors.green,
                                ),
                                border: OutlineInputBorder(),
                                labelText: 'Mobile No',
                                labelStyle: TextStyle(color: Colors.green),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.green, width: 2.0),
                                )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: TextField(
                            controller: c_addressController,
                            cursorColor: Colors.green,
                            keyboardType: TextInputType.multiline,
                            minLines: 8,
                            maxLines: null,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8),
                                prefixIcon: Icon(
                                  Icons.location_on,
                                  color: Colors.green,
                                ),
                                border: OutlineInputBorder(),
                                labelText: 'Address',
                                labelStyle: TextStyle(color: Colors.green),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.green, width: 2.0),
                                )),
                          ),
                        ),
                        Container(
                          width: 250,
                          margin: EdgeInsets.only(top: 10),
                          child: MaterialButton(
                            padding: EdgeInsets.all(10),
                            elevation: 8,
                            child: Text(
                              "Update Profile",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            onPressed: () async {
                              if (c_nameController.text.isNotEmpty &&
                                  c_emailController.text.isNotEmpty &&
                                  c_passwordController.text.isNotEmpty &&
                                  c_mobilenoController.text.isNotEmpty &&
                                  c_addressController.text.isNotEmpty) {
                                if (c_passwordController.text.length > 6) {
                                  if (RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(c_emailController.text)) {
                                    progressDialog =
                                        new ProgressDialog(context);
                                    progressDialog.style(
                                        message: 'Updating....',
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
                                        await updateProfile(
                                            c_nameController.text,
                                            c_emailController.text,
                                            c_passwordController.text,
                                            c_mobilenoController.text,
                                            c_addressController.text,
                                            widget.id);

                                    if (generalResposne.status) {
                                      Toast.show(
                                          generalResposne.message, context,
                                          duration: Toast.LENGTH_SHORT,
                                          gravity: Toast.CENTER);
                                      logOut();
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen()));
                                      });
                                    } else {
                                      Toast.show(
                                          generalResposne.message, context,
                                          duration: Toast.LENGTH_SHORT,
                                          gravity: Toast.CENTER);
                                    }
                                    progressDialog.hide();
                                  } else {
                                    Toast.show(
                                        "Email is Invalid......", context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.CENTER);
                                  }
                                } else {
                                  Toast.show(
                                      "Password Should be 6 Character Long......",
                                      context,
                                      duration: Toast.LENGTH_SHORT,
                                      gravity: Toast.CENTER);
                                }
                              } else {
                                Toast.show("Complete Registration Form.......",
                                    context,
                                    duration: Toast.LENGTH_SHORT,
                                    gravity: Toast.CENTER);
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
              ));
  }
}
