import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shiksha/forgot_password_screen.dart';
import 'package:shiksha/student/student_profile.dart';
import 'package:shiksha/student/student_signup.dart';
import 'package:shiksha/util/ColorSys.dart';

import '../constant/api_constant.dart';
import '../constant/shared_preferences_utils.dart';


class StudentLoginScreen extends StatefulWidget {
  const StudentLoginScreen({super.key});

  @override
  _StudentLoginScreenState createState() => _StudentLoginScreenState();
}

class _StudentLoginScreenState extends State<StudentLoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String emailError = '';
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
    // Dispose the controller to avoid memory leaks
    emailController.dispose();
    passwordController.dispose();
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
  void _validateInputs() {
    // Validate name input
    if (!_validateEmail(emailController.text)) {
      setState(() {
        emailError = 'Please enter a Valid Email';
      });
      return;
    }


    if (!_validatePassword(passwordController.text)) {
      setState(() {
        passwordError = 'Please enter a valid Password';
      });
      return;
    }

    // Clear error message if both fields are valid
    setState(() {
      emailError = '';
      passwordError = '';
    });

    // Call the API function if both inputs are valid
    sendLoginRequest(context);
  }

  Future<void> sendLoginRequest(BuildContext context) async {
    try {

      showDialog(
        context: context,
        barrierDismissible: false, // Prevent dialog from closing on outside tap
        builder: (BuildContext context) {
          return const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                // Show circular progress indicator
                SizedBox(height: 16),
                Text('Please wait...'),
                // Show "Please wait..." message
              ],
            ),
          );
        },
      );

      var uri = Uri.parse(APIConstants.loginUrl);
      var request = http.MultipartRequest('POST', uri);
      request.fields['email'] = emailController.text;
      request.fields['password'] = passwordController.text;
      request.fields['login_type'] = 'student';

      // Send the request
      var response = await request.send();
      final responseData = await response.stream.bytesToString();
      print('API Response: $responseData');
      var decodedData = jsonDecode(responseData);
      print('Login Response: $decodedData');
      Navigator.pop(context);

      if (response.statusCode == 200) {
        var message = decodedData['message'];
        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white, // Customize background color if needed
          textColor: Colors.green, // Set the text color to green
          fontSize: 14.0, // Optional: customize font size
        );
        await SharedPreferencesService.getInstance().then((instance) {
          instance?.saveLoginData(decodedData);
        });

        // Navigate to NameInputScreen with name and email
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const StudentProfileScreen(selectedIndex: 0),
          ),
        );

      } else {
        var message = decodedData['msg'];
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error'),
              content:
              Text(message),
              actions: [
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            barrierDismissible: true);
        // showToast(message);
      }
    } catch (e) {

      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$e'),
            backgroundColor: Colors.red, // Set background color to red
          ),
        );
        // showToast('$e');
        if (kDebugMode) {
          print("Error: $e");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Vertically centers the content
            crossAxisAlignment: CrossAxisAlignment.center, // Horizontally centers content
            children: <Widget>[
              Stack(
                clipBehavior: Clip.none,
                children: [
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF3854BD), Color(0xFFA365DB)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 38, left: 18, right: 18),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios_new,color: Colors.white),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start, // Vertically centers the content
                    crossAxisAlignment: CrossAxisAlignment.start, // Horizontally centers content
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/logo_.jpeg', // Add your Google logo here
                          width: 100,
                          height: 100,
                        ),
                      ),
                      const SizedBox(height: 30),

                      buildEmailFieldWithTitle('Email', 'email', emailController),
                      if (emailError.isNotEmpty)
                        Text(
                          emailError,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 16),
                      buildNameFieldWithTitle(
                          'Password', "password", passwordController),
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
                          _validateInputs();
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
                            MaterialPageRoute(builder: (context) => StudentSignup()),
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
              )


            ],
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
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
              fontFamily: 'OpenSans',
              color: Colors.black
          ),
        ),
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
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
              hintText: 'Enter email',
              hintStyle: TextStyle(
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
        Text(
          title,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'OpenSans',
              color: Colors.black
          ),
        ),
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
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
              hintText: 'Enter password',
              hintStyle: TextStyle(
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
