import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:pymt_calc/View/reverseMainView.dart';
import 'package:pymt_calc/main.dart';
import 'dart:async';
import 'package:pymt_calc/utilities/constants.dart';

class landingVieww extends StatefulWidget {
  @override
  _landingViewwState createState() => _landingViewwState();
}

class _landingViewwState extends State<landingVieww> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/landing': (BuildContext context) => landingVieww(),
        '/homee': (BuildContext context) => PYMT(),
        '/reverseMain': (BuildContext context) => reverseMainVieww(),
      },
      debugShowCheckedModeBanner: false,
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      print('done');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PYMT(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LandingWidget(context),
      ),
    );
  }
}
