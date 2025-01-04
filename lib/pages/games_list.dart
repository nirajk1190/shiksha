import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shiksha/pages/scramble_games.dart';
import 'package:shiksha/pages/word_games.dart';

import 'games_category_screen.dart';

class Game {
  final String name;
  final String description;
  final Widget screen;

  Game({required this.name, required this.description, required this.screen});
}

class GameListScreen extends StatelessWidget {
  final GameCategory category;

  GameListScreen({required this.category});

  final List<Game> wordGames = [
    Game(name: 'Word Search', description: 'Find the hidden words', screen: WordSearchGameScreen()),
    Game(name: 'Scramble Words', description: 'Unscramble the jumbled letters', screen: ScrambleWordsGameScreen()),
  ];

  final List<Game> quizGames = [
    Game(name: 'Geography Quiz', description: 'Test your geography knowledge', screen: GeographyQuizScreen()),
    Game(name: 'Math Quiz', description: 'Test your math skills', screen: MathQuizScreen()),
  ];

  final List<Game> matchingGames = [
    Game(name: 'Animal Match', description: 'Match animals to their sounds', screen: AnimalMatchGameScreen()),
    Game(name: 'Fruit Match', description: 'Match fruits to their colors', screen: FruitMatchGameScreen()),
  ];

  final List<Game> fillInTheBlankGames = [
    Game(name: 'Sentence Completion', description: 'Complete the sentence', screen: SentenceCompletionGameScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    List<Game> gamesList;

    switch (category.name) {
      case 'Word Games':
        gamesList = wordGames;
        break;
      case 'Quiz Games':
        gamesList = quizGames;
        break;
      case 'Matching Games':
        gamesList = matchingGames;
        break;
      case 'Fill in the Blank':
        gamesList = fillInTheBlankGames;
        break;
      default:
        gamesList = [];
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:  Text(
          category.name,
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
        padding: const EdgeInsets.all(16.0), // Add margin around the ListView
        child: ListView.builder(
          itemCount: gamesList.length,
          itemBuilder: (context, index) {
            final game = gamesList[index];
            return Card(
              color: Colors.white,
              elevation: 12.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8.0), // Add margin to each card
              child: ListTile(
                title: Text(game.name, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600)),
                subtitle: Text(game.description,style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => game.screen,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),

    );
  }
}


class GeographyQuizScreen extends StatefulWidget {
  @override
  _GeographyQuizScreenState createState() => _GeographyQuizScreenState();
}

class _GeographyQuizScreenState extends State<GeographyQuizScreen> {
  List<Map<String, dynamic>> questions = [
    {
      'question': 'What is the capital of France?',
      'options': ['Berlin', 'Madrid', 'Paris', 'Rome'],
      'answer': 'Paris',
    },
    {
      'question': 'Which continent is the Sahara Desert located in?',
      'options': ['Asia', 'Africa', 'Australia', 'Europe'],
      'answer': 'Africa',
    },
    {
      'question': 'What is the largest ocean in the world?',
      'options': ['Atlantic Ocean', 'Indian Ocean', 'Arctic Ocean', 'Pacific Ocean'],
      'answer': 'Pacific Ocean',
    },
    {
      'question': 'Which country is known as the Land of the Rising Sun?',
      'options': ['China', 'Japan', 'India', 'South Korea'],
      'answer': 'Japan',
    },
    {
      'question': 'What is the longest river in the world?',
      'options': ['Amazon River', 'Nile River', 'Yangtze River', 'Mississippi River'],
      'answer': 'Nile River',
    },
  ];

  int currentQuestionIndex = 0;
  String selectedAnswer = '';
  bool isAnswered = false;
  int score = 0;
  int timeRemaining = 30;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  // Start countdown timer
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeRemaining > 0 && !isAnswered) {
        setState(() {
          timeRemaining--;
        });
      } else if (timeRemaining == 0 && !isAnswered) {
        _checkAnswer();
      }
    });
  }

  // Check the selected answer
  void _checkAnswer() {
    setState(() {
      if (selectedAnswer == questions[currentQuestionIndex]['answer']) {
        score++;
      }
      isAnswered = true;
    });
  }

