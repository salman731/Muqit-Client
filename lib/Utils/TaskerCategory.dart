//import 'dart:html';
import 'package:Muqit/Screens/ClientScreens/TaskerList.dart';
import 'package:Muqit/Utils/PostTask.dart';
import 'package:flutter/material.dart';

class TaskerCategory extends StatelessWidget {
  // void widget(),
  // This widget is the root of your application.
  final String clientID, name;
  TaskerCategory(this.clientID, this.name, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green[50],
        body: Center(
            child: ListView(
          children: [
            Column(
              children: [
                Container(
                    child: Table(
                  // border: TableBorder.all(),
                  columnWidths: {
                    0: FractionColumnWidth(.33),
                    1: FractionColumnWidth(.33),
                    2: FractionColumnWidth(.33),
                  },
                  children: [
                    TableRow(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Taskerlist(
                                        "Beautician", clientID, name)));
                          },
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset(
                                  "asset/images/beautician.png",
                                  height: 40,
                                  width: 40,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                              ),
                              Text(
                                "Beautician",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Taskerlist(
                                        "Grocery-Man", clientID, name)));
                          },
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset(
                                  "asset/images/groceryman.png",
                                  height: 40,
                                  width: 40,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                              ),
                              Text(
                                "Grocery Man",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Taskerlist("Painter", clientID, name)));
                          },
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset(
                                  "asset/images/painter.png",
                                  height: 40,
                                  width: 40,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                              ),
                              Text(
                                "Painter",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
                SizedBox(
                  height: 20,
                ),
                Container(
                    child: Table(
                  // border: TableBorder.all(),
                  columnWidths: {
                    0: FractionColumnWidth(.33),
                    1: FractionColumnWidth(.33),
                    2: FractionColumnWidth(.33),
                  },
                  children: [
                    TableRow(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Taskerlist(
                                        "Electrician", clientID, name)));
                          },
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset(
                                  "asset/images/electrician.png",
                                  height: 40,
                                  width: 40,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                              ),
                              Text("Electrician",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                  textAlign: TextAlign.center)
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Taskerlist(
                                        "Mechanic", clientID, name)));
                          },
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset(
                                  "asset/images/mechanic.png",
                                  height: 40,
                                  width: 40,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                              ),
                              Text("Mechanics",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                  textAlign: TextAlign.center)
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Taskerlist("Welder", clientID, name)));
                          },
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset(
                                  "asset/images/welder.png",
                                  height: 40,
                                  width: 40,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                              ),
                              Text("Welder",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                  textAlign: TextAlign.center)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
                SizedBox(
                  height: 20,
                ),
                Container(
                    child: Table(
                  // border: TableBorder.all(),
                  columnWidths: {
                    0: FractionColumnWidth(.33),
                    1: FractionColumnWidth(.33),
                    2: FractionColumnWidth(.33),
                  },
                  children: [
                    TableRow(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Taskerlist(
                                        "Carpenter", clientID, name)));
                          },
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset(
                                  "asset/images/carpenter.png",
                                  height: 40,
                                  width: 40,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                              ),
                              Text("Carpenter",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                  textAlign: TextAlign.center)
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Taskerlist(
                                        "Spray-Man", clientID, name)));
                          },
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset(
                                  "asset/images/sprayman.png",
                                  height: 40,
                                  width: 40,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                              ),
                              Text("Spray Man",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                  textAlign: TextAlign.center)
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Taskerlist(
                                        "Handyman", clientID, name)));
                          },
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset(
                                  "asset/images/generalhandyman.png",
                                  height: 40,
                                  width: 40,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                              ),
                              Text("General Handyman",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                  textAlign: TextAlign.center)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
                SizedBox(
                  height: 20,
                ),
                Container(
                    child: Table(
                  // border: TableBorder.all(),
                  columnWidths: {
                    0: FractionColumnWidth(.33),
                    1: FractionColumnWidth(.33),
                    2: FractionColumnWidth(.33),
                  },
                  children: [
                    TableRow(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Taskerlist(
                                        "Driving-Instructor", clientID, name)));
                          },
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset(
                                  "asset/images/drivinginstructor.png",
                                  height: 40,
                                  width: 40,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                              ),
                              Text("Driving Instructor",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                  textAlign: TextAlign.center)
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Taskerlist(
                                        "Pick-n-Drop", clientID, name)));
                          },
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset(
                                  "asset/images/picanddrop.png",
                                  height: 40,
                                  width: 40,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                              ),
                              Text("Pick and Drop",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                  textAlign: TextAlign.center)
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Taskerlist(
                                        "Car-Wash", clientID, name)));
                          },
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset(
                                  "asset/images/car-wash.png",
                                  height: 40,
                                  width: 40,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                              ),
                              Text("Car Wash",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                  textAlign: TextAlign.center)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
                SizedBox(
                  height: 20,
                ),
                Container(
                    child: Table(
                  // border: TableBorder.all(),
                  columnWidths: {
                    0: FractionColumnWidth(.33),
                    1: FractionColumnWidth(.33),
                    2: FractionColumnWidth(.33),
                  },
                  children: [
                    TableRow(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Taskerlist(
                                        "Commercial-Cleaning",
                                        clientID,
                                        name)));
                          },
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset(
                                  "asset/images/commercialcleaning.png",
                                  height: 40,
                                  width: 40,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                              ),
                              Text("Commercial Cleaning",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                  textAlign: TextAlign.center)
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Taskerlist("Tutor", clientID, name)));
                          },
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset(
                                  "asset/images/tutor.png",
                                  height: 40,
                                  width: 40,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                              ),
                              Text("Tutor",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                  textAlign: TextAlign.center)
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Taskerlist("Tailor", clientID, name)));
                          },
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset(
                                  "asset/images/sewing-machine.png",
                                  height: 40,
                                  width: 40,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                              ),
                              Text("Tailor",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                  textAlign: TextAlign.center)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
                SizedBox(
                  height: 20,
                ),
                Container(
                    child: Table(
                  // border: TableBorder.all(),
                  columnWidths: {
                    0: FractionColumnWidth(.33),
                    1: FractionColumnWidth(.33),
                    2: FractionColumnWidth(.33),
                  },
                  children: [
                    TableRow(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Taskerlist(
                                        "CCTV & Fire Alarm Installers",
                                        clientID,
                                        name)));
                          },
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset(
                                  "asset/images/CCTV.png",
                                  height: 40,
                                  width: 40,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                              ),
                              Text(
                                "CCTV and Fire Alarm Installer",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Taskerlist(
                                        "Laptop-Repair", clientID, name)));
                          },
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset(
                                  "asset/images/computerrepair.png",
                                  height: 40,
                                  width: 40,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                              ),
                              Text("Computer/Laptop Repairs",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                  textAlign: TextAlign.center)
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Taskerlist(
                                        "Blacksmith", clientID, name)));
                          },
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset(
                                  "asset/images/blacksmith.png",
                                  height: 40,
                                  width: 40,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                              ),
                              Text("Black Smith",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                  textAlign: TextAlign.center)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
                SizedBox(
                  height: 20,
                ),
                Container(
                    child: Table(
                        // border: TableBorder.all(),
                        columnWidths: {
                      0: FractionColumnWidth(.33),
                      1: FractionColumnWidth(.33),
                      2: FractionColumnWidth(.33),
                    }, children: [
                  TableRow(children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Taskerlist("Plumber", clientID, name)));
                      },
                      child: Column(
                        children: [
                          Container(
                            child: Image.asset(
                              "asset/images/plumber.png",
                              height: 40,
                              width: 40,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                          ),
                          Text("Plumber",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                              textAlign: TextAlign.center)
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Taskerlist("Gardener", clientID, name)));
                      },
                      child: Column(
                        children: [
                          Container(
                            child: Image.asset(
                              "asset/images/gardener.png",
                              height: 40,
                              width: 40,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                          ),
                          Text("Gardener",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                              textAlign: TextAlign.center)
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Taskerlist(
                                    "Door-to-Door-Advertising",
                                    clientID,
                                    name)));
                      },
                      child: Column(
                        children: [
                          Container(
                            child: Image.asset(
                              "asset/images/door-to-door-services.png",
                              height: 40,
                              width: 40,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                          ),
                          Text("Door-to-Door Services",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                              textAlign: TextAlign.center)
                        ],
                      ),
                    ),
                  ])
                ])),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Table(
                      // border: TableBorder.all(),
                      columnWidths: {
                        0: FractionColumnWidth(.33),
                        1: FractionColumnWidth(.33),
                        2: FractionColumnWidth(.33),
                      }, children: [
                    TableRow(children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Taskerlist(
                                      "Delivery-Drivers", clientID, name)));
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Image.asset(
                                "asset/images/delivery-man.png",
                                height: 40,
                                width: 40,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                            ),
                            Text("Delivery Driver",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                                textAlign: TextAlign.center)
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Taskerlist(
                                      "Home-Cleaning", clientID, name)));
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Image.asset(
                                "asset/images/homecleaning.png",
                                height: 40,
                                width: 40,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                            ),
                            Text("Home Cleaning",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                                textAlign: TextAlign.center)
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Taskerlist(
                                      "Mobile-Phone-Repair", clientID, name)));
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Image.asset(
                                "asset/images/mobilerepaires.png",
                                height: 40,
                                width: 40,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                            ),
                            Wrap(
                              children: [
                                Text("Mobile Repairs",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black),
                                    textAlign: TextAlign.center)
                              ],
                            )
                          ],
                        ),
                      ),
                    ])
                  ]),
                  margin: EdgeInsets.only(bottom: 30),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Table(
                      // border: TableBorder.all(),
                      columnWidths: {
                        0: FractionColumnWidth(.33),
                        1: FractionColumnWidth(.33),
                        2: FractionColumnWidth(.33),
                      }, children: [
                    TableRow(children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Taskerlist(
                                      "Visa-Service", clientID, name)));
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Image.asset(
                                "asset/images/Visa_services.png",
                                height: 40,
                                width: 40,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                            ),
                            Text("Visa Services",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                                textAlign: TextAlign.center)
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Taskerlist(
                                      "Utility-Tasker", clientID, name)));
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Image.asset(
                                "asset/images/utility-tasker.png",
                                height: 40,
                                width: 40,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                            ),
                            Text("Utility Services",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                                textAlign: TextAlign.center)
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Taskerlist(
                                      "Pet-Service", clientID, name)));
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Image.asset(
                                "asset/images/pet-services.png",
                                height: 40,
                                width: 40,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                            ),
                            Wrap(
                              children: [
                                Text("Pet Services",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black),
                                    textAlign: TextAlign.center)
                              ],
                            )
                          ],
                        ),
                      ),
                    ])
                  ]),
                  margin: EdgeInsets.only(bottom: 30),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Table(
                      // border: TableBorder.all(),
                      columnWidths: {
                        0: FractionColumnWidth(.33),
                        1: FractionColumnWidth(.33),
                        2: FractionColumnWidth(.33),
                      }, children: [
                    TableRow(children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Taskerlist("Nurse", clientID, name)));
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Image.asset(
                                "asset/images/nurse.png",
                                height: 40,
                                width: 40,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                            ),
                            Text("Nursing Services",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                                textAlign: TextAlign.center)
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Taskerlist(
                                      "Lab-Service", clientID, name)));
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Image.asset(
                                "asset/images/lab-services.png",
                                height: 40,
                                width: 40,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                            ),
                            Text("Lab Services",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                                textAlign: TextAlign.center)
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Taskerlist(
                                      "Glass-Tasker", clientID, name)));
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Image.asset(
                                "asset/images/glass-tasker.png",
                                height: 40,
                                width: 40,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                            ),
                            Wrap(
                              children: [
                                Text("Glass Tasker",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black),
                                    textAlign: TextAlign.center)
                              ],
                            )
                          ],
                        ),
                      ),
                    ])
                  ]),
                  margin: EdgeInsets.only(bottom: 30),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Table(
                      // border: TableBorder.all(),
                      columnWidths: {
                        0: FractionColumnWidth(.33),
                        1: FractionColumnWidth(.33),
                        2: FractionColumnWidth(.33),
                      }, children: [
                    TableRow(children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Taskerlist(
                                      "Fitness-Trainer", clientID, name)));
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Image.asset(
                                "asset/images/fitness-trainer.png",
                                height: 40,
                                width: 40,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                            ),
                            Text("Fitness Trainer",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                                textAlign: TextAlign.center)
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Taskerlist(
                                      "Event-Managment", clientID, name)));
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Image.asset(
                                "asset/images/Event-managment.png",
                                height: 40,
                                width: 40,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                            ),
                            Text("Event Managment",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                                textAlign: TextAlign.center)
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Taskerlist(
                                      "Overall-Hiring", clientID, name)));
                        },
                        child: Column(
                          children: [
                            Container(
                              child: Image.asset(
                                "asset/images/hiring.png",
                                height: 40,
                                width: 40,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                            ),
                            Wrap(
                              children: [
                                Text("Overall Hiring",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black),
                                    textAlign: TextAlign.center)
                              ],
                            )
                          ],
                        ),
                      ),
                    ])
                  ]),
                  margin: EdgeInsets.only(bottom: 30),
                ),
              ],
            )
          ],
        )));
  }
}
