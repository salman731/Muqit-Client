import 'package:flutter/material.dart';

class TaskerMenuWidget extends StatelessWidget {
  final Function(String) onItemClick;
  final String email;
  final String name;

  const TaskerMenuWidget({Key key, this.onItemClick, this.email, this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.green[800], Colors.green[500]],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft),
            ),
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                CircleAvatar(
                  radius: 43,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('asset/images/muqitlogo.jpg'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  name,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'BalsamiqSans'),
                ),
                SizedBox(
                  height: 20,
                ),
                sliderItem('Task History', Icons.history),
                sliderItem('All Appointments', Icons.lock_clock),
                sliderItem('Chats', Icons.chat),
                sliderItem('Settings', Icons.settings),
                sliderItem('Contact Us', Icons.contact_page),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget sliderItem(String title, IconData icons) => ListTile(
      title: Text(
        title,
        style:
            TextStyle(color: Colors.white, fontFamily: 'BalsamiqSans_Regular'),
      ),
      leading: Icon(
        icons,
        color: Colors.white,
      ),
      onTap: () {
        onItemClick(title);
      });
}
