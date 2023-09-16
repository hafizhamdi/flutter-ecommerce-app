import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/constants/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {

  @override
  void initState() {
    Timer(const Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(context, '/'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: kPrimaryColor,
            width: double.infinity,
            height: double.infinity,
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  const SizedBox(height: 200),
                  Image.asset(
                    'assets/icons/shopping.png',
                    width: 200,
                  ),
                  const Text(
                    "Shopping as you like",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                ])));
  }
}
