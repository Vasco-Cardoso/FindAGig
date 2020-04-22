import 'package:findagig/models/user.dart';
import 'package:flutter/material.dart';
import 'package:findagig/screens/authenticate/authenticate.dart';
import 'package:findagig/screens/home/HomeMenu.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget  build(BuildContext context) {
    final user = Provider.of<User>(context);

    if(user == null)
    {
      return Authenticate();
    }
    else
    {
      return MyApp();
    }
  }
}