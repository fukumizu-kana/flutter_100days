import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Day07 extends StatefulWidget {
  const Day07({super.key});

  @override
  State<Day07> createState() => _Day07State();
}

class _Day07State extends State<Day07> {
  final controller = PageController();

  final pages = [
    Container(color: const Color(0xFFFFC1CC)),
    Container(color: const Color(0xFFB5EAD7)),
    Container(color: const Color(0xFFFFDAC1)),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F7),
      appBar: AppBar(
        title: const Text(
          'smooth_page_indicator',
          style: TextStyle(
            fontFamily: 'ZenMaruGothic',
            fontWeight: FontWeight.bold,
            color: Color(0xFFCE7DA5),
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFFCE7DA5)),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller,
              children: pages,
            ),
          ),
          const SizedBox(height: 16),
          SmoothPageIndicator(
            controller: controller,
            count: pages.length,
            effect: WormEffect(
              dotHeight: 12,
              dotWidth: 12,
              spacing: 16,
              dotColor: Colors.grey.shade300,
              activeDotColor: const Color(0xFFCE7DA5),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
