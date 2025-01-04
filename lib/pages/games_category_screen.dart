import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'games_list.dart';

class GameCategory {
  final String name;
  final String icon; // Path to the SVG asset

  GameCategory({required this.name, required this.icon});
}

class GameCategoriesScreen extends StatelessWidget {
  final List<GameCategory> categories = [
    GameCategory(name: 'Word Games', icon: 'assets/word_games.svg'),
    GameCategory(name: 'Quiz Games', icon: 'assets/quiz.svg'),
    GameCategory(name: 'Matching Games', icon: 'assets/matching.svg'),
    GameCategory(name: 'Fill in the Blank', icon: 'assets/edit.svg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Game Categories',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: null
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 1.0,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return InkWell(
              onTap: () {
                // Navigate to the games of the selected category
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameListScreen(category: category),
                  ),
                );
              },
              child: Card(
                elevation: 12.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      category.icon, // Use the SVG asset path here
                      width: 40.0, // Adjust size as necessary
                      height: 40.0, // Adjust size as necessary
                      placeholderBuilder: (context) => const CircularProgressIndicator(),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      category.name,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
