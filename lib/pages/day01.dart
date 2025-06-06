import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
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
  bool boxShaken = false;

  final dogPhrases = [
    'おみくじ…引いてみない？',
    'へへっ、今日もいい日になるといいね！',
    '…たぬきじゃないよ？',
    'ぼく、しゃべれるんだよ',
    'にんげんっておもしろいね',
  ];
  int phraseIndex = 0;

  final animations = <String, Widget Function(Widget)>{
    'Shake': (w) => w.animate(key: const ValueKey('shake')).shake(),
    'Rotate': (w) => w.animate(key: const ValueKey('rotate')).rotate(duration: 600.ms),
    'Scale': (w) => w.animate(key: const ValueKey('scale')).scale(duration: 500.ms),
    'Slide X': (w) => w.animate(key: const ValueKey('slideX')).slideX(begin: -1, end: 0),
    'Slide Y': (w) => w.animate(key: const ValueKey('slideY')).slideY(begin: 1, end: 0),
    'Tint': (w) => w.animate(key: const ValueKey('tint')).tint(
          color: const Color.fromARGB(224, 255, 29, 157).withOpacity(0.3),
          duration: 600.ms,
        ),
  };

  List<String> get animationKeys => animations.keys.toList();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        boxShaken = true;
      });
    });
  }

  void animateDog() {
    int nextIndex;
    do {
      nextIndex = Random().nextInt(animationKeys.length);
    } while (nextIndex == animationIndex);

    final selectedKey = animationKeys[nextIndex];

    setState(() {
      animationIndex = nextIndex;
      phraseIndex = (phraseIndex + 1) % dogPhrases.length;

      switch (selectedKey) {
        case 'Shake':
          omikujiImage = 'images/omikuji/daikichi.png';
          startLeafAnimation();
          isTanuki = false;
          break;
        case 'Tint':
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
      final jitter = Random().nextDouble() * (laneWidth * 0.4) - (laneWidth * 0.2);
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
    final dogAsset = isTanuki ? 'images/tanuki.png' : 'images/dog.png';

    final dogImage = GestureDetector(
      onTapDown: (_) => animateDog(),
      child: Hero(
        tag: 'item-image-0',
        child: Image.asset(
          dogAsset,
          width: isTanuki ? 180 : 220,
          key: ValueKey(dogAsset),
        ),
      ),
    );

    final animatedDog = animations[animationKeys[animationIndex]]!(dogImage);

    final omikujiBox = Image.asset(
      omikujiImage.isEmpty ? 'images/omikuji.png' : omikujiImage,
      width: 120,
      key: const ValueKey('omikuji'),
    );

    final animatedBox = boxShaken && omikujiImage.isEmpty ? omikujiBox.animate().shake(duration: 1500.ms) : omikujiBox;

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
                Positioned(
                  top: 40,
                  child: AnimatedTextKit(
                    key: ValueKey(phraseIndex),
                    animatedTexts: [
                      TypewriterAnimatedText(
                        dogPhrases[phraseIndex],
                        textStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        speed: const Duration(milliseconds: 50),
                      ),
                    ],
                    totalRepeatCount: 1,
                    pause: const Duration(milliseconds: 500),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                  ),
                ),
                Positioned(
                  top: 80,
                  child: GestureDetector(
                    onTap: animateDog,
                    child: animatedBox,
                  ),
                ),
                Positioned(
                  bottom: isTanuki ? 100.0 : 60.0,
                  child: animatedDog.animate(key: const ValueKey('base')).moveY(begin: 100, end: 0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
