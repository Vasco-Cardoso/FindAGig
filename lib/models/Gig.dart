import 'package:cloud_firestore/cloud_firestore.dart';

class Gig
{
  final String city;
  final String name;
  final String type;
  final GeoPoint coords;

  Gig({this.city, this.name, this.type, this.coords});
}