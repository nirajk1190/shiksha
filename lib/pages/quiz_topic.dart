import 'package:flutter/material.dart';
import 'package:shiksha/pages/practice_questions_screen.dart';
import 'package:shiksha/pages/subject_category.dart';

import '../util/ColorSys.dart'; // Import your Subject model

class QuizTopicsScreen extends StatefulWidget {
  final Subject subject;

  QuizTopicsScreen({required this.subject});
  @override
  _QuizTopicsScreenState createState() => _QuizTopicsScreenState();
}

class _QuizTopicsScreenState extends State<QuizTopicsScreen> {

  int? _selectedIndex; // To track the selected card index

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '${widget.subject.name} Quiz Topics',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        padding: const EdgeInsets.all(16.0),
        itemCount: widget.subject.quizTopics.length,
        itemBuilder: (context, index) {
          final quizTopic = widget.subject.quizTopics[index];
          bool isSelected = _selectedIndex == index; // Check if the card is selected

          return Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            color: isSelected ? ColorSys.primary : Colors.white, // Change color on selection
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedIndex = isSelected ? null : index; // Toggle selection
                });
                if (_selectedIndex != null) {
                  // Navigate to PracticeQuestionsScreen when a quiz topic is clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PracticeQuestionsScreen(quizTopic: quizTopic),
                    ),
                  );
                }

              },
              child: Center(
                child: Text(
                  quizTopic.title,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.black, // Change color on selection
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
