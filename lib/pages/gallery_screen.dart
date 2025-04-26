import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:page_transition/page_transition.dart';
import '/pages/day01.dart';
import '/pages/day05.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'title': 'flutter_animate\nanimated_text_kit',
        'image': 'images/omikuji_app.png',
        'screen': const Day01(),
      },
      {
        'title': 'concentric_transition',
        'image': 'images/day05_app.png',
        'screen': const Day05(),
      },
      {
        'title': 'coming soon...',
        'image': 'images/omikuji_app.png',
        'screen': null,
      },
      {
        'title': 'coming soon...',
        'image': 'images/omikuji_app.png',
        'screen': null,
      },
    ];

    final randomHeights = List.generate(items.length, (_) => 200.0 + Random().nextInt(60));

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFF0F7),
              Color(0xFFFEE3F0),
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 40),
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  'Flutter パッケージ 100days',
                  textStyle: const TextStyle(
                    fontFamily: 'ZenMaruGothic',
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFCE7DA5),
                  ),
                  speed: const Duration(milliseconds: 60),
                ),
              ],
              repeatForever: false,
              totalRepeatCount: 1,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: StaggeredGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: List.generate(items.length, (index) {
                    final item = items[index];
                    return StaggeredGridTile.extent(
                      crossAxisCellCount: 1,
                      mainAxisExtent: randomHeights[index],
                      child: GestureDetector(
                        onTap: () {
                          if (item['screen'] != null) {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.scale,
                                alignment: Alignment.center,
                                duration: const Duration(milliseconds: 400),
                                child: item['screen'] as Widget,
                              ),
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFD1B3C4).withOpacity(0.2),
                                blurRadius: 12,
                                offset: const Offset(2, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              children: [
                                Hero(
                                  tag: 'item-image-$index',
                                  child: Image.asset(
                                    item['image'] as String,
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.black.withOpacity(0.05),
                                          Colors.black.withOpacity(0.6),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                    child: Text(
                                      item['title'] as String,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'ZenMaruGothic',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ).animate().fadeIn(duration: 600.ms, delay: (index * 100).ms).moveY(begin: 30, end: 0, curve: Curves.easeOut),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
