import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shiksha/welcome_screen.dart';

import 'student/student_login.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  String version = "V1.0.0";
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Initialize AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Define Animation (Scale with Curve)
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    // Start Animation
    _controller.forward();
    _checkIfLocationSaved();
  }
  Future<void> _checkIfLocationSaved() async {
    try {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  WelcomeScreen()),
        );
      });
    } catch (e) {
      print("Error checking location saved: $e");
    }
  }
  @override
  void dispose() {
    // Dispose of the animation controller
    _controller.dispose();
    super.dispose();
  }


  Widget splashScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: ScaleTransition(
            scale: _animation,
            child: Image.asset(
              "assets/logo_.jpeg",
              fit: BoxFit.contain,
              height: 150,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "V1.0.0",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(color: Colors.white),
          ),
          splashScreen(),
        ],
      ),
    );
  }


}

