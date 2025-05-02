import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:page_transition/page_transition.dart';
import 'package:draggable_home/draggable_home.dart';
import '/pages/day01.dart';
import '/pages/day05.dart';
import '/pages/day06.dart';
import '/pages/day07.dart';
import '/pages/day08.dart';
import '/pages/day09.dart';

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
        'title': 'animated_flip_counter',
        'image': 'images/day06_app.png',
        'screen': const Day06(),
      },
      {
        'title': 'smooth_page_indicator',
        'image': 'images/day07_app.png',
        'screen': const Day07(),
      },
      {
        'title': 'flutter_spinkit',
        'image': 'images/day08_app.png',
        'screen': const Day08(),
      },
      {
        'title': 'flutter_chat_ui\nflutter_chat_types',
        'image': 'images/day09_app.png',
        'screen': const Day09(),
      },
    ];

    return DraggableHome(
      title: const Text(
        'Flutter パッケージ 100days',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'ZenMaruGothic',
          color: Color(0xFFCE7DA5),
        ),
      ),
      leading: const Icon(Icons.menu, color: Color(0xFFCE7DA5)),
      appBarColor: const Color(0xFFFFF0F7),
      backgroundColor: const Color(0xFFFFF0F7),
      headerWidget: Container(
        height: 140,
        width: double.infinity,
        padding: const EdgeInsets.only(top: 16),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFF0F7),
              Color(0xFFFEE3F0),
            ],
          ),
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(32),
          ),
        ),
        child: AnimatedTextKit(
          isRepeatingAnimation: false,
          totalRepeatCount: 1,
          animatedTexts: [
            TyperAnimatedText(
              'Flutter パッケージ 100days',
              textStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'ZenMaruGothic',
                color: Color(0xFFCE7DA5),
              ),
              speed: const Duration(milliseconds: 60),
            ),
          ],
        ),
      ),
      body: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: MasonryGridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final randomHeight = 200.0 + Random().nextInt(60);
              return GestureDetector(
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
                  height: randomHeight,
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
                ).animate().fadeIn(
                  duration: 600.ms,
                  delay: (index * 100).ms,
                ).moveY(
                  begin: 30,
                  end: 0,
                  curve: Curves.easeOut,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
