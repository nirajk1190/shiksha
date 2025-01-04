
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shiksha/reset_password_screen.dart';
import 'package:shiksha/util/ColorSys.dart';

class ForgotPasswordScreen extends StatefulWidget {

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  String emailError = '';

  @override
  void initState() {
    super.initState();
    emailController.addListener(_clearEmailError);

  }
  void _clearEmailError() {
    // Clear name error message when name field changes
    setState(() {
      emailError = '';
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  bool _validateEmail(String value) {
    // Check if the value is empty
    if (value.isEmpty) {
      return false;
    }
    // Check if the value matches the email format
    if (!RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return false;
    }
    return true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Forgot Password",
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
              Center(
                child: Text(
                  "Enter Email Address",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ),

              const SizedBox(height: 50),
              buildEmailFieldWithTitle('Email', 'email', emailController),
              if (emailError.isNotEmpty)
                Text(
                  emailError,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResetPasswordScreen(email: emailController.text),
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
                        'Next',
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
