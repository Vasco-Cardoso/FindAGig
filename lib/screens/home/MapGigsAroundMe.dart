import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findagig/screens/home/detailGigPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MapsDemo());

class MapsDemo extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MapsDemo> {
  final Set<Marker> _markers = new Set();
  static LatLng _mainLocation;
  GoogleMapController myMapController;
  Position pos;
  QuerySnapshot qn;

  void initState()
  {
    getCurrentPosition();
    getGigs();
    super.initState();
  }

  navigateToDetail(DocumentSnapshot post)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailGig(post : post)));
  }

  void getCurrentPosition() async
  {
    Position res = await Geolocator().getCurrentPosition();
    setState(() {
      pos = res;
      _mainLocation = LatLng(pos.latitude, pos.longitude);
    });
  }

  // Get documents so we can get all the values of locations
  Future getGigs() async
  {
    var firestore = Firestore.instance;

    qn = await firestore.collection("gigs").getDocuments();

    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    // Se a informação ainda não tiver sido recebida mostra um loading
    if(qn == null)
      return Container(
        color: Colors.white,
        child: Center (
          child: SpinKitChasingDots (
            color: Colors.yellow,
            size: 50.0,
          ),
        )
    );


    return MaterialApp(
        home: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _mainLocation,
                      zoom: 10.0,
                    ),
                    markers: myMarker(),
                    mapType: MapType.normal,
                    onMapCreated: onMapCreate,
                  ),
                ),
              ],
            )),
    );
  }

  Set<Marker> myMarker() {
    // Adiciona o marker correspondente ao utilizador
    _markers.add(
        Marker(
          // This marker id can be anything that uniquely identifies each marker.
          markerId: MarkerId(_mainLocation.toString()),
          position: _mainLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(100),
          infoWindow: InfoWindow(
            title: "Your position",
          ),
        ));

    void _onButtonPressed(doc, name, description, reward, contacto) {
      showModalBottomSheet(
          context: context ,
          builder: (context) {
            return Column (
              children: <Widget>[
                Card(
                  child: ListTile(
                    title: Text(name, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text("Description", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                    subtitle: Text(description),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text("Reward", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, ),textAlign: TextAlign.center),
                    subtitle: Text(reward.toString() + "€"),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text("Contact", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, ),textAlign: TextAlign.center),
                    subtitle: Text(contacto.toString()),
                  ),
                ),
                FlatButton (
                  onPressed: () {
                    print("ver descr");
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailGig(post: doc)));
                  },
                  child: Text ("See gig!"),
                  color: Colors.blue[200],
                ),
              ],
            );
          }
      );
    }

    // Adiciona o marker correspondente a todos os eventod
    for(var i in qn.documents)
    {
      if(!i['taken']) {
        _markers.add(
            Marker(
              onTap: () => _onButtonPressed(i,i['name'],i['description'],i['reward'], i['contact']),
              markerId: MarkerId(i['name'] as String),
              icon: BitmapDescriptor.defaultMarkerWithHue(200),
              position: LatLng(
                i['local'].latitude as double,
                i['local'].longitude as double,
              ),
              infoWindow: InfoWindow(
                title: i['name'] as String,
              ),
            )
        );
      }
    }
    return _markers;
  }

  void onMapCreate(GoogleMapController controller) async{
    setState(() {
      myMapController = controller;
    });
  }
}


