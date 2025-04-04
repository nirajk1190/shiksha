
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shiksha/model/standard_model.dart';
import 'package:shiksha/util/ColorSys.dart';
import 'package:http/http.dart' as http;

import '../constant/api_constant.dart';


class TeacherSignup extends StatefulWidget {
  const TeacherSignup({super.key});

  @override
  _TeacherSignupState createState() => _TeacherSignupState();
}

class _TeacherSignupState extends State<TeacherSignup> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final classController = TextEditingController();
  final mobileController = TextEditingController();
  final genderController = TextEditingController();

  String nameError = '';
  String passwordError = '';
  String emailError = '';
  String classError = '';
  String mobileError = '';
  String genderError = '';

  List<String> genderList = ['Male', 'Female', 'Other'];
  List<StandardModel> standardList = [];
  bool standardLoading = true;
  String? standardId;

  @override
  void initState() {
    super.initState();
    fetchStandard().then((standard) {
      setState(() {
        standardList = standard;
        standardLoading = false;
      });
    });
    nameController.addListener(_clearNameError);
    emailController.addListener(_clearEmailError);
    passwordController.addListener(_clearPasswordError);
    mobileController.addListener(_clearMobileError);
    classController.addListener(_clearClassError);
    genderController.addListener(clearGender);
  }

  Future<List<StandardModel>> fetchStandard() async {
    try {
      final uri =
      Uri.parse('http://u1z.384.mytemp.website/game/api/standards');

      final response = await http.post(
        uri
      );
      print('Response status: ${response.statusCode}'); // Debug log
      print('Response body: ${response.body}'); // Debug log
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        List<StandardModel> categories =
        data.map((json) => StandardModel.fromJson(json)).toList();

        return categories; // Return list of categories
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  void clearGender() {
    setState(() {
      genderError = '';
    });
  }

  void _clearClassError() {
    // Clear name error message when name field changes
    setState(() {
      classError = '';
    });
  }
  void _clearNameError() {
    // Clear name error message when name field changes
    setState(() {
      nameError = '';
    });
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
  void _clearMobileError() {
    // Clear name error message when name field changes
    setState(() {
      mobileError = '';
    });
  }
  Future<void> _showGenderDialog(BuildContext context) async {
    final String? selectedGender = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Select Gender',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto-Regular',
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
              ),
            ],
          ),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: genderList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(genderList[index]),
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    Navigator.pop(context, genderList[index]);
                  },
                );
              },
            ),
          ),
        );
      },
    );

    if (selectedGender != null) {
      setState(() {
        FocusScope.of(context).unfocus();
        genderController.text = selectedGender;
      });
    }
  }

  @override
  void dispose() {
    // Dispose the controller to avoid memory leaks
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    mobileController.dispose();
    classController.dispose();
    genderController.dispose();
    super.dispose();
  }

  void _validateInputs() {
    if (!validate(nameController.text)) {
      setState(() {
        nameError = 'Please enter Name';
      });
      return;
    }

    if (!validate(emailController.text)) {
      setState(() {
        emailError = 'Please enter Email';
      });
      return;
    }
    if (!validateEmail(emailController.text)) {
      setState(() {
        emailError = 'Please enter a valid Email';
      });
      return;
    }

    if (!_validatePassword(passwordController.text)) {
      setState(() {
        passwordError = 'Please enter a valid Password';
      });
      return;
    }
    if (!_validateMobile(mobileController.text)) {
      setState(() {
        mobileError = 'Please enter a Mobile Number';
      });
      return;
    }
    if (!_validateMobile(mobileController.text)) {
      setState(() {
        mobileError = 'Please enter a 10 digit Mobile Number';
      });
      return;
    }
    if (!validate(genderController.text)) {
      setState(() {
        genderError = 'Please select Gender';
      });
      return;
    }
    if (!validate(classController.text)) {
      setState(() {
        classError = 'Please select class';
      });
      return;
    }



    setState(() {
      emailError = '';
      nameError = '';
      passwordError = '';
      mobileError = '';
      classError = '';
      genderError = '';

    });

    sendPostRequest(context);
  }
  bool _validatePassword(String value) {
    // Check if the value is empty or contains only whitespace
    if (value.trim().isEmpty) {
      return false;
    }
    return true;
  }

  bool validateEmail(String email) {
    String pattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  Future<void> sendPostRequest(BuildContext context) async {
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


      var uri = Uri.parse(APIConstants.studentRegisterUrl);
      var request = http.MultipartRequest('POST', uri);
      request.fields['name'] = nameController.text;
      request.fields['email'] = emailController.text;
      request.fields['phone_number'] = mobileController.text;
      request.fields['password'] = passwordController.text;
      request.fields['gender'] = genderController.text;
      request.fields['plan'] = '1';
      request.fields['standard[]'] = standardId ?? '';


      // Send the request
      var response = await request.send();
      final responseData = await response.stream.bytesToString();
      print('API Response: $responseData');
      var decodedData = jsonDecode(responseData);

      var success = decodedData['success'];
      var message = decodedData['message'];
      Navigator.pop(context);

      if (response.statusCode == 200) {
        if(success==1){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.green, // Set background color to red
            ),
          );
          Navigator.pop(context);
        }else{
          var errorMessages = decodedData['error_msg']; // Handle error_msg
// Check if error_msg is a list
          if (errorMessages is List) {
            // Join all error messages with a newline for display
            message = errorMessages.join('\n');
          } else {
            // Fallback if error_msg is not a list
            message = errorMessages.toString();
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.red, // Set background color to red
            ),
          );
        }


      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red, // Set background color to red
          ),
        );
        // showToast(message);
      }
    } catch (e) {
      Navigator.pop(context);

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
            crossAxisAlignment: CrossAxisAlignment.center,
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
                              'Register',
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

                      const SizedBox(height: 20),

                      buildNameFieldWithTitle('Name', 'name', nameController),
                      if (nameError.isNotEmpty)
                        Text(
                          nameError,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 16),
                      buildEmailFieldWithTitle(
                          'Email', "email", emailController),
                      // Add some space between text field and error message
                      if (emailError.isNotEmpty)
                        Text(
                          emailError,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 16),
                      buildPasswordFieldWithTitle(
                          'Password', "password", passwordController),
                      const SizedBox(height: 8),
                      // Add some space between text field and error message
                      if (passwordError.isNotEmpty)
                        Text(
                          passwordError,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 16),
                      buildMobileFieldWithTitle(
                          'Mobile Number', "mobile", mobileController),
                      // Add some space between text field and error message
                      if (mobileError.isNotEmpty)
                        Text(
                          mobileError,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 16),
                      buildGenderSelector('Gender','gender', genderController),
                      if (genderError.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            genderError,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      const SizedBox(height: 16),
                      buildClassFieldWithTitle(
                          'Standard', "class", classController),
                      // Add some space between text field and error message
                      if (classError.isNotEmpty)
                        Text(
                          classError,
                          style: const TextStyle(color: Colors.red),
                        ),



                      const SizedBox(height: 50),
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
                                'Register',
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>DirectLoginScreen()),
                          // );
                          Navigator.pop(context);
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
                                    text: "Already have an account? ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 0.0,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Roboto-Regular'),
                                  ),
                                  TextSpan(
                                    text: 'Login',
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
  Widget buildGenderSelector(
      String title,
      String head,
      TextEditingController controller,
      ) {

    String iconPath;

    // Assign different icons based on the field title
    switch (head.toLowerCase()) {
      case 'gender':
        iconPath = 'assets/genders.png';
        break;
      default:
        iconPath = 'assets/genders.png';
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: (){
            _showGenderDialog(context);
          },
          child: SizedBox(
              height: 45,
              child:AbsorbPointer(
                child: TextField(
                  controller: controller,
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
                    hintText: 'Select Gender',
                    hintStyle: TextStyle(
                      color: ColorSys.black, // Set the desired label color
                      fontSize: 14,       // Adjust the font size if needed
                    ),
                    suffixIcon: Icon(
                      Icons.arrow_drop_down, // Down arrow icon
                      color: ColorSys.primary, // Icon color
                    ),
                    prefixIcon: Image.asset(
                      iconPath,
                      color: ColorSys.primary,
                      width: 10,
                      height: 10,
                    ),
                  ),
                ),

              )
          ),

        )
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
              hintText: 'Enter Email',
              hintStyle: TextStyle(
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
  Future<void> _showClassSelectionDialog() async {
    final TextEditingController searchController = TextEditingController();
    List<StandardModel> filteredGotraList = standardList;
    filteredGotraList.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    // To track selected items
    Map<int, bool> selectedClasses = {};

    final List<StandardModel>? selectedItems = await showDialog<List<StandardModel>>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Select Standards',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto-Regular',
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                  ),
                ],
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          filteredGotraList = standardList.where((state) {
                            return state.name
                                .toLowerCase()
                                .contains(value.toLowerCase());
                          }).toList();
                          filteredGotraList.sort((a, b) =>
                              a.name.toLowerCase().compareTo(b.name.toLowerCase()));
                        });
                      },
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
                        labelText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintStyle: TextStyle(
                          color: ColorSys.black, // Set the desired label color
                          fontSize: 14, // Adjust the font size if needed
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    standardLoading
                        ? CircularProgressIndicator()
                        : Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredGotraList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = filteredGotraList[index];
                          return CheckboxListTile(
                            title: Text(item.name),
                            value: selectedClasses[item.id] ?? false,
                            onChanged: (bool? value) {
                              setState(() {
                                selectedClasses[item.id] = value ?? false;
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    // Collect selected items and return them
                    final selectedItems = filteredGotraList
                        .where((item) => selectedClasses[item.id] ?? false)
                        .toList();

                    Navigator.pop(context, selectedItems);
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(color: ColorSys.primary),
                  ),
                ),
              ],
            );
          },
        );
      },
    );

    // Handle the selected items
    if (selectedItems != null && selectedItems.isNotEmpty) {
      setState(() {
        classController.text = selectedItems.map((e) => e.name).join(', ');
        standardId = selectedItems.map((e) => e.id.toString()).join(', ');
      });
    }
  }



  Widget buildClassFieldWithTitle(
      String title,
      String head,
      TextEditingController controller,
      ) {
    String iconPath;

    // Assign different icons based on the field title
    switch (head.toLowerCase()) {
      case 'class':
        iconPath = 'assets/class.png';
        break;
      default:
        iconPath = 'assets/class.png';
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
        GestureDetector(
          onTap: (){
            _showClassSelectionDialog();
          },
          child: SizedBox(
              height: 45,
              child:AbsorbPointer(
                child: TextField(
                  controller: controller,
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
                    hintText: 'Select Class',
                    hintStyle: TextStyle(
                      color: ColorSys.black, // Set the desired label color
                      fontSize: 14,       // Adjust the font size if needed
                    ),
                    suffixIcon: Icon(
                      Icons.arrow_drop_down, // Down arrow icon
                      color: ColorSys.primary, // Icon color
                    ),
                    prefixIcon: Image.asset(
                      iconPath,
                      color: ColorSys.primary,
                      width: 10,
                      height: 10,
                    ),
                  ),
                ),

              )
          ),
        )
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
      case 'name':
        iconPath = 'assets/user.png';
        break;
      case 'email':
        iconPath = 'assets/email.png';
        break;
      case 'password':
        iconPath = 'assets/password.png';
        break;
      default:
        iconPath = 'assets/user.png';
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
              hintText: 'Enter Name',
              hintStyle: TextStyle(
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

  Widget buildMobileFieldWithTitle(
    String title,
    String head,
    TextEditingController controller,
  ) {
    String iconPath;

    // Assign different icons based on the field title
    switch (head.toLowerCase()) {
      case 'mobile':
        iconPath = 'assets/mobile.png';
        break;
      default:
        iconPath = 'assets/mobile.png';
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
              hintText: 'Enter 10 digit Mobile Number',
              hintStyle: TextStyle(
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

  Widget buildPasswordFieldWithTitle(
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
            obscureText: true,
            controller: controller,
            keyboardType: TextInputType.text,
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
              hintText: 'Enter Password',
              hintStyle: TextStyle(
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
        SizedBox(height: 8),
        const Text(
          'Password should be at least 6 characters',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
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

  bool validate(String value) {
    // Check if the value is empty or contains only whitespace
    if (value.trim().isEmpty) {
      return false;
    }
    return true;
  }
}
