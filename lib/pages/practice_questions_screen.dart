import 'package:flutter/material.dart';
import 'package:shiksha/pages/subject_category.dart';

class PracticeQuestion {
  final String question;
  final List<String> options;
  final String correctAnswer;

  PracticeQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}

class PracticeQuestionsScreen extends StatefulWidget {
  final QuizTopic quizTopic;

  PracticeQuestionsScreen({required this.quizTopic});

  @override
  _PracticeQuestionsScreenState createState() =>
      _PracticeQuestionsScreenState();
}

class _PracticeQuestionsScreenState extends State<PracticeQuestionsScreen> {
  // Example practice questions (you can replace this with real data)
  final List<PracticeQuestion> practiceQuestions = [
    PracticeQuestion(
      question: 'What is 2 + 2?',
      options: ['2', '3', '4', '5'],
      correctAnswer: '4',
    ),
    PracticeQuestion(
      question: 'What is the capital of France?',
      options: ['Berlin', 'Madrid', 'Paris', 'Rome'],
      correctAnswer: 'Paris',
    ),
    PracticeQuestion(
      question: 'Which element has the atomic number 1?',
      options: ['Oxygen', 'Hydrogen', 'Carbon', 'Nitrogen'],
      correctAnswer: 'Hydrogen',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '${widget.quizTopic.title} Practice Questions',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: practiceQuestions.length,
          itemBuilder: (context, index) {
            final question = practiceQuestions[index];
            return PracticeQuestionCard(question: question);
          },
        ),

      )
    );
  }
}

class PracticeQuestionCard extends StatefulWidget {
  final PracticeQuestion question;

  PracticeQuestionCard({required this.question});

  @override
  _PracticeQuestionCardState createState() => _PracticeQuestionCardState();
}

class _PracticeQuestionCardState extends State<PracticeQuestionCard> {
  String? selectedAnswer;
  String resultMessage = '';
  bool isAnswered = false; // Track if the question is answered

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.question.question,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Column(
              children: widget.question.options.map((option) {
                return ListTile(
                  title: Text(option),
                  tileColor: selectedAnswer == option
                      ? (option == widget.question.correctAnswer
                      ? Colors.green.shade200
                      : Colors.red.shade200)
                      : null,
                  onTap: isAnswered
                      ? null // Disable re-answering
                      : () {
                    setState(() {
                      selectedAnswer = option;
                      if (selectedAnswer == widget.question.correctAnswer) {
                        resultMessage = 'Correct!';
                      } else {
                        resultMessage =
                        'Incorrect. The correct answer is ${widget.question.correctAnswer}.';
                      }
                      isAnswered = true; // Mark question as answered
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 12.0),
            if (resultMessage.isNotEmpty)
              Text(
                resultMessage,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: resultMessage == 'Correct!' ? Colors.green : Colors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
