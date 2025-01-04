
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shiksha/dashboard_main.dart';
import 'package:shiksha/util/ColorSys.dart';


class FillDetails extends StatefulWidget {
  const FillDetails({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  final int selectedIndex; // URL to profile image

  @override
  _FillDetailsState createState() => _FillDetailsState();
}

class _FillDetailsState extends State<FillDetails> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();



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
