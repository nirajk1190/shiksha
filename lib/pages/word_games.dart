import 'package:flutter/material.dart';
import 'dart:math';

class WordSearchGameScreen extends StatefulWidget {
  @override
  _WordSearchGameScreenState createState() => _WordSearchGameScreenState();
}

class _WordSearchGameScreenState extends State<WordSearchGameScreen> {
  final List<String> words = ['APPLE', 'BANANA', 'CHERRY', 'ORANGE', 'MANGO'];
  late List<List<String>> grid;
  late List<List<bool>> selected;
  String currentWord = '';
  List<String> foundWords = [];

  @override
  void initState() {
    super.initState();
    _generateGrid();
  }

  void _generateGrid() {
    grid = List.generate(10, (_) => List.generate(10, (_) => ''));
    selected = List.generate(10, (_) => List.generate(10, (_) => false));

    Random rand = Random();

    // Place words in the grid
    for (var word in words) {
      bool placed = false;
      while (!placed) {
        int row = rand.nextInt(10);
        int col = rand.nextInt(10);
        bool horizontal = rand.nextBool();

        if (horizontal && col + word.length <= 10 && _canPlaceWord(row, col, word, horizontal)) {
          for (int i = 0; i < word.length; i++) {
            grid[row][col + i] = word[i];
          }
          placed = true;
        } else if (!horizontal && row + word.length <= 10 && _canPlaceWord(row, col, word, horizontal)) {
          for (int i = 0; i < word.length; i++) {
            grid[row + i][col] = word[i];
          }
          placed = true;
        }
      }
    }

    // Fill the rest of the grid with random letters
    for (int row = 0; row < 10; row++) {
      for (int col = 0; col < 10; col++) {
        if (grid[row][col] == '') {
          grid[row][col] = String.fromCharCode(rand.nextInt(26) + 65);
        }
      }
    }
  }

  bool _canPlaceWord(int row, int col, String word, bool horizontal) {
    for (int i = 0; i < word.length; i++) {
      int r = row + (horizontal ? 0 : i);
      int c = col + (horizontal ? i : 0);
      if (grid[r][c] != '' && grid[r][c] != word[i]) {
        return false;
      }
    }
    return true;
  }

  void _onLetterTap(int row, int col) {
    setState(() {
      currentWord += grid[row][col];
      selected[row][col] = true;

      // Check if the current word matches a valid word
      if (words.contains(currentWord) && !foundWords.contains(currentWord)) {
        foundWords.add(currentWord); // Add word to found list
        _highlightFoundWord(currentWord); // Highlight the found word
        currentWord = ''; // Reset current word
        _resetSelection(); // Reset the grid, keeping found words highlighted
      } else if (!words.any((word) => word.startsWith(currentWord))) {
        // Reset the current word and selection if it doesn't match any word
        currentWord = '';
        _resetSelection();
      }
    });
  }

  void _resetSelection() {
    for (int row = 0; row < 10; row++) {
      for (int col = 0; col < 10; col++) {
        // Keep selected true for cells in found words
        selected[row][col] = foundWords.any((word) =>
            _isCellPartOfWord(row, col, word));
      }
    }
  }

  bool _isCellPartOfWord(int row, int col, String word) {
    // Check if the cell is part of a found word (horizontal or vertical)
    int wordLength = word.length;

    // Check horizontal
    if (col + wordLength <= 10 &&
        List.generate(wordLength, (i) => grid[row][col + i]).join() == word) {
      return true;
    }

    // Check vertical
    if (row + wordLength <= 10 &&
        List.generate(wordLength, (i) => grid[row + i][col]).join() == word) {
      return true;
    }

    return false;
  }


  void _highlightFoundWord(String word) {
    for (int row = 0; row < 10; row++) {
      for (int col = 0; col < 10; col++) {
        if (grid[row][col] == word[0]) {
          int wordLength = word.length;

          // Check horizontal
          if (col + wordLength <= 10 &&
              List.generate(wordLength, (i) => grid[row][col + i]).join() == word) {
            for (int i = 0; i < wordLength; i++) {
              selected[row][col + i] = true;
            }
            return;
          }

          // Check vertical
          if (row + wordLength <= 10 &&
              List.generate(wordLength, (i) => grid[row + i][col]).join() == word) {
            for (int i = 0; i < wordLength; i++) {
              selected[row + i][col] = true;
            }
            return;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Word Search Game",
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
          children: [
            // Grid of letters
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemCount: 100,
                itemBuilder: (context, index) {
                  int row = index ~/ 10;
                  int col = index % 10;
                  return GestureDetector(
                    onTap: () => _onLetterTap(row, col),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8),
                        color: selected[row][col] ? Colors.lightGreen : Colors.white,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        grid[row][col],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: selected[row][col] ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 16),
            Text(
              'Words Found: ${foundWords.join(", ")}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
