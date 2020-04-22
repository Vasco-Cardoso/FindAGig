import 'package:findagig/models/user.dart';
import 'package:findagig/screens/home/HomeMenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:findagig/models/Type.dart';
import 'GigListPage.dart';

class SearchPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Search(),
    );
  }
}

class Search extends StatefulWidget
{
  Search();

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var name = null;
  var employer = null;
  var type = null;
  var revenue = null;

  List<Type> _types = Type.getTypes();
  List<DropdownMenuItem<Type>> _dropdownMenuItems;
  Type _selectedType;

  var _name = "";
  var _employer = "";
  var _city = "";

  @override
  void initState(){

    _dropdownMenuItems = buildDropDownMenuItems(_types);
    _selectedType = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Type>> buildDropDownMenuItems(List types){

    List<DropdownMenuItem<Type>> items = List();

    for(Type type in types)
    {
      items.add(DropdownMenuItem(
        value: type,
        child: Text(
            type.name ),
      ),
      );
    }

    return items;
  }

  onChangeDropdownItem(Type selectedType){

    setState(() {
      _selectedType = selectedType;
    });
  }

  RangeValues _values = RangeValues(0, 100);
  RangeLabels labels = RangeLabels('0', '100');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: Color(0xFFEFEEF5),
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
                    padding: EdgeInsets.only(top: 25),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('SEARCH',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 55
                          ),
                        ),
                        Text('.',
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
                  height: 442,
                  margin: EdgeInsets.only(top: 150),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top:15, left: 20.0, right: 20.0),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Name',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.yellow)
                                  )
                              ),
                              onChanged: (val) {
                                _name = val;
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Employer',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.yellow)
                                  )
                              ),
                              onChanged: (val) {
                                _employer = val;
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'City Name',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.yellow)
                                  )
                              ),
                              onChanged: (val) {
                                _city = val.toString();
                              },
                            ),
                            DropdownButtonFormField(
                              items: _dropdownMenuItems,
                              value: _selectedType,
                              onChanged: onChangeDropdownItem,
                              decoration: InputDecoration(
                                labelText: 'Type',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.grey
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Text('Revenue',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15
                                  ),
                                ),
                              ),
                            ),
                            RangeSlider(
                              values: _values,
                              labels: labels,
                              onChanged: (value){
                                setState(() {
                                  _values = value;
                                  labels = RangeLabels(value.start.toInt().toString(), value.end.toInt().toString());
                                });
                              },
                              min: 0,
                              max: 100,
                              divisions: 10,
                            ),
                            SizedBox(height: 5,),
                            InkWell(
                              onTap: () {
                                if (_name != null) {
                                  if(_name.length == 0) {
                                    _name = null;
                                  }
                                }
                                if (_employer != null) {
                                  if (_employer.length == 0) {
                                    _employer = null;
                                  }
                                }
                                if (_city != null) {
                                  if (_city.length == 0) {
                                    _city = null;
                                  }
                                }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => GigList(
                                    Title: 'Search result',
                                    Name: _name,
                                    Employer: _employer,
                                    Revenue_max: _values.end.toInt(),
                                    Revenue_min: _values.start.toInt(),
                                    City: _city,
                                    Type: _selectedType.name,
                                    Taken: false,
                                    Employee: null,
                                  ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 41.0,
                                color: Colors.transparent,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black,
                                          style: BorderStyle.solid,
                                          width: 1.0
                                      ),
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(20.0)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Center(
                                        child: Text('Search',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Montserrat'
                                            )
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}