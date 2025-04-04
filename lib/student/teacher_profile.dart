
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shiksha/dashboard_main.dart';
import 'package:shiksha/util/ColorSys.dart';
import 'package:http/http.dart' as http;

import '../model/standard_model.dart';



class TeacherProfileScreen extends StatefulWidget {
  const TeacherProfileScreen({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  final int selectedIndex; // URL to profile image

  @override
  _TeacherProfileScreenState createState() => _TeacherProfileScreenState();
}

class _TeacherProfileScreenState extends State<TeacherProfileScreen> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final standardController = TextEditingController();
  final schoolNameController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pinCodeController = TextEditingController();

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
    // Add listeners to the text field controllers
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

  @override
  void dispose() {
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
              const SizedBox(height: 16),
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
                'School Name',
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
                  hintText: 'Enter School Name',
                  hintStyle: TextStyle(
                    color: ColorSys.black, // Set the desired label color
                    fontSize: 14,       // Adjust the font size if needed
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





}
