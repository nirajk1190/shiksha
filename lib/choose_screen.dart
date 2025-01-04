
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shiksha/fill_details.dart';
import 'package:shiksha/util/ColorSys.dart';
import 'package:shiksha/welcome_screen.dart';

class ChooseScreen extends StatefulWidget {

  @override
  _ChooseScreenState createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
  int _selectedIndex = -1;
  final classController = TextEditingController();

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    // Dispose the controller to avoid memory leaks
    classController.dispose();
    super.dispose();
  }

  Widget _buildItem(String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index; // Update selected index
          if(_selectedIndex==1){
            classController.text = '';
          }
        });
      },
      child: Container(
        width: double.infinity, // Make the container take full width
        margin: EdgeInsets.only(top: 12.0),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: _selectedIndex == index ? ColorSys.primary : Colors.grey, // Change border color based on selection
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: _selectedIndex == index ? ColorSys.primary : Colors.black, // Change border color based on selection
          ),
        ),
      ),
    );
  }
  void _showClassSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Select Class'),
          content: SingleChildScrollView( // Wrap content in SingleChildScrollView
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(12, (index) {
                // Create list of classes from Class 1 to Class 12
                return ListTile(
                  title: Text('Class ${index + 1}'),
                  onTap: () {
                    setState(() {
                      classController.text = 'Class ${index + 1}';
                    });
                    Navigator.pop(context);
                  },
                );
              }),
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "",
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
              Text(
                'I am...',
                style: const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
              ),
              SizedBox( height: 16),
              _buildItem('Student', 0),
              _buildItem('Parent', 1),
              _buildItem('Teacher', 2),
              SizedBox( height: 19),
            if (_selectedIndex == 0 || _selectedIndex == 2) ...[
              Text(
                'Class',
                style: const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),
              ),
              SizedBox( height: 16),

              GestureDetector(
            onTap: () {
              // Open your selection logic here (e.g., show a bottom sheet or dialog)
              _showClassSelectionDialog(context);
            },
            child: AbsorbPointer( // Prevent editing of the TextField
              child: TextField(
                controller: classController,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: ColorSys.primary, // Color for the focused border
                      width: 2, // Set border width for focus state
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey, // Color for the enabled border
                      width: 2, // Set border width for the enabled state
                    ),
                  ),
                  hintText: 'Select Class',
                  suffixIcon: Icon(
                    Icons.arrow_drop_down, // Down arrow icon
                    color: ColorSys.primary, // Icon color
                  ),
                ),
              ),
            ),
          ),
              ],
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FillDetails(selectedIndex: _selectedIndex),
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




}
