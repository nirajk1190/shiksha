import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shiksha/pages/membership_screen.dart';
import 'package:shiksha/pages/progress_report.dart';
import 'package:shiksha/util/ColorSys.dart';
import 'package:shiksha/welcome_screen.dart';

import '../util/my_profile.dart';
import 'change_password.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, // No back button
        backgroundColor: Colors.white, // Set background color
        elevation: 0, // Remove shadow
        title: Text(
          'Account', // Replace with your desired title
          style: TextStyle(
            color: Colors.black, // Title color
            fontSize: 20, // Adjust font size
            fontWeight: FontWeight.w600, // Optional: Make the title bold
          ),
        ),
        titleSpacing: 20.0, // Add spacing to align the title closer to the left
      ),

      body:SingleChildScrollView(
        child:       _buildTabContent(),

      )
    );
  }

  // Method to build content for the "Profile" tab
  Widget _buildTabContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align heading to the left
        children: [
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
          SizedBox(height: 50.0),
          InkWell(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        height: 32,
                        child:SvgPicture.asset(
                          'assets/user.svg',// Use the SVG asset path here
                          width: 32.0, // Adjust size as necessary
                          height: 32.0, //
                          alignment: Alignment.center,// Adjust size as necessary
                          placeholderBuilder: (context) => const CircularProgressIndicator(),
                        ),

                      ),
                      Text(
                        'My Profile',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 24, // Set arrow size
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyProfileScreen(selectedIndex: 1,)), // Replace LoginScreen with your login screen class
              );
            },
          ),
          const Divider(
            height: 10,
            color: Colors.grey,
            indent: 50,
            endIndent: 15,
          ),
          SizedBox(height: 8.0),

          InkWell(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        height: 32,
                        child:SvgPicture.asset(
                          'assets/membership.svg',// Use the SVG asset path here
                          width: 32.0, // Adjust size as necessary
                          height: 32.0, //
                          alignment: Alignment.center,// Adjust size as necessary
                          placeholderBuilder: (context) => const CircularProgressIndicator(),
                        ),
                      ),
                      Text(
                        'Membership',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 24, // Set arrow size
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MembershipScreen()), // Replace LoginScreen with your login screen class
              );
            },
          ),
          const Divider(
            height: 10,
            color: Colors.grey,
            indent: 50,
            endIndent: 15,
          ),
          SizedBox(height: 8.0),

          InkWell(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        height: 32,
                        child:SvgPicture.asset(
                          'assets/password.svg',// Use the SVG asset path here
                          width: 32.0, // Adjust size as necessary
                          height: 32.0, //
                          alignment: Alignment.center,// Adjust size as necessary
                          placeholderBuilder: (context) => const CircularProgressIndicator(),
                        ),
                      ),
                      const Text(
                        'Change Password',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 24, // Set arrow size
                  ),
                ],
              ),
            ),
            onTap: () {
              // Debugging step: Add a print statement to confirm tap registration.
              print("Change Password tapped!");

              // Navigate to ChangePassword screen.
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePassword()), // Add the target screen here.
              );
            },
          ),
          const Divider(
            height: 10,
            color: Colors.grey,
            indent: 50,
            endIndent: 15,
          ),
          SizedBox(height: 8.0),

          InkWell(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        height: 32,
                        child:SvgPicture.asset(
                          'assets/progress.svg',// Use the SVG asset path here
                          width: 32.0, // Adjust size as necessary
                          height: 32.0, //
                          alignment: Alignment.center,// Adjust size as necessary
                          placeholderBuilder: (context) => const CircularProgressIndicator(),
                        ),
                      ),
                      const Text(
                        'Progress Report',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 24, // Set arrow size
                  ),
                ],
              ),
            ),
            onTap: () {
              // Navigate to ChangePassword screen.
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProgressReportScreen()), // Add the target screen here.
              );
            },
          ),
          const Divider(
            height: 10,
            color: Colors.grey,
            indent: 50,
            endIndent: 15,
          ),
          SizedBox(height: 8.0),


          InkWell(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        height: 32,
                        child:SvgPicture.asset(
                          'assets/delete_account.svg',// Use the SVG asset path here
                          width: 32.0, // Adjust size as necessary
                          height: 32.0, //
                          alignment: Alignment.center,// Adjust size as necessary
                          placeholderBuilder: (context) => const CircularProgressIndicator(),
                        ),
                      ),
                      Text(
                        "Close Account",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 24, // Set arrow size
                  ),
                ],
              ),
            ),
            onTap: () {
              _showDeleteAccountDialog(context);
            },
          ),
          const Divider(
            height: 10,
            color: Colors.grey,
            indent: 50,
            endIndent: 15,
          ),
          SizedBox(height: 8.0),

          InkWell(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        height: 32,
                        child:SvgPicture.asset(
                          'assets/logout.svg',// Use the SVG asset path here
                          width: 32.0, // Adjust size as necessary
                          height: 32.0, //
                          alignment: Alignment.center,// Adjust size as necessary
                          placeholderBuilder: (context) => const CircularProgressIndicator(),
                        ),
                      ),
                      Text(
                        "Log Out",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 24, // Set arrow size
                  ),
                ],
              ),
            ),
            onTap: () {
              _showLogoutDialog(context);
            },
          ),
          SizedBox(height: 50,),
          Center(
            child: Text(
              "Shiksha V1.0.1",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.w500,
                color: ColorSys.black,
              ),
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  // App tab content
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Confirmation',style: TextStyle(fontSize: 16, fontFamily: 'OpenSans', color: ColorSys.primary,fontWeight: FontWeight.bold)),
          content: Text('Are you sure you want to log out?',style: TextStyle(fontSize: 14, fontFamily: 'OpenSans', fontWeight: FontWeight.normal)),
          actions: <Widget>[
            // Cancel button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel',style: TextStyle(fontSize: 14, fontFamily: 'OpenSans', color: Colors.black,fontWeight: FontWeight.bold)),
            ),
            // Confirm button (Log Out)
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();

                // Optionally, navigate to the login screen after logging out
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()), // Replace with your login screen
                );
              },
              child: Text('Log Out',style: TextStyle(fontSize: 14, fontFamily: 'OpenSans',color: ColorSys.primary, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }
  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Confirmation',style: TextStyle(fontSize: 16, fontFamily: 'OpenSans', color: ColorSys.primary,fontWeight: FontWeight.bold)),
          content: Text('Are you sure you want to close your account?',style: TextStyle(fontSize: 14, fontFamily: 'OpenSans', fontWeight: FontWeight.normal)),
          actions: <Widget>[
            // Cancel button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel',style: TextStyle(fontSize: 14, fontFamily: 'OpenSans', color: Colors.black,fontWeight: FontWeight.bold)),
            ),
            // Confirm button (Log Out)
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Confirm',style: TextStyle(fontSize: 14, fontFamily: 'OpenSans',color: ColorSys.primary, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }





}
