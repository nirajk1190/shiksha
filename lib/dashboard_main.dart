import 'package:flutter/material.dart';
import 'package:shiksha/pages/games_category_screen.dart';
import 'package:shiksha/pages/home_page.dart';
import 'package:shiksha/pages/profile_page.dart';
import 'package:shiksha/pages/subject_category.dart';
import 'package:shiksha/util/ColorSys.dart';

class DashboardMain extends StatefulWidget {
  @override
  _DashboardMainState createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {
  int _selectedIndex = 0;

  // List of screens to navigate
  final List<Widget> _screens = [
    HomePage(),
    SubjectCategoryScreen(),
    GameCategoriesScreen(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectedIndex], // Show the selected screen
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30, // Set the desired icon size here
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.school,
              size: 30, // Set the desired icon size here
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.games,
              size: 30, // Set the desired icon size here
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 30, // Set the desired icon size here
            ),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: ColorSys.primary,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed, // Use fixed type to avoid clipping
        iconSize: 30, // Adjust the size of the icons globally
      ),
    );
  }
}
