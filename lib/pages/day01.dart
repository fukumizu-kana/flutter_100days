import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '/widgets/falling_leaf.dart';

class Day01 extends StatefulWidget {
  const Day01({super.key});

  @override
  State<Day01> createState() => _Day01State();
}

class _Day01State extends State<Day01> {
  int animationIndex = 0;
  bool isTanuki = false;
  String omikujiImage = '';
  final List<Widget> leaves = [];
  bool showLeaves = false;

  final animations = <String, Widget Function(Widget)>{
    'ぶるぶる（shake）': (w) => w.animate(key: const ValueKey('shake')).shake(),
    'くるん（rotate）': (w) => w.animate(key: const ValueKey('rotate')).rotate(duration: 600.ms),
    'びよーん（scale）': (w) => w.animate(key: const ValueKey('scale')).scale(duration: 500.ms),
    'ぬるっ（slideX）': (w) => w.animate(key: const ValueKey('slideX')).slideX(begin: -1, end: 0),
    'ひょこっ（slideY）': (w) => w.animate(key: const ValueKey('slideY')).slideY(begin: 1, end: 0),
    'じわ〜ん（変身）': (w) => w.animate(key: const ValueKey('tint')).tint(
          color: const Color.fromARGB(224, 255, 29, 157).withOpacity(0.3),
          duration: 600.ms,
        ),
  };

  List<String> get animationKeys => animations.keys.toList();

  void animateDog() {
    int nextIndex;
    do {
      nextIndex = Random().nextInt(animationKeys.length);
    } while (nextIndex == animationIndex);

    final selectedKey = animationKeys[nextIndex];

    setState(() {
      animationIndex = nextIndex;

      switch (selectedKey) {
        case 'ぶるぶる（shake）':
          omikujiImage = 'images/omikuji/daikichi.png';
          startLeafAnimation();
          isTanuki = false;
          break;
        case 'じわ〜ん（変身）':
          omikujiImage = 'images/omikuji/kyou.png';
          Future.delayed(600.ms, () {
            setState(() {
              isTanuki = true;
            });
          });
          break;
        default:
          final list = ['kichi', 'chuukichi', 'shoukichi', 'suekichi'];
          final selected = list[Random().nextInt(list.length)];
          omikujiImage = 'images/omikuji/$selected.png';
          isTanuki = false;
          break;
      }
    });
  }

  void startLeafAnimation() {
    leaves.clear();
    showLeaves = true;

    final screenWidth = MediaQuery.of(context).size.width;
    const leafCount = 10;
    final laneWidth = screenWidth / leafCount;

    for (int i = 0; i < leafCount; i++) {
      final baseX = i * laneWidth;
      final jitter = Random().nextDouble() * (laneWidth * 0.4) - (laneWidth * 0.2); // ±20%ズレ
      final startX = (baseX + jitter).clamp(0.0, screenWidth);

      leaves.add(
        FallingLeaf(
          key: UniqueKey(),
          imagePath: 'images/leaf.png',
          startX: startX,
          delay: Duration(milliseconds: Random().nextInt(800)),
        ),
      );
    }

    setState(() {});
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        showLeaves = false;
      });
    });
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
          if (showLeaves) ...leaves,
          SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (omikujiImage.isNotEmpty)
                  Positioned(
                    top: 80,
                    child: Image.asset(
                      omikujiImage,
                      width: 120,
                    ),
                  ),
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
