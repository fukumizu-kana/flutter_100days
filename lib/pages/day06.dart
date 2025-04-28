import 'package:flutter/material.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';

class Day06 extends StatefulWidget {
  const Day06({super.key});

  @override
  State<Day06> createState() => _Day06State();
}

class _Day06State extends State<Day06> {
  int _counter = 2025;
  void _changeCounter(int value) {
    setState(() {
      _counter += value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'animated_flip_counter',
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
      backgroundColor: const Color(0xFFFFF0F7),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedFlipCounter(
            value: _counter,
            duration: const Duration(milliseconds: 600),
            textStyle: const TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              fontFamily: 'ZenMaruGothic',
              color: Color(0xFFCE7DA5),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('+1', () => _changeCounter(1)),
                _buildButton('-1', () => _changeCounter(-1)),
                _buildButton('+10', () => _changeCounter(10)),
                _buildButton('-10', () => _changeCounter(-10)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label, VoidCallback onPressed) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFFCE7DA5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: const BorderSide(color: Color(0xFFCE7DA5)),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'ZenMaruGothic',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
