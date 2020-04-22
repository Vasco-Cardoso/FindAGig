import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findagig/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'detailGigPage.dart';

class GigListHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Menu",
      theme: new ThemeData(
        primaryColor: Colors.yellow[700],
      ),
      home: new GigList(
        Title: '',
        Name: null,
        Employer: null,
        Revenue_max: null,
        Taken: null,
        Employee: null,
      ),
    );
  }
}

class GigList extends StatefulWidget{
  GigList({Key key, this.Title, this.Name, this.Employer, this.Revenue_max, this.Taken, this.Employee, this.Revenue_min, this.City, this.Type}) : super(key: key);

  final String Title;
  final String Name;
  final String Employer;
  final String Employee;
  final int Revenue_max;
  final int Revenue_min;
  final bool Taken;
  final String City;
  final String Type;

  @override
  _GigListState createState() => new _GigListState();

}

class _GigListState  extends State<GigList>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(widget.Title),
        backgroundColor: Colors.yellow[700],
      ),
      body: ListGigs(widget.Name, widget.Employer, widget.Revenue_max, widget.Revenue_min, widget.Taken, widget.Employee, widget.City, widget.Type),
    );
  }
}

class ListGigs extends StatefulWidget {
  final String name;
  final String employer;
  final String employee;
  final String city;
  final String type;
  final int revenue_max;
  final int revenue_min;
  final bool taken;

  ListGigs(this.name, this.employer, this.revenue_max, this.revenue_min, this.taken, this.employee, this.city, this.type);

  @override
  _ListGigsState createState() => _ListGigsState();
}

class _ListGigsState extends State<ListGigs> {
  Stream<QuerySnapshot> qn;

  Stream<QuerySnapshot> getGigs() {
    var firestore = Firestore.instance;

    if(widget.employee == null)
    {
      if(widget.type == "")
      {
        qn = firestore.collection("gigs")
            .where('taken', isEqualTo: widget.taken)
            .where('name', isEqualTo: widget.name)
            .where('reward', isGreaterThanOrEqualTo: widget.revenue_min)
            .where('reward', isLessThanOrEqualTo: widget.revenue_max)
            .where('employer', isEqualTo: widget.employer)
            .where('city', isEqualTo: widget.city)
            .snapshots();
      }
      else
      {
        qn = firestore.collection("gigs")
            .where('taken', isEqualTo: widget.taken)
            .where('name', isEqualTo: widget.name)
            .where('reward', isGreaterThanOrEqualTo: widget.revenue_min)
            .where('reward', isLessThanOrEqualTo: widget.revenue_max)
            .where('employer', isEqualTo: widget.employer)
            .where('type', isEqualTo: "TYPE_OF_GIG." + widget.type.toUpperCase())
            .where('city', isEqualTo: widget.city)
            .snapshots();
      }
    }
    else{
      var aux = 'users/'+widget.employee;

      qn = firestore.collection("gigs")
          .where('taken', isEqualTo: widget.taken)
          .where('name', isEqualTo: widget.name)
          .where('reward', isGreaterThanOrEqualTo: widget.revenue_min)
          .where('reward', isLessThanOrEqualTo: widget.revenue_max)
          .where('employer', isEqualTo: widget.employer)
          .where('city', isEqualTo: widget.city)
          .where('employee', isEqualTo: aux )
          .snapshots();
    }

    return qn;
  }

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailGig(post: post)));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getGigs(),
      // ignore: missing_return
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Container(
              color: Colors.white,
              child: Center(
                child: SpinKitChasingDots(
                  color: Colors.yellow,
                  size: 50.0,
                ),
              )
          );
        return new ListView (
          // ignore: missing_return
          children: snapshot.data.documents.map((document) {
            return Card(
              child: new ListTile (
                title: Text(document["name"],
                  style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text(document["description"]),
                onTap: () => navigateToDetail(document),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}



