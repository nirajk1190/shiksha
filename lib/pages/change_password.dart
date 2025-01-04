import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../dashboard_main.dart';
import '../util/ColorSys.dart';



class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final currentPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final cnfPasswordController = TextEditingController();
  bool? upper;
  bool? digit;
  bool? special;
  bool _obscureText = true;
  bool _obscureTextCnf = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    currentPasswordController.dispose();
    passwordController.dispose();
    cnfPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    upper = false;
    digit = false;
    special = false;
    passwordController.addListener(printLatestValue);
  }

  printLatestValue() {
    String upperPattern = r'[A-Z]';
    RegExp upperRegExp = RegExp(upperPattern);
    String digitPattern = r'[0-9]';
    RegExp digitRegExp = RegExp(digitPattern);
    String specialCharacterPattern = r'[!@#\$&*~]';
    RegExp specialCharacterRegExp = RegExp(specialCharacterPattern);

    setState(() {
      upper = upperRegExp.hasMatch(passwordController.text);
      digit = digitRegExp.hasMatch(passwordController.text);
      special = specialCharacterRegExp.hasMatch(passwordController.text);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Change Password",
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              const SizedBox(
                height: 30.0,
              ),
              Container(
                child: TextField(
                  controller: currentPasswordController,
                  readOnly: false,
                  decoration: InputDecoration(
                    labelText: 'Current Password',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    suffixIcon: IconButton(
                        icon: Icon(
                            _obscureText == true
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        }),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: ColorSys.primary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: ColorSys.primary),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  ),
                  obscureText: _obscureText,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              const SizedBox(
                height: 20.0,
              ),
              Container(
                child: TextField(
                  controller: passwordController,
                  readOnly: false,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    suffixIcon: IconButton(
                        icon: Icon(
                            _obscureText == true
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        }),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: ColorSys.primary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: ColorSys.primary),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  ),
                  obscureText: _obscureText,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              const SizedBox(
                height: 20.0,
              ),
              Container(
                child: TextField(
                  controller: cnfPasswordController,
                  readOnly: false,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    errorText: 'Password must be at least of 8 Characters',
                    suffixIcon: IconButton(
                        icon: Icon(
                            _obscureTextCnf == true
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey),
                        onPressed: () {
                          setState(() {
                            _obscureTextCnf = !_obscureTextCnf;
                          });
                        }),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: ColorSys.primary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: ColorSys.primary),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  ),
                  obscureText: _obscureTextCnf,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Your password must have',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),


              const SizedBox(
                height: 10.0,
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.check_circle,
                        color: upper == true ? Colors.green : Color(0x66777777)
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'One Uppercase',
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w500
                        // color: await upperCase(emailFieldController.text) ? Colors.lightGreen : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.check_circle,
                        color:
                        special == true ? Colors.green : Color(0x66777777)
                    ),
                    SizedBox(width: 8.0),

                    Text(
                      'One special character',
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w500
                        // color: await specialCharacter(emailFieldController.text) ? Colors.lightGreen : Colors.black ,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.check_circle,
                        color: digit == true ? Colors.green : Color(0x66777777)
                    ),
                    SizedBox(width: 8.0),

                    Text(
                      'One number',
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w500
                        // color: await oneNumber(emailFieldController.text) ? Colors.lightGreen : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),

              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardMain(),
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
                          'Save',
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
              ),

            ],
          ),
        ),
      ),
    );
  }
}
