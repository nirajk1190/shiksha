import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shiksha/choose_screen.dart';
import 'package:shiksha/forgot_password_screen.dart';
import 'package:shiksha/register.dart';
import 'package:shiksha/util/ColorSys.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String mobileError = '';
  String passwordError = '';

  @override
  void initState() {
    super.initState();

    emailController.addListener(_clearEmailError);
    passwordController.addListener(_clearPasswordError);
  }

  void _clearEmailError() {
    // Clear name error message when name field changes
    setState(() {
      mobileError = '';
    });
  }

  void _clearPasswordError() {
    // Clear mobile error message when mobile field changes
    setState(() {
      passwordError = '';
    });
  }

  @override
  void dispose() {
    // Dispose the controller to avoid memory leaks
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorSys.primary,
        title: const Text(
          "Login",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 16),

              Center(
                child: Image.asset(
                  'assets/logo_.jpeg', // Add your Google logo here
                  width: 100,
                  height: 100,
                ),
              ),
              const SizedBox(height: 30),

              buildEmailFieldWithTitle('Email', 'email', emailController),
              if (mobileError.isNotEmpty)
                Text(
                  mobileError,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 16),
              buildNameFieldWithTitle(
                  'Password', "password", passwordController),
              // Add some space between text field and error message
              if (passwordError.isNotEmpty)
                Text(
                  passwordError,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgotPasswordScreen(),
                    ),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(18.0),
                      child: RichText(
                        textScaler: MediaQuery.of(context).textScaler,
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Forget Password?',
                            style: TextStyle(
                                color: ColorSys.primary,
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Roboto-Bold'),
                          )
                        ]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChooseScreen(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF3854BD), Color(0xFFA365DB)], // Replace with your gradient colors
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto-Bold',
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  HapticFeedback.lightImpact();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(18.0),
                      child: RichText(
                        textScaler: MediaQuery.of(context).textScaler,
                        text: TextSpan(children: [
                          const TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                                color: Colors.black,
                                letterSpacing: 0.0,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Roboto-Regular'),
                          ),
                          TextSpan(
                            text: 'Register',
                            style: TextStyle(
                                color: ColorSys.primary,
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto-Bold'),
                          )
                        ]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEmailFieldWithTitle(
      String title,
      String head,
      TextEditingController controller,
      ) {
    String iconPath;

    // Assign different icons based on the field title
    switch (head.toLowerCase()) {
      case 'email':
        iconPath = 'assets/email.png';
        break;
      default:
        iconPath = 'assets/email.png';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        SizedBox(
          height: 45,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            // Set keyboard type to phone
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              counterText: '',
              contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: ColorSys.primary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: ColorSys.edit_box),
              ),
              labelText: 'Email',
              labelStyle: TextStyle(
                color: ColorSys.black, // Set the desired label color
                fontSize: 14,       // Adjust the font size if needed
              ),
              prefixIcon: Image.asset(
                iconPath,
                color: ColorSys.primary,
                width: 10,
                height: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }


  Widget buildNameFieldWithTitle(
    String title,
    String head,
    TextEditingController controller,
  ) {
    String iconPath;

    // Assign different icons based on the field title
    switch (head.toLowerCase()) {
      case 'password':
        iconPath = 'assets/password.png';
        break;
      default:
        iconPath = 'assets/password.png';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        SizedBox(
          height: 45,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.text,
            // Set keyboard type to phone
            style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: ColorSys.primary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: ColorSys.edit_box),
              ),
              labelText: 'Password',
              labelStyle: TextStyle(
                color: ColorSys.black, // Set the desired label color
                fontSize: 14,       // Adjust the font size if needed
              ),
              prefixIcon: Image.asset(
                iconPath,
                color: ColorSys.primary,
                width: 10,
                height: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool _validateName(String value) {
    // Check if the value is empty or contains only whitespace
    if (value.trim().isEmpty) {
      return false;
    }
    return true;
  }

  bool _validatePassword(String value) {
    // Check if the value is empty or contains only whitespace
    if (value.trim().isEmpty) {
      return false;
    }
    return true;
  }

  bool _validateMobile(String value) {
    // Check if the value is empty or does not contain exactly 10 digits
    if (value.isEmpty || value.length != 10) {
      return false;
    }
    // Check if the value contains only digits
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return false;
    }
    return true;
  }
}
