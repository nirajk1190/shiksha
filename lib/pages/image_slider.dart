import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shiksha/util/ColorSys.dart';

class ImageSliderWithDots extends StatefulWidget {
  final List<String> images;
  final List<String> titles;

  const ImageSliderWithDots({
    Key? key,
    required this.images,
    required this.titles,
  }) : super(key: key);

  @override
  _ImageSliderWithDotsState createState() => _ImageSliderWithDotsState();
}

class _ImageSliderWithDotsState extends State<ImageSliderWithDots> {
  int _currentPage = 0;
  late PageController _pageController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);

    // Start auto-sliding
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < widget.images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Ensure the Column does not expand unnecessarily
      children: [
        // Slider
        SizedBox(
          height: 200, // Adjust height of the slider
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        widget.images[index],
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover, // Ensure the image fits the container
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.titles[index],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        // Dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.images.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentPage == index ? 12 : 8,
              height: _currentPage == index ? 12 : 8,
              decoration: BoxDecoration(
                color: _currentPage == index ? ColorSys.primary : Colors.grey,
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
      ],
    );
  }
}
