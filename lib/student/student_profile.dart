
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shiksha/dashboard_main.dart';
import 'package:shiksha/util/ColorSys.dart';
import 'package:http/http.dart' as http;

import '../constant/api_constant.dart';
import '../constant/shared_preferences_utils.dart';
import '../model/standard_model.dart';
import '../welcome_screen.dart';



class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  final int selectedIndex; // URL to profile image

  @override
  _StudentProfileScreenState createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final standardController = TextEditingController();
  final schoolNameController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pinCodeController = TextEditingController();
  final genderController = TextEditingController();

  List<StandardModel> standardList = [];
  bool standardLoading = true;
  String? standardId;
  String? _profileImageUrl;
  String? userId;
  String? accessToken;
  File? _image;
  List<String> genderList = ['Male', 'Female', 'Other'];


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchProfile();
    });
  }

  Future<void> fetchProfile() async {
    final SharedPreferencesService? prefsService =
    await SharedPreferencesService.getInstance();
    final String? token = prefsService?.getString('access_token');
    print('Access Token** $token');

    var url = Uri.parse(APIConstants.studentGetProfileUrl);

    try {
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token"
        },
      );
      final Map<String, dynamic> data = json.decode(response.body);
      var status = data['success'];
      var message = data['message'];

      if (response.statusCode == 200) {
        // Parse the response
        if (status == 1) {
          Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.white, // Customize background color if needed
            textColor: Colors.green, // Set the text color to green
            fontSize: 14.0, // Optional: customize font size
          );

          setState(() {
            nameController.text = data['data']['name'] ?? ''; // Extract the 'name' field
            _profileImageUrl = 'https://matchtree.in/${data['data']['photo'] ?? ''}';
            genderController.text = data['data']['gender'] ?? ''; // Extract the 'name' field
            mobileController.text = data['data']['phone_number'] ?? ''; // Extract the 'name' field
            addressController.text = data['data']['address'] ?? ''; // Extract the 'name' field
            cityController.text = data['data']['city'] ?? ''; // Extract the 'name' field
            stateController.text = data['data']['state'] ?? ''; // Extract the 'name' field
            pinCodeController.text = data['data']['pincode'] ?? ''; // Extract the 'name' field
            standardId = data['data']['standard_id'] ?? ''; // Extract the 'name' field

            fetchStandard().then((standard) {
              setState(() {
                standardList = standard;
                standardLoading = false;
              });
            });
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.red, // Set background color to red
            ),
          );
        }
      }
      else {
        if(message=='API token is missing or invalid. Please provide a valid token.'){
          Fluttertoast.showToast(
            msg: 'Session Expired',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.white, // Customize background color if needed
            textColor: Colors.red, // Set the text color to green
            fontSize: 14.0, // Optional: customize font size
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => WelcomeScreen(),
            ),
          );
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.red, // Set background color to red
            ),
          );
        }
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  Future<List<StandardModel>> fetchStandard() async {
    try {
      final uri = Uri.parse('http://u1z.384.mytemp.website/game/api/standards');

      final response = await http.post(uri);
      print('Response status: ${response.statusCode}'); // Debug log
      print('Response body: ${response.body}'); // Debug log
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        List<StandardModel> categories =
        data.map((json) => StandardModel.fromJson(json)).toList();

        // Find the matching standard
        StandardModel? matchingStandard;
        try {
          matchingStandard = categories.firstWhere(
                (category) => category.id.toString() == standardId,
          );
        } catch (e) {
          matchingStandard = null; // No match found
        }

        // Use setState to update the controller text
        setState(() {
          if (matchingStandard != null) {
            print('Matching Standard Name: ${matchingStandard.name}');
            standardController.text = matchingStandard.name;
          } else {
            print('No matching standard found for ID: $standardId');
            standardController.text = '';
          }
        });

        return categories; // Return list of categories
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text('Choose from Gallery',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'OpenSans')),
                onTap: () {
                  _getFromGallery(context);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text('Take a picture',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'OpenSans')),
                onTap: () {
                  _takePicture(context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  _getFromGallery(context) async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: MediaQuery.of(context)
            .size
            .width, // Adjust to the width of the container
        maxHeight: MediaQuery.of(context).size.height,
      );
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      var status = await Permission.photos.status;
      if (status.isDenied) {
        print('Access Denied');
        showAlertDialog(context);
      } else {
        print('Exception occured!');
      }
    }
  }

  showAlertDialog(context) => showCupertinoDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text('Permission Denied'),
      content: Text('Allow Access'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => openAppSettings(),
          child: Text('Settings'),
        ),
      ],
    ),
  );

  void _takePicture(BuildContext context) async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 100,
        maxHeight: 100,
      );
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      var status = await Permission.camera.status;
      if (status.isDenied) {
        print('Access Denied');
        showAlertDialog(context);
      } else {
        print('Exception occurred!');
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    genderController.dispose();
    standardController.dispose();
    schoolNameController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    pinCodeController.dispose();
    super.dispose();
  }

  Future<void> _showClassSelectionDialog() async {
    final TextEditingController searchController = TextEditingController();
    List<StandardModel> filteredGotraList = standardList;
    filteredGotraList
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    return showDialog<StandardModel>(
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
                    'Select Standard',
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
                          filteredGotraList.sort((a, b) => a.name
                              .toLowerCase()
                              .compareTo(b.name.toLowerCase()));
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
                          fontSize: 14,       // Adjust the font size if needed
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
                          return ListTile(
                            title: Text(filteredGotraList[index].name),
                            onTap: () {
                              FocusScope.of(context).unfocus();

                              Navigator.pop(
                                  context, filteredGotraList[index]);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).then((selectedService) {
      if (selectedService != null) {
        setState(() {
          FocusScope.of(context).unfocus();

          standardId = selectedService.id.toString();
          standardController.text = selectedService.name;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Make Your Profile",
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
        actions: [
          TextButton(
            onPressed: () {
              // Navigator.push(
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardMain(),
                ),
              );

            },
            child: const Text(
              "Skip",
              style: TextStyle(
                fontSize: 16,
                color: ColorSys.primary, // Customize the color to match your theme
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                          child: _image != null
                              ? Image.file(
                            _image!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                              : (_profileImageUrl != null && _profileImageUrl!.isNotEmpty
                              ? Image.network(
                            _profileImageUrl!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                              : Image.asset(
                            'assets/profile_pic.png',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )),
                        ),
                      ),
                      Positioned(
                        top: 70,
                        left: 70,
                        child: GestureDetector(
                          onTap: () {
                            _showImagePicker(context);
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

              const SizedBox(height: 30),
              Text(
                'Name',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'OpenSans',
                    color: Colors.black
                ),
              ),
              const SizedBox(height: 10),
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
                  hintText: 'Enter your Name',
                  hintStyle: TextStyle(
                    color: ColorSys.black, // Set the desired label color
                    fontSize: 14,       // Adjust the font size if needed
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Mobile Number',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'OpenSans',
                    color: Colors.black
                ),
              ),
              const SizedBox(height: 10),
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
                  hintText: 'Enter Mobile Number',
                  hintStyle: TextStyle(
                    color: ColorSys.black, // Set the desired label color
                    fontSize: 14,       // Adjust the font size if needed
                  ),
                ),
              ),
              buildGenderSelector('Gender','gender', genderController),
              const SizedBox(height: 16),
              Text(
                'Standard',
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
                child: AbsorbPointer(
                  child: TextField(
                    controller: standardController,
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
                    ),
                  ),

                ),
              ),

              const SizedBox(height: 16),
              Text(
                'Address',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'OpenSans',
                    color: Colors.black
                ),
              ),
              const SizedBox(height: 10),


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
                  hintText: 'Address',
                  hintStyle: TextStyle(
                    color: ColorSys.black, // Set the desired label color
                    fontSize: 14,       // Adjust the font size if needed
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'City',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'OpenSans',
                    color: Colors.black
                ),
              ),
              const SizedBox(height: 10),
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
                  hintText: 'Enter City Name',
                  hintStyle: TextStyle(
                    color: ColorSys.black, // Set the desired label color
                    fontSize: 14,       // Adjust the font size if needed
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'State',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'OpenSans',
                    color: Colors.black
                ),
              ),
              const SizedBox(height: 10),
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
                  hintText: 'Enter State Name',
                  hintStyle: TextStyle(
                    color: ColorSys.black, // Set the desired label color
                    fontSize: 14,       // Adjust the font size if needed
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Pincode',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'OpenSans',
                    color: Colors.black
                ),
              ),
              const SizedBox(height: 10),
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
                  labelText: 'Enter 6 digit Pincode',
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



}
