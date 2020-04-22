import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findagig/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'MapDetailPage.dart';

class DetailGig extends StatefulWidget {

  final DocumentSnapshot post;
  final String userID;

  const DetailGig({this.post, this.userID});

  @override
  _DetailGigState createState() => _DetailGigState();
}

class _DetailGigState extends State<DetailGig> {

  String text_on_button = "Apply to gig";
  MaterialColor color_on_button = Colors.red;
  Icon a = new Icon(Icons.check_box_outline_blank);
  bool aux = false;

  void updateFirebase(String id, String uid)
  {
    var a = 'users/' + uid;
    Firestore.instance.collection("gigs").document(id)
        .updateData({'taken' : true});
    Firestore.instance.collection("gigs").document(id)
        .updateData({'employee' : a});
  }

  @override
  void initState()
  {
    if(widget.post.data['taken']) {
      text_on_button = "You applied for this gig!";
      color_on_button = Colors.green;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar (
        elevation: 20,
        backgroundColor: Colors.yellow[700],
        //title: Text(widget.post.data['name']),
      ),
      body: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column (
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[
              Card(
                child: ListTile(
                  title: Text(widget.post.data['name'], style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("Description", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                  subtitle: Text(widget.post.data['description']),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("Reward", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, ),textAlign: TextAlign.center),
                  subtitle: Text(widget.post.data['reward'].toString() + "€"),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("Contact", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                  subtitle: Text(widget.post.data['contact'].toString()),
                  onTap: () => call(widget.post.data['contact'].toString()),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("Employer", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                  subtitle: Text(widget.post.data['employer'].toString()),
                ),
              ),
              Card (
                child: Center (
                  child: QrImage (
                    data: widget.post.documentID.toString(),
                    size: 200,
                  ),
                ),
              ),
              FlatButton (
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MapDetail(post : widget.post)));
                },
                child: Text ("Ver local no mapa"),
                color: Colors.blue[200],
              ),
              FlatButton (
                onPressed: () {
                  updateFirebase(widget.post.documentID, user.uid);

                  setState(() {
                    text_on_button = "You applied for this gig!";
                    color_on_button = Colors.green;
                  });

                },
                child: Text(text_on_button),
                color: color_on_button,
              )
            ],
          ),
        ),

      ),
    );
  }

  void call(String number) {
    launch("tel:$number");
  }
}



