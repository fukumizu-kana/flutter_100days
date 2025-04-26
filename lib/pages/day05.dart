import 'package:flutter/material.dart';
import 'package:concentric_transition/concentric_transition.dart';

class Day05 extends StatelessWidget {
  const Day05({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final pages = [
      {
        'icon': Icons.pets,
        'title': "いぬ",
        'bgColor': const Color.fromARGB(255, 251, 231, 241),
        'textColor': const Color(0xFFB06D8E),
      },
      {
        'icon': Icons.star,
        'title': "星",
        'bgColor': const Color.fromARGB(255, 255, 215, 234),
        'textColor': const Color(0xFFB06D8E),
      },
      {
        'icon': Icons.fastfood,
        'title': "ごはん",
        'bgColor': const Color.fromARGB(255, 255, 185, 220),
        'textColor': const Color(0xFFB06D8E),
      },
    ];

    return Scaffold(
      body: ConcentricPageView(
        colors: pages.map((p) => p['bgColor'] as Color).toList(),
        radius: screenWidth * 0.1,
        nextButtonBuilder: (context) => Padding(
          padding: const EdgeInsets.only(left: 3),
          child: Icon(
            Icons.navigate_next,
            size: screenWidth * 0.08,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
        scaleFactor: 2,
        itemBuilder: (index) {
          final page = pages[index % pages.length];
          final screenHeight = MediaQuery.of(context).size.height;
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (page['textColor'] as Color).withOpacity(0.1),
                  ),
                  child: Icon(
                    page['icon'] as IconData,
                    size: screenHeight * 0.1,
                    color: page['textColor'] as Color,
                  ),
                ),
                Text(
                  page['title'] as String,
                  style: TextStyle(
                    color: page['textColor'] as Color,
                    fontSize: screenHeight * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
