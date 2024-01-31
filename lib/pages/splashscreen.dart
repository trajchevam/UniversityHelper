import 'dart:async';

import 'package:flutter/material.dart';
import 'package:university_helper/pages/exams_page.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () => Navigator.push(context,
        MaterialPageRoute(builder:
            (context) => ExamsPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      child: Center(
        child: Text("University Helper", style: TextStyle(
            color: Colors.orange,
            fontSize: 36.0,
            fontWeight: FontWeight.w700,
            fontFamily: "Roboto",
            decoration: TextDecoration.none),),
      ),
    );
  }
}
