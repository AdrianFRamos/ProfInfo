// ignore_for_file: file_names
import 'package:profinfo/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  static const routeName = "/splashScreen";
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  late Timer timer;

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timer = Timer(const Duration(seconds: 5),(){
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    });
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: <Widget>[
          const Padding(padding: EdgeInsets.only(top: 100),
          ),
          Image.asset(
            'assets/icons/logoempodera_semfundo.png', 
            fit: BoxFit.fill
          ),
          const CircularProgressIndicator(
            color: Colors.orange,
          ),
        ],
      ),
    );
  }
}