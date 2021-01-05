import 'package:flutter/material.dart';
import 'dart:async';




class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context).pushNamed('/homepage'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          
          image: DecorationImage(
              image: AssetImage('assets/splash.png'), fit: BoxFit.cover),
        ),
       
      ),
    );
  }
}
