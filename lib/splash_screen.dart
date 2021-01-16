import 'dart:async';

import 'package:flutter/material.dart';

import 'weather_forecast/main_page.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MainPage())));

    return Scaffold(
      body: Container(
        child: Center(
          child: Image(
            image: AssetImage('assets/images/launch_image.png'),
            height: 300,
          ),
        ),
      ),
    );
  }
}