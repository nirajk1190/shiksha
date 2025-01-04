import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shiksha/pages/quiz_topic.dart';
import 'package:shiksha/util/ColorSys.dart';
import 'games_subject.dart';

class Subject {
  final String name;
  final List<QuizTopic> quizTopics;
  final String icon; // Path to the SVG asset

  Subject({required this.name, required this.quizTopics, required this.icon});
}

class QuizTopic {
  final String title;
  final String description;

  QuizTopic({required this.title, required this.description});
}

class SubjectCategoryScreen extends StatefulWidget {
  @override
  _SubjectCategoryScreenState createState() => _SubjectCategoryScreenState();
}

class _SubjectCategoryScreenState extends State<SubjectCategoryScreen> {
  final List<Subject> subjects = [
    Subject(
      name: 'Math',
      quizTopics: [
        QuizTopic(title: 'Algebra', description: 'Basic and advanced algebra problems'),
        QuizTopic(title: 'Geometry', description: 'Learn geometry concepts'),
        QuizTopic(title: 'Calculus', description: 'Introduction to calculus'),
      ],
      icon: 'assets/mathematics.svg', // Math icon
    ),
    Subject(
      name: 'Science',
      quizTopics: [
        QuizTopic(title: 'Physics', description: 'Learn about motion and forces'),
        QuizTopic(title: 'Chemistry', description: 'Chemical reactions and elements'),
        QuizTopic(title: 'Biology', description: 'Human body and ecosystems'),
      ],
      icon: 'assets/science.svg', // Science icon
    ),
    Subject(
      name: 'History',
      quizTopics: [
        QuizTopic(title: 'World War II', description: 'Details of the second world war'),
        QuizTopic(title: 'Ancient Civilizations', description: 'Egyptian and Greek history'),
        QuizTopic(title: 'Modern History', description: 'History of the 20th century'),
      ],
      icon: 'assets/history.svg', // History icon
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Subject Categories',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: null,
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
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            final subject = subjects[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizTopicsScreen(subject: subject),
                  ),
                );
              },
              child: Card(
                elevation: 12.0,
                color: Colors.white, // Change color on selection
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      subject.icon, // Use the SVG asset path here
                      width: 40.0, // Adjust size as necessary
                      height: 40.0, // Adjust size as necessary
                      placeholderBuilder: (context) => const CircularProgressIndicator(),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      subject.name,
                      style: TextStyle(
                        color: Colors.black, // Change color on selection
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );

          },
        ),
      )
    );
  }
}
