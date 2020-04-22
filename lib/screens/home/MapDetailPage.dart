import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findagig/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission/permission.dart';

class MapDetail extends StatefulWidget {
  final DocumentSnapshot post;
  const MapDetail({this.post});

  @override
  _MapDetailState createState() => _MapDetailState();
}

class _MapDetailState extends State<MapDetail> {
  bool loading = true;

  final Set<Marker> _markers = new Set();
  Position pos;

  List<LatLng> markers = List();
  List<LatLng> routeCoords;

  static LatLng _mainLocation;
  static LatLng _currentPos;

  final Set<Polyline> polyline = {};
  GoogleMapPolyline googleMapPolyline = new GoogleMapPolyline(apiKey: "AIzaSyDG6w3Kp-jMS5hWqdLpehltArucB0MH-MY");

  GoogleMapController _controller;

  Future<Position> getCurrentPosition() async
  {
    Position res = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      pos = res;
      _currentPos = LatLng(pos.latitude, pos.longitude);
      loading = false;
    });
    return res;
  }

  @override
  void initState() {
    getCurrentPosition();

    _mainLocation = LatLng(widget.post.data['local'].latitude, widget.post.data['local'].longitude);

    if(_mainLocation != null){
      markers.add(_mainLocation);
    }

    if(_currentPos != null) {
      markers.add(_currentPos);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : MaterialApp(
      home: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _mainLocation,
                    zoom: 12.0,
                  ),
                  markers: this.myMarker(),
                  polylines: polyline,
                  mapType: MapType.normal,
                  onMapCreated: _onMapCreated,
                  //polylines: polyline,
                ),
              ),
            ],
          )),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;

      polyline.add(Polyline(
          polylineId: PolylineId('route1'),
          visible: true,
          points: [_mainLocation, _currentPos],
          width: 4,
          color: Colors.blue,
          startCap: Cap.roundCap,
          endCap: Cap.buttCap));
    });
  }

  Set<Marker> myMarker() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_mainLocation.toString()),
        position: _mainLocation,
        infoWindow: InfoWindow(
          title: widget.post.data['name'],
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(2),
      ));

      _markers.add(
          Marker(
            // This marker id can be anything that uniquely identifies each marker.
            markerId: MarkerId("Your position"),
            position: _currentPos,
            icon: BitmapDescriptor.defaultMarkerWithHue(100),
            infoWindow: InfoWindow(
              title: "Your position",
            ),
          ));
    });
    return _markers;
  }
}



