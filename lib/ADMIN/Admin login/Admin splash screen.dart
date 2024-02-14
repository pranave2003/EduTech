import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'Admin login.dart';
import 'app stayles.dart';

class Adminsplashscreen extends StatefulWidget {
  const Adminsplashscreen({super.key});

  @override
  State<Adminsplashscreen> createState() => _AdminsplashscreenState();
}

class _AdminsplashscreenState extends State<Adminsplashscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        duration: 1000,
        splash: Text(
          // 'AdminExpress',
          'EduPort',
          style: ralewayStyle.copyWith(
            fontSize: 49.0,
            color: Colors.purple[100],
            fontWeight: FontWeight.w900,
          ),
        ),
        nextScreen: Adminlogin(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.purple,
      ),
    );
  }
}