  // Go to the next question
  void _nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = '';
        isAnswered = false;
        timeRemaining = 30;
      });
      _timer.cancel();
      _startTimer();
    } else {
      _endGame();
    }
  }

  // End the game
  void _endGame() {
    _timer.cancel();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('Your final score is: $score'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  score = 0;
                  currentQuestionIndex = 0;
                  timeRemaining = 30;
                });
                _startTimer();
              },
              child: Text('Restart'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Geography Quiz Game'),
        backgroundColor: Colors.blueAccent,
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Timer display
            Text(
              'Time Remaining: $timeRemaining',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Question
            Text(
              currentQuestion['question'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),

            // Options (multiple choice)
            for (var option in currentQuestion['options'])
              ElevatedButton(
                onPressed: isAnswered
                    ? null
                    : () {
                  setState(() {
                    selectedAnswer = option;
                  });
                },
                child: Text(option),
              ),
            SizedBox(height: 20),

            // Submit answer button
            ElevatedButton(
              onPressed: isAnswered ? _nextQuestion : _checkAnswer,
              child: Text(isAnswered ? 'Next Question' : 'Submit Answer'),
            ),
            SizedBox(height: 20),

            // Score display
            Text(
              'Score: $score',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Feedback on the selected answer
            if (isAnswered)
              Text(
                selectedAnswer == currentQuestion['answer']
                    ? 'Correct!'
                    : 'Incorrect! The correct answer is ${currentQuestion['answer']}.',
                style: TextStyle(fontSize: 20, color: selectedAnswer == currentQuestion['answer'] ? Colors.green : Colors.red),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}

class MathQuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Math Quiz Game')),
      body: Center(
        child: Text('Math Quiz Game Screen'),
      ),
    );
  }
}


class AnimalMatchGameScreen extends StatefulWidget {
  @override
  _AnimalMatchGameScreenState createState() => _AnimalMatchGameScreenState();
}

class _AnimalMatchGameScreenState extends State<AnimalMatchGameScreen> {
  final List<String> animals = [
    '🐶', '🐱', '🦁', '🐮', '🐵', '🐸', '🐼', '🐨',
  ];
  late List<String> gameGrid;
  List<bool> visibleTiles = [];
  List<int> selectedTiles = [];
  int score = 0;

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    // Shuffle and double the animal list to create pairs
    List<String> shuffledAnimals = [...animals, ...animals];
    shuffledAnimals.shuffle(Random());

    setState(() {
      gameGrid = shuffledAnimals;
      visibleTiles = List.generate(shuffledAnimals.length, (_) => false);
      selectedTiles = [];
      score = 0;
    });
  }

  void _onTileTap(int index) {
    if (visibleTiles[index] || selectedTiles.length >= 2) return;

    setState(() {
      visibleTiles[index] = true;
      selectedTiles.add(index);

      if (selectedTiles.length == 2) {
        _checkMatch();
      }
    });
  }

  void _checkMatch() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        if (gameGrid[selectedTiles[0]] == gameGrid[selectedTiles[1]]) {
          score++;
        } else {
          visibleTiles[selectedTiles[0]] = false;
          visibleTiles[selectedTiles[1]] = false;
        }
        selectedTiles.clear();

        // Check if the game is over
        if (score == animals.length) {
          _showGameOverDialog();
        }
      });
    });
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Game Over!'),
        content: Text('Your score: $score'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _startGame();
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Animal Match Game",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Score: $score',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: gameGrid.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _onTileTap(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: visibleTiles[index] ? Colors.white : Colors.green,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black),
                      ),
                      alignment: Alignment.center,
                      child: visibleTiles[index]
                          ? Text(
                        gameGrid[index],
                        style: const TextStyle(fontSize: 32),
                      )
                          : const Text(
                        '?',
                        style: TextStyle(fontSize: 32, color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class FruitMatchGameScreen extends StatefulWidget {
  @override
  _FruitMatchGameScreenState createState() => _FruitMatchGameScreenState();
}

class _FruitMatchGameScreenState extends State<FruitMatchGameScreen> {
  final List<String> fruits = [
    '🍎', '🍌', '🍇', '🍉', '🍓', '🍒', '🥭', '🍍',
  ];
  late List<String> gameGrid;
  List<bool> visibleTiles = [];
  List<int> selectedTiles = [];
  int score = 0;

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    // Shuffle and double the fruit list to create pairs
    List<String> shuffledFruits = [...fruits, ...fruits];
    shuffledFruits.shuffle(Random());

    setState(() {
      gameGrid = shuffledFruits;
      visibleTiles = List.generate(shuffledFruits.length, (_) => false);
      selectedTiles = [];
      score = 0;
    });
  }

  void _onTileTap(int index) {
    if (visibleTiles[index] || selectedTiles.length >= 2) return;

    setState(() {
      visibleTiles[index] = true;
      selectedTiles.add(index);

      if (selectedTiles.length == 2) {
        _checkMatch();
      }
    });
  }

  void _checkMatch() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        if (gameGrid[selectedTiles[0]] == gameGrid[selectedTiles[1]]) {
          score++;
        } else {
          visibleTiles[selectedTiles[0]] = false;
          visibleTiles[selectedTiles[1]] = false;
        }
        selectedTiles.clear();

        // Check if the game is over
        if (score == fruits.length) {
          _showGameOverDialog();
        }
      });
    });
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Game Over!'),
        content: Text('Your score: $score'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _startGame();
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Fruit Match Game",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Score: $score',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: gameGrid.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _onTileTap(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: visibleTiles[index] ? Colors.white : Colors.orange,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black),
                      ),
                      alignment: Alignment.center,
                      child: visibleTiles[index]
                          ? Text(
                        gameGrid[index],
                        style: const TextStyle(fontSize: 32),
                      )
                          : const Text(
                        '?',
                        style: TextStyle(fontSize: 32, color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SentenceCompletionGameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SentenceCompletionGame Quiz Game')),
      body: Center(
        child: Text('SentenceCompletionGame Quiz Game Screen'),
      ),
    );
  }
}
