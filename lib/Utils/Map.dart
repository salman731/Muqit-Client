import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:location/location.dart';
import 'dart:typed_data';

class MapClass extends StatefulWidget {
  final String tid;
  MapClass(this.tid, {Key key}) : super(key: key);
  @override
  _MapClassState createState() => _MapClassState();
}

class _MapClassState extends State<MapClass> {
  GoogleMapController _controller;
  bool _serviceEnabled;
  StreamSubscription _locationSubscription;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  Location location = new Location();
  Marker marker;
  Circle circle;
  Timer timer;
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
      //  var _location = await location.getLocation();
      // LatLng latlng = LatLng(_location.latitude, _location.longitude);
      DocumentSnapshot documentSnapshot =
          await firestore.collection('Taskers').doc(widget.tid).get();
      LatLng latLng = LatLng(documentSnapshot.data()['location']['latitude'],
          documentSnapshot.data()['location']['longitude']);
      updateMarkerAndCircle(latLng, imageData);
      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }
      _controller.animateCamera(CameraUpdate.newCameraPosition(
          new CameraPosition(
              bearing: 192.8334901395799,
              target: LatLng(latLng.latitude, latLng.longitude),
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
    // timer.cancel();
    super.dispose();
  }

  void AddMarkers(LatLng latLng) {
    MarkerId markerId = MarkerId(
        latLng.latitude.toString() + "," + latLng.longitude.toString());
    Marker marker = new Marker(
        markerId: markerId,
        position: latLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        infoWindow: InfoWindow(snippet: "Address"));
    setState(() {
      markers[markerId] = marker;
    });
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 20.0,
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.my_location),
        onPressed: () async {
          await getCurrentLocation();
        },
      ),
      appBar: AppBar(
        title: Text(
          "Live Tracking",
          style: TextStyle(fontSize: 22, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.terrain,
            initialCameraPosition: _kGooglePlex,
            markers: Set.of((marker != null) ? [marker] : []),
            circles: Set.of((circle != null) ? [circle] : []),
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
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
