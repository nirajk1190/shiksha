import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class ScrambleWordsGameScreen extends StatefulWidget {
  @override
  _ScrambleWordsGameScreenState createState() =>
      _ScrambleWordsGameScreenState();
}

class _ScrambleWordsGameScreenState extends State<ScrambleWordsGameScreen> {
  // Game-themed words
  List<String> words = ['PACMAN', 'LEVEL', 'BONUS', 'QUEST', 'PIXEL', 'XP', 'BOSS', 'GAMER'];
  String currentWord = '';
  String scrambledWord = '';
  String userInput = '';
  bool isCorrect = false;
  bool isScrambled = true;
  int score = 0;
  int timeRemaining = 30;
  late Timer _timer;
  bool isGameOver = false;
  String hint = '';

  @override
  void initState() {
    super.initState();
    _getNewWord();
    _startTimer();
  }

  // Start countdown timer
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeRemaining > 0 && !isGameOver) {
        setState(() {
          timeRemaining--;
        });
      } else if (timeRemaining == 0) {
        _endGame();
      }
    });
  }

  // Get a random word and scramble it
  void _getNewWord() {
    if (isGameOver) return;

    final random = Random();
    String word = words[random.nextInt(words.length)];
    scrambledWord = _scrambleWord(word);
    currentWord = word;
    hint = ''; // Clear hint for new word
    userInput = '';
    isCorrect = false;
    isScrambled = true;
    setState(() {});
  }

  // Scramble the word letters
  String _scrambleWord(String word) {
    List<String> wordList = word.split('');
    wordList.shuffle();
    return wordList.join('');
  }

  // Handle user's input
  void _checkWord() {
    if (userInput.toUpperCase() == currentWord) {
      setState(() {
        isCorrect = true;
        isScrambled = false;
        score++;
      });
      _getNewWord();
    }
  }

  // End the game
  void _endGame() {
    setState(() {
      isGameOver = true;
    });
    _timer.cancel();
  }

  // Handle hint button (show first letter only)
  void _giveHint() {
    if (hint.isEmpty) {
      setState(() {
        hint = currentWord[0]; // Show first letter as a hint
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Scramble Words Game",
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

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Game timer
            Text(
              'Time Remaining: $timeRemaining',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Scrambled word display with animation
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: Text(
                scrambledWord,
                key: ValueKey<String>(scrambledWord),
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            SizedBox(height: 20),
            // TextField for user input with hint display
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: TextField(
                key: ValueKey<int>(userInput.length),
                onChanged: (input) {
                  setState(() {
                    userInput = input;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Enter the word',
                  border: OutlineInputBorder(),
                  hintText: hint.isNotEmpty ? 'Hint: $hint' : null,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkWord,
              child: Text('Check Word'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _giveHint,
              child: Text('Get Hint'),
            ),
            SizedBox(height: 20),
            // Show score and feedback
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: Text(
                'Score: $score',
                key: ValueKey<int>(score),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            if (isCorrect)
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: Text(
                  'Correct!',
                  key: ValueKey<String>('Correct'),
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.green,
                  ),
                ),
              ),
            SizedBox(height: 20),
            if (isGameOver)
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: Text(
                  'Game Over! Final Score: $score',
                  key: ValueKey<String>('GameOver'),
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.red,
                  ),
                ),
              ),
            SizedBox(height: 20),
            if (isGameOver)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    score = 0;
                    timeRemaining = 30;
                    isGameOver = false;
                  });
                  _getNewWord();
                  _startTimer();
                },
                child: Text('Restart Game'),
              ),
          ],
        ),
      ),
    );
  }
}
