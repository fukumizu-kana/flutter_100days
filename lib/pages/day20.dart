import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_confetti/flutter_confetti.dart';

class Day20 extends StatefulWidget {
  const Day20({super.key});

  @override
  State<Day20> createState() => _Day20State();
}

class _Day20State extends State<Day20> {
  bool isHatched = false;
  final CountDownController _controller = CountDownController();

  void _celebrate(BuildContext context) {
    Confetti.launch(
      context,
      options: const ConfettiOptions(
        particleCount: 100,
        spread: 80,
        y: 0.5,
        colors: [Colors.orange, Colors.amber, Colors.yellow, Colors.pink],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('circular_countdown_timer/ぽもごっち'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE0B2), Color(0xFFFFCCBC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(seconds: 2),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 20 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: Text(
                isHatched ? '🐣' : '🥚',
                style: const TextStyle(fontSize: 120),
              ),
            ),
            Positioned(
              bottom: 200,
              child: CircularCountDownTimer(
                duration: 300,
                initialDuration: 0,
                controller: _controller,
                width: 120,
                height: 120,
                ringColor: Colors.grey[300]!,
                fillColor: Colors.orange,
                backgroundColor: Colors.white,
                strokeWidth: 10,
                strokeCap: StrokeCap.round,
                textStyle: const TextStyle(fontSize: 24),
                isReverse: true,
                isTimerTextShown: true,
                autoStart: false,
                onComplete: () {
                  setState(() => isHatched = true);
                  _celebrate(context);
                },
              ),
            ),
            Positioned(
              bottom: 100,
              child: ElevatedButton.icon(
                onPressed: () {
                  _controller.restart();
                  setState(() => isHatched = false);
                },
                icon: const Icon(Icons.timer),
                label: const Text('タイマー開始'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 28, vertical: 18),
                  textStyle: const TextStyle(fontSize: 18),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
