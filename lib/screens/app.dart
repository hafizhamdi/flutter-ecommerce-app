import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/blocs/product_bloc.dart';
import 'package:flutter_ecommerce_app/constants/constant.dart';
import 'package:flutter_ecommerce_app/screens/splash.dart';
import 'package:provider/provider.dart';
import '../widgets/widget.dart';
import 'home.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> with TickerProviderStateMixin {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
        ),
        initialRoute: '/splash',
        routes: {
          '/': (context) => HomeScreen(),
          '/splash': (context) => SplashScreen()
        });
  }
}
