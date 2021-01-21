import 'dart:ui';
import 'package:Muqit/Screens/ClientScreens/TaskerList.dart';
import 'package:Muqit/Utils/TaskerCategory.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:flutter/material.dart';
import 'DrawerBody.dart';
import 'PostTask.dart';
import 'Map.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrwerState createState() => _NavigationDrwerState();
}

class _NavigationDrwerState extends State<NavigationDrawer> {
  GlobalKey<SliderMenuContainerState> _key =
      new GlobalKey<SliderMenuContainerState>();
  var title = "Tasker Category";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SliderMenuContainer(
          appBarColor: Colors.white,
          key: _key,
          sliderOpen: SliderOpen.LEFT_TO_RIGHT,
          appBarPadding: const EdgeInsets.only(top: 10),
          sliderMenuOpenOffset: 210,
          appBarHeight: 60,
          title: Text(
            title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          sliderMenu: MenuWidget(
            onItemClick: (title) {
              _key.currentState.closeDrawer();
              setState(() {
                this.title = title;
              });
            },
          ),
          sliderMain: Views(title, _key)),
    );
  }

  Widget Views(var _title, GlobalKey<SliderMenuContainerState> _key) {
    switch (_title) {
      case "Tasker Category":
        {
          return null;
        }
      case "All Appointments":
        {
          return null;
        }
      case "Messages":
        {
          return Center(
            child: Text("Messages"),
          );
        }
      case "Settings":
        {
          return Center(
            child: Text("Settings"),
          );
        }
      case "LogOut":
        {
          return Center(
            child: Text("LogOut"),
          );
        }
    }
  }
}
