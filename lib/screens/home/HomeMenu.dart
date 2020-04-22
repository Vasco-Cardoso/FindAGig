import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findagig/main.dart';
import 'package:findagig/models/user.dart';
import 'package:findagig/screens/home/QRCodePage.dart';
import 'package:findagig/screens/home/MapGigsAroundMe.dart';
import 'package:findagig/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'SearchPage.dart';
import 'SettingsPage.dart';
import 'detailGigPage.dart';
import 'GigListPage.dart';


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        //color: Colors.white,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(40),
                  constraints: BoxConstraints.expand(height: 170),
                  decoration: BoxDecoration(
                      color: Color(0xFF404040),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight:  Radius.circular(30))
                  ),
                  child: Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Welcome',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 55
                          ),
                        ),
                        Text('!',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xFFFFEA00),
                              fontWeight: FontWeight.bold,
                              fontSize: 55
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    height: 430,
                    margin: EdgeInsets.only(top: 155),
                    padding: EdgeInsets.all(20),
                    child: ListView(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SearchPage()),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10, left: 10, bottom: 15),
                            height: 50,
                            width: 300,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10.0,
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Find a gig",
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF404040),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MapsDemo()),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10, left: 10, bottom: 15),
                            height: 48,
                            width: 300,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10.0,
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Text("See gigs around me", style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF404040),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23
                                ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => GigList(
                                Title: 'History',
                                Name: null,
                                Employer: null,
                                Revenue_max: null,
                                Taken: null,
                                Employee: user.uid,
                              ),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10, left: 10, bottom: 15),
                            height: 48,
                            width: 300,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10.0,
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Text("History", style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF404040),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23
                                ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => QrCodePage()),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10, left: 10, bottom: 15),
                            height: 48,
                            width: 300,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10.0,
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Text("Read QR Code", style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF404040),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23
                                ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: ()
                          {
                            while(user == null)
                            {

                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingsPage(user.uid)),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10, left: 10, bottom: 15),
                            height: 48,
                            width: 300,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10.0,
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Text("Settings", style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF404040),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23
                                ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async
                          {
                            await _auth.signOut();
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10, left: 10, bottom: 15),
                            height: 48,
                            width: 300,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10.0,
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Text("Logout", style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF404040),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23
                                ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

              ],
            )
          ],
        ),
      ),
    );
  }
}


