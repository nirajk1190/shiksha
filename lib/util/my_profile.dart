
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shiksha/dashboard_main.dart';
import 'package:shiksha/util/ColorSys.dart';


class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  final int selectedIndex; // URL to profile image

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {

  File? _image;



  @override
  void initState() {
    super.initState();
    // Add listeners to the text field controllers
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "My Profile",
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
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/profile_pic.png',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )),
                      ),
                      Positioned(
                        top: 70,
                        left: 70,
                        child: GestureDetector(
                          onTap: () {
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20,
                            child: Icon(
                              Icons.camera_alt,
                              color: ColorSys.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 16),

              TextField(
                keyboardType: TextInputType.text,
                // Set keyboard type to phone
                style: const TextStyle(fontSize: 14),
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
                  labelText: 'Name',
                  labelStyle: TextStyle(
                    color: ColorSys.black, // Set the desired label color
                    fontSize: 14,       // Adjust the font size if needed
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.number,
                // Set keyboard type to phone
                style: const TextStyle(fontSize: 14),
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
                  labelText: 'Mobile Number',
                  labelStyle: TextStyle(
                    color: ColorSys.black, // Set the desired label color
                    fontSize: 14,       // Adjust the font size if needed
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (widget.selectedIndex == 1 || widget.selectedIndex == 2) ...[
                TextField(
                  keyboardType: TextInputType.text,
                  // Set keyboard type to phone
                  style: const TextStyle(fontSize: 14),
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
                    labelText: 'School Name',
                    labelStyle: TextStyle(
                      color: ColorSys.black, // Set the desired label color
                      fontSize: 14,       // Adjust the font size if needed
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              // Add some space between text field and error message
              TextField(
                keyboardType: TextInputType.text,
                // Set keyboard type to phone
                style: const TextStyle(fontSize: 14),
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
                  labelText: 'Address',
                  labelStyle: TextStyle(
                    color: ColorSys.black, // Set the desired label color
                    fontSize: 14,       // Adjust the font size if needed
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.text,
                // Set keyboard type to phone
                style: const TextStyle(fontSize: 14),
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
                  labelText: 'City',
                  labelStyle: TextStyle(
                    color: ColorSys.black, // Set the desired label color
                    fontSize: 14,       // Adjust the font size if needed
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.text,
                // Set keyboard type to phone
                style: const TextStyle(fontSize: 14),
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
                  labelText: 'State',
                  labelStyle: TextStyle(
                    color: ColorSys.black, // Set the desired label color
                    fontSize: 14,       // Adjust the font size if needed
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.number,
                // Set keyboard type to phone
                style: const TextStyle(fontSize: 14),
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
                  labelText: 'Pincode',
                  labelStyle: TextStyle(
                    color: ColorSys.black, // Set the desired label color
                    fontSize: 14,       // Adjust the font size if needed
                  ),
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(6), // Maximum of 6 characters
                  FilteringTextInputFormatter.digitsOnly, // Allow only numeric input
                ],
              ),
              const SizedBox(height: 50),
              GestureDetector(
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
                        'Update',
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





}
