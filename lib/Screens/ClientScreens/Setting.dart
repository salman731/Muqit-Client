import 'dart:convert';
import 'dart:io';
import 'package:Muqit/Models/ClientLoginResponse.dart';
import 'package:Muqit/Models/GeneralResponse.dart';
import 'package:Muqit/Models/TaskerLoginResponse.dart';
import 'package:Muqit/Screens/ClientScreens/EditProfile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Setting extends StatefulWidget {
  final String name, email, clientID;
  Setting(this.name, this.email, this.clientID, {Key key}) : super(key: key);
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool isSwitched = false;
  File _image;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<ClientLoginModel> ClientLogin(
    String email,
    String password,
  ) async {
    String uri = 'https://muqit.com/app/client_login.php';
    http.Response response =
        await http.post(uri, body: {"email": email, "password": password});
    final String responseString = response.body;
    print(responseString);
    return clientLoginModelFromJson(responseString);
  }

  loadImage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    ClientLoginModel clientLoginModel = await ClientLogin(
        preferences.getString('email'), preferences.getString('password'));

    if (clientLoginModel.profile == '') {
      setState(() {
        isimageFound = false;
      });
    } else {
      imageName = clientLoginModel.profile;
      setState(() {
        isimageFound = true;
      });
    }
  }

  Future<GeneralResposne> uploadImage(String photo, String id) async {
    final String uri = 'https://muqit.com/app/file_upload.php';
    http.Response response =
        await http.post(uri, body: {'photo': photo, 'id': id});
    return generalResposneFromJson(response.body);
  }

  bool isimageFound = false;
  String imageName;

  @override
  void initState() {
    loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Container(
        //margin: EdgeInsets.symmetric(horizontal: 4,vertical: 2,),

        decoration: BoxDecoration(
          color: Colors.green[300],
          boxShadow: [
            BoxShadow(
              color: Colors.white,
            )
          ],
        ),

        child: Container(
          decoration: BoxDecoration(
            color: Colors.green[50],
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 34,
                          backgroundColor: Colors.grey[300],
                          child: isimageFound
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(34.0),
                                  child: Image.network(
                                      "https://www.muqit.com/app/upload/" +
                                          imageName,
                                      fit: BoxFit.fill,
                                      width: 65,
                                      height: 65),
                                )
                              : Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.black,
                                ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Text(
                            widget.email,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Column(
                        children: [
                          FlatButton(
                            color: Colors.green,
                            onPressed: () {
                              InkWell(
                                splashColor: Colors.white,
                              );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditProfile(widget.clientID)));
                            },
                            child: Text("Edit Profile",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // Divider(thickness: 1,indent: 20,endIndent: 20,color: Colors.greenAccent,),
              Divider(
                indent: 20,
                endIndent: 20,
                thickness: 1,
                color: Colors.grey,
                height: 30,
              ),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: _image != null
                          ? Image.file(
                              _image,
                              width: 100,
                              height: 100,
                            )
                          : Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text("Profile Image",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black))),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: RaisedButton(
                        color: Colors.green[400],
                        elevation: 10,
                        onPressed: () async {
                          ProgressDialog progressDialog =
                              new ProgressDialog(context);
                          progressDialog.style(
                              message: 'Uploading....',
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

                          await getImage();
                          if (_image != null) {
                            await progressDialog.show();
                            GeneralResposne generalResposne = await uploadImage(
                                'data:image/jpeg;base64,' +
                                    base64Encode(_image.readAsBytesSync()),
                                widget.clientID);
                            if (generalResposne.status) {
                              progressDialog.hide();
                              loadImage();
                              Toast.show(generalResposne.message, context,
                                  gravity: Toast.CENTER,
                                  duration: Toast.LENGTH_LONG);
                            } else {
                              progressDialog.hide();
                              Toast.show(generalResposne.message, context,
                                  gravity: Toast.CENTER,
                                  duration: Toast.LENGTH_LONG);
                            }
                          }
                        },
                        child: const Text('Select & Upload',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
