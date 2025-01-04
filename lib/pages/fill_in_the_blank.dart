import 'package:flutter/material.dart';

class FillInTheBlankGameScreen extends StatefulWidget {
  @override
  _FillInTheBlankGameScreenState createState() =>
      _FillInTheBlankGameScreenState();
}

class _FillInTheBlankGameScreenState extends State<FillInTheBlankGameScreen> {
  String sentence = 'I am learning ___ language.';
  String answer = '';
  String correctAnswer = 'Flutter';

  void _checkAnswer() {
    if (answer.toLowerCase() == correctAnswer.toLowerCase()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Correct!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Incorrect. The correct answer is Flutter.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fill in the Blank Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              sentence.replaceAll('___', '_____'),
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  answer = value;
                });
              },
              decoration: InputDecoration(labelText: 'Your Answer'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkAnswer,
              child: Text('Submit Answer'),
            ),
          ],
        ),
      ),
    );
  }
}
