import 'package:flutter/material.dart';

class MatchingGameScreen extends StatefulWidget {
  @override
  _MatchingGameScreenState createState() => _MatchingGameScreenState();
}

class _MatchingGameScreenState extends State<MatchingGameScreen> {
  List<String> words = ['Cat', 'Dog', 'Apple'];
  List<String> meanings = ['A pet animal', 'A loyal pet', 'A fruit'];
  List<String> shuffledWords = [];
  List<String> shuffledMeanings = [];

  @override
  void initState() {
    super.initState();
    shuffledWords = List.from(words)..shuffle();
    shuffledMeanings = List.from(meanings)..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matching Game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: shuffledWords.map((word) {
                return Draggable<String>(
                  data: word,
                  child: Container(
                    color: Colors.blue,
                    padding: EdgeInsets.all(8.0),
                    child: Text(word, style: TextStyle(color: Colors.white)),
                  ),
                  feedback: Material(
                    child: Container(
                      color: Colors.blue,
                      padding: EdgeInsets.all(8.0),
                      child: Text(word, style: TextStyle(color: Colors.white)),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: shuffledMeanings.map((meaning) {
                return DragTarget<String>(
                  onAccept: (data) {
                    // You can check if the matching word is correct here
                    if (data == 'Cat' && meaning == 'A pet animal') {
                      print('Correct');
                    }
                  },
                  builder: (context, accepted, rejected) {
                    return Container(
                      color: Colors.green,
                      padding: EdgeInsets.all(8.0),
                      child: Text(meaning),
                    );
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
