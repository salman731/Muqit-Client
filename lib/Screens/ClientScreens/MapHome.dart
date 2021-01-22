import 'dart:ui';
import 'package:Muqit/Models/SingleTakserModel.dart';
import 'package:Muqit/Models/TaskerLocation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:location/location.dart';
import 'dart:typed_data';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class HomeMapClass extends StatefulWidget {
  final String tid;
  HomeMapClass(this.tid, {Key key}) : super(key: key);
  @override
  _HomeMapClassState createState() => _HomeMapClassState();
}

class _HomeMapClassState extends State<HomeMapClass> {
  GoogleMapController _controller;
  bool _serviceEnabled;
  StreamSubscription _locationSubscription;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  Location location = new Location();
  Marker marker;
  Circle circle;
  Timer timer;
  bool isMe = true;
  bool isMapLoading = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Map<MarkerId, Marker> markers = new Map<MarkerId, Marker>();
  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("asset/images/car_icon.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LatLng newLocalData, Uint8List imageData) {
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: newLocalData,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));
      circle = Circle(
          circleId: CircleId("car"),
          zIndex: 1,
          strokeColor: Colors.green,
          center: newLocalData,
          fillColor: Colors.green.withAlpha(70));
    });
  }

  Future<void> getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();
      var _location = await location.getLocation();
      LatLng latlng = LatLng(_location.latitude, _location.longitude);
      updateMarkerAndCircle(latlng, imageData);
      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }
      _controller.animateCamera(CameraUpdate.newCameraPosition(
          new CameraPosition(
              bearing: 192.8334901395799,
              target: LatLng(_location.latitude, _location.longitude),
              tilt: 0,
              zoom: 18.00)));
      timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
        tracking(imageData);
      });
      /* await location.changeSettings(interval: 500);
      _locationSubscription = location.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          updateMarkerAndCircle(newLocalData, imageData);
        }
      });*/
    } catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  tracking(Uint8List imageData) async {
    print('getting location.......' + widget.tid);
    DocumentSnapshot documentSnapshot =
        await firestore.collection('Taskers').doc(widget.tid).get();
    LatLng latLng = LatLng(documentSnapshot.data()['location']['latitude'],
        documentSnapshot.data()['location']['longitude']);
    // print(documentSnapshot.data()['latitude'] +
    //  " " +
    //   documentSnapshot.data()['longitude']);
    updateMarkerAndCircle(latLng, imageData);
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    _controller.dispose();
    super.dispose();
  }

  void AddMarkers(
      LatLng latLng, BuildContext context, String id, String eta) async {
    String picurl;
    MarkerId markerId = MarkerId(
        latLng.latitude.toString() + "," + latLng.longitude.toString());
    List<SingleTasker> singletaskerList = await getTaskerDetails(id);
    if (singletaskerList.elementAt(0).profile != '') {
      final response = await http.get("https://www.muqit.com/app/upload/" +
          singletaskerList.elementAt(0).profile);
      if (response.statusCode == 200) {
        picurl = "https://www.muqit.com/app/upload/" +
            singletaskerList.elementAt(0).profile;
      } else {
        picurl = '';
      }
    } else {
      picurl = '';
    }
    Marker marker = new Marker(
      onTap: () {
        showModalBottomSheet(
            context: context,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            builder: (BuildContext context) {
              return Container(
                  height: 100,
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    child: Row(
                      children: [
                        CircleAvatar(
                          child: picurl != ''
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(34.0),
                                  child: Image.network(
                                    picurl,
                                    fit: BoxFit.fill,
                                    width: 65,
                                    height: 65,
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace stackTrace) {},
                                  ),
                                )
                              : Icon(Icons.account_box_outlined,
                                  color: Colors.white, size: 30),
                          radius: 34,
                          backgroundColor: Colors.green,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            Expanded(
                                child: Row(
                              children: [
                                Text(
                                  "Name :",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  singletaskerList.elementAt(0).name,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            )),
                            Expanded(
                                child: Row(
                              children: [
                                Text(
                                  "Address :",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  singletaskerList.elementAt(0).address,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            )),
                            Expanded(
                                child: Row(
                              children: [
                                Text(
                                  "ETA :",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  eta + " mins",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ))
                          ],
                        ))
                      ],
                    ),
                  ));
            });
      },
      markerId: markerId,
      position: latLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  void AddMarkersofME(
    LatLng latLng,
    BuildContext context,
  ) {
    MarkerId markerId = MarkerId(
        latLng.latitude.toString() + "," + latLng.longitude.toString());
    Marker marker = new Marker(
        markerId: markerId,
        position: latLng,
        infoWindow: InfoWindow(
            title: "My Location",
            snippet: latLng.latitude.toString() +
                " ," +
                latLng.longitude.toString()),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));
    setState(() {
      markers[markerId] = marker;
    });
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 60.0,
  );
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  @override
  void initState() {
    GetPermissions(_permissionGranted, location);
    GetServicePermissions(_serviceEnabled, location);
  }

  getcurrentLocation(LatLng currentlatLng, BuildContext context) async {
    AddMarkersofME(currentlatLng, context);
    _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
        bearing: 192.8334901395799,
        target: currentlatLng,
        tilt: 0,
        zoom: 18.00)));
  }

  Future<List<SingleTasker>> getTaskerDetails(String id) async {
    String uri = "https://www.muqit.com/app/fetch_singletasker.php";
    http.Response response = await http.post(uri, body: {'id': id});
    return singleTaskerFromJson(response.body);
  }

  List<TaskerLocation> taskerLocationList = List<TaskerLocation>();
  getAllTaskersLocation(LatLng currentlatLng, BuildContext context) async {
    isMe = false;

    await FirebaseFirestore.instance
        .collection('Taskers')
        .get()
        .then((querysnapshot) {
      querysnapshot.docs.forEach((element) {
        print(element.id);
        double distance = Geolocator.distanceBetween(
            currentlatLng.latitude,
            currentlatLng.longitude,
            element.data()['location']['latitude'],
            element.data()['location']['longitude']);
        double distanceInKm = distance / 1000;
        double time = distanceInKm / 40;
        double timeinMin = time * 60;
        if (distance < 5000.0) {
          LatLng tlatLng = new LatLng(element.data()['location']['latitude'],
              element.data()['location']['longitude']);

          AddMarkers(tlatLng, context, element.id, timeinMin.ceil().toString());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            // myLocationEnabled: true,
            mapType: MapType.terrain,
            initialCameraPosition: _kGooglePlex,
            markers: Set.of(markers.values),
            //markers: Set.of((marker != null) ? [marker] : []),
            //circles: Set.of((circle != null) ? [circle] : []),
            onMapCreated: (GoogleMapController controller) async {
              _controller = controller;
              LocationData locationData = await location.getLocation();
              LatLng currentlatLng =
                  new LatLng(locationData.latitude, locationData.longitude);
              getcurrentLocation(currentlatLng, context);
              getAllTaskersLocation(currentlatLng, context);
            },
            // markers: Set<Marker>.of(markers.values),
          ),
        ],
      ),
    );
  }
}

Future<void> GetServicePermissions(
    bool serviceenable, Location location) async {
  serviceenable = await location.serviceEnabled();
  if (!serviceenable) {
    serviceenable = await location.requestService();
    if (!serviceenable) {
      return;
    }
  }
}

Future<void> GetPermissions(
    PermissionStatus _permissionGranted, Location location) async {
  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }
}
