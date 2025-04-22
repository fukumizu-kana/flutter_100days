import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Day01 extends StatefulWidget {
  const Day01({super.key});

  @override
  State<Day01> createState() => _Day01State();
}

class _Day01State extends State<Day01> {
  int animationIndex = 0;
  bool isTanuki = false;

  final animations = <String, Widget Function(Widget)>{
    'ぶるぶる（shake）': (w) => w.animate(key: const ValueKey('shake')).shake(),
    'くるん（rotate）': (w) => w.animate(key: const ValueKey('rotate')).rotate(duration: 600.ms),
    'びよーん（scale）': (w) => w.animate(key: const ValueKey('scale')).scale(duration: 500.ms),
    'ぬるっ（slideX）': (w) => w.animate(key: const ValueKey('slideX')).slideX(begin: -1, end: 0),
    'ひょこっ（slideY）': (w) => w.animate(key: const ValueKey('slideY')).slideY(begin: 1, end: 0),
    'じわ〜ん（変身）': (w) => w.animate(key: const ValueKey('tint')).tint(
          color: const Color.fromARGB(255, 255, 217, 63).withOpacity(0.3),
          duration: 600.ms,
        ),
  };

  List<String> get animationKeys => animations.keys.toList();

  void animateDog() {
    int nextIndex;
    do {
      nextIndex = Random().nextInt(animationKeys.length);
    } while (nextIndex == animationIndex);

    setState(() {
      animationIndex = nextIndex;
    });

    final selectedKey = animationKeys[nextIndex];
    if (selectedKey == 'じわ〜ん（変身）') {
      Future.delayed(600.ms, () {
        setState(() {
          isTanuki = true;
        });
      });
    } else {
      isTanuki = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final animationKey = animationKeys[animationIndex];
    final dogAsset = isTanuki ? 'images/tanuki.png' : 'images/dog.png';

    final dogImage = GestureDetector(
      onTapDown: (_) => animateDog(),
      child: Image.asset(
        dogAsset,
        width: isTanuki ? 180 : 220,
        key: ValueKey(dogAsset),
      ),
    );

    final animatedDog = animations[animationKey]!(dogImage);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'images/shrine.png',
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: isTanuki ? 100.0 : 60.0,
                  child: animatedDog.animate(key: const ValueKey('base')).moveY(begin: 100, end: 0),
                ),
                Positioned(
                  bottom: 15,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text(
                      '今の動き：$animationKey',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.brown[700],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
