import 'package:flutter/material.dart';

class Game {
  final String gameName;
  final String description;

  Game({required this.gameName, required this.description});
}

class Subject {
  final String name;
  final List<Game> games;

  Subject({required this.name, required this.games});
}

class SubjectWiseGamesScreen extends StatelessWidget {
  // Example subjects and games (replace with your actual data)
  final List<Subject> subjects = [
    Subject(
      name: 'Math',
      games: [
        Game(gameName: 'Math Quiz', description: 'Test your math skills with a fun quiz!'),
        Game(gameName: 'Math Puzzles', description: 'Solve math puzzles to boost your brain power.'),
      ],
    ),
    Subject(
      name: 'Science',
      games: [
        Game(gameName: 'Science Trivia', description: 'Answer science-related questions in a trivia game.'),
        Game(gameName: 'Physics Challenge', description: 'Complete physics problems to earn points.'),
      ],
    ),
    Subject(
      name: 'English',
      games: [
        Game(gameName: 'Word Search', description: 'Find hidden words in the puzzle.'),
        Game(gameName: 'Grammar Challenge', description: 'Test your grammar knowledge with fun questions.'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Subject Wise Games',
          style: TextStyle(
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
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            final subject = subjects[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 4.0,
              child: ListTile(
                title: Text(subject.name, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: subject.games.map((game) {
                    return ListTile(
                      title: Text(game.gameName),
                      subtitle: Text(game.description),
                      onTap: () {
                        // Navigate to the game screen (implement the screen for each game)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GameScreen(game: game),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class GameScreen extends StatelessWidget {
  final Game game;

  GameScreen({required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(game.gameName, style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(game.gameName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text(game.description, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Start the game (implement the actual game logic here)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlayGameScreen(game: game)),
                );
              },
              child: const Text('Play Game'),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayGameScreen extends StatelessWidget {
  final Game game;

  PlayGameScreen({required this.game});

  @override
  Widget build(BuildContext context) {
    // Example of how you would structure a game screen
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Playing: ${game.gameName}', style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Text('Game goes here! ${game.gameName}', style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}
