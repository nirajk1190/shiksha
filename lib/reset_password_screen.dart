import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shiksha/util/ColorSys.dart';
import 'package:shiksha/welcome_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String email; // URL to profile image

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String emailError = '';
  String passwordError = '';

  @override
  void initState() {
    super.initState();
    emailController.text = widget.email;
    emailController.addListener(_clearEmailError);
    passwordController.addListener(_clearPasswordError);

  }
  void _clearEmailError() {
    // Clear name error message when name field changes
    setState(() {
      emailError = '';
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Reset Password",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontFamily: 'OpenSans',
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
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
              const SizedBox(height: 50),
              buildEmailFieldWithTitle('Email', 'email', emailController),
              if (emailError.isNotEmpty)
                Text(
                  emailError,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 24),
              buildNameFieldWithTitle(
                  'New Password', "password", passwordController),
              // Add some space between text field and error message
              if (passwordError.isNotEmpty)
                Text(
                  passwordError,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WelcomeScreen(),
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
                        'Submit',
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

            ],
          ),
        ),
      ),
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
            style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400),
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
              labelText: 'New Password',
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



}
