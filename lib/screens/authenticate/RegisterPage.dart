import 'package:findagig/screens/authenticate/LogInPage.dart';
import 'package:findagig/services/auth.dart';
import 'package:findagig/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();

}

class _RegisterState extends State<Register>{

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String mail = '';
  String password = '';
  String error = '';
  String name = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return loading ? Loading() : Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(5.0, 110.0, 0.0, 0.0),
                      child: Text(
                        'SignUp',
                        style:
                        TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(250.0, 125.0, 0.0, 0.0),
                      child: Text(
                        '.',
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (val) {
                          if(!val.contains("@"))
                          {
                            return 'Please enter a valid mail';
                          }
                          else
                          {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'EMAIL',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.yellow))
                        ),
                        onChanged: (val) {
                          setState(() => mail = val);
                        },
                      ),
                      SizedBox(height: 5.0),
                      TextFormField(
                        validator: (val) {
                          if(val.length < 6)
                          {
                            return('Enter a password longer than 6 chars');
                          }
                          else
                          {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'PASSWORD ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.yellow))),
                        obscureText: true,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(height: 5.0),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'NICK NAME ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.yellow))
                        ),
                        onChanged: (val) {
                          setState(() => name = val);
                        },
                      ),
                      SizedBox(height: 30.0),
                      Container(
                          height: 40.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.yellowAccent,
                            color: Colors.yellow,
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: () async {
                                setState(() {
                                  loading = true;
                                });

                                dynamic result = await _auth.registerWithMail(mail, password, name);

                                if(result == null)
                                {
                                  setState(() {
                                    error = 'Please validate your options';
                                    loading = false;
                                  });
                                }
                              },
                              child: Center(
                                child: Text(
                                  'SIGNUP',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'),
                                ),
                              ),
                            ),
                          )),
                      SizedBox(height: 20.0),
                      Container(
                        height: 40.0,
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 1.0),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: InkWell(
                            onTap: () {
                              widget.toggleView();
                            },
                            child:
                            Center(
                              child: Text('Go Back',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat')),
                            ),
                          ),
                        ),
                      ),
                ],
              )),
        ]));
  }
}