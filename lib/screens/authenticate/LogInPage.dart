import 'package:findagig/screens/authenticate/RecoverPage.dart';
import 'package:findagig/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:findagig/services/auth.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String mail = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 100.0, 0.0, 0.0),
                  child: Text(
                      'Hello',
                      style: TextStyle(
                          fontSize: 80.0, fontWeight: FontWeight.bold)
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16.0, 165.0, 0.0, 0.0),
                  child: Text(
                      'There',
                      style: TextStyle(
                          fontSize: 80.0, fontWeight: FontWeight.bold)
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(220.0, 165.0, 0.0, 0.0),
                  child: Text(
                      '.',
                      style: TextStyle(
                          fontSize: 80.0, fontWeight: FontWeight.bold, color: Colors.yellow)
                  ),
                )
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(top:15, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Email',
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
                      setState(() => mail = val);
                    },
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow)
                      ),
                    ),
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                    obscureText: true,
                  ),
                  //SizedBox(height: 10.0,),
                  Container(
                    alignment: Alignment(1.0, 0.0),
                    padding: EdgeInsets.only(top:15.0, left:20.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RecoverPwPage()),
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            decoration: TextDecoration.underline
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25.0,),
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

                          dynamic result = await _auth.signInWithMail(mail, password);

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
                            'LOGIN',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat'
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Container(
                    height: 40.0,
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
                            child: InkWell(
                              onTap: () {
                                widget.toggleView();
                              },
                              child: Text('Register',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat'
                                  )
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
          ),
          SizedBox(height: 5.0),
        ],
      )
    );
  }
}