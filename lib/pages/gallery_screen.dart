import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:page_transition/page_transition.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '/pages/day01.dart';
import '/pages/day05.dart';
import '/pages/day06.dart';
import '/pages/day07.dart';
import '/pages/day08.dart';
import '/pages/day09.dart';
import '/pages/day11.dart';
import '/pages/day16.dart';
import '/pages/day17.dart';
import '/pages/day19.dart';
import '/pages/day20.dart';
import '/pages/day21.dart';
import '/pages/day22.dart';
import '/widgets/category_filter_sheet.dart';
import '/providers/theme_mode_provider.dart';

class GalleryScreen extends ConsumerStatefulWidget {
  const GalleryScreen({super.key});

  @override
  ConsumerState<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends ConsumerState<GalleryScreen> {
  final List<Map<String, dynamic>> allItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
        allItems.addAll([
          {
            'title': 'flutter_animate\nanimated_text_kit',
            'image': 'images/omikuji_app.png',
            'screen': const Day01(),
            'category': 'UI',
          },
          {
            'title': 'concentric_transition',
            'image': 'images/day05_app.png',
            'screen': const Day05(),
            'category': 'UX',
          },
          {
            'title': 'animated_flip_counter',
            'image': 'images/day06_app.png',
            'screen': const Day06(),
            'category': 'UI',
          },
          {
            'title': 'smooth_page_indicator',
            'image': 'images/day07_app.png',
            'screen': const Day07(),
            'category': 'UX',
          },
          {
            'title': 'flutter_spinkit',
            'image': 'images/day08_app.png',
            'screen': const Day08(),
            'category': 'UI',
          },
          {
            'title': 'flutter_chat_ui\nflutter_chat_types',
            'image': 'images/day09_app.png',
            'screen': const Day09(),
            'category': 'UX',
          },
          {
            'title': 'fl_chart',
            'image': 'images/day11_app.png',
            'screen': const Day11(),
            'category': 'UI',
          },
          {
            'title': 'awesome_snackbar_content',
            'image': 'images/day16_app.png',
            'screen': const Day16(),
            'category': 'UX',
          },
          {
            'title': 'syncfusion_flutter_charts',
            'image': 'images/day17_app.png',
            'screen': const Day17(),
            'category': 'UI',
          },
          {
            'title': 'flutter_confetti',
            'image': 'images/day19_app.png',
            'screen': const Day19(),
            'category': 'UX',
          },
          {
            'title': 'circular_countdown_timer',
            'image': 'images/day20_app.png',
            'screen': const Day20(),
            'category': 'UX',
          },
          {
            'title': 'liquid_pull_to_refresh',
            'image': 'images/day21_app.png',
            'screen': const Day21(),
            'category': 'UX',
          },
          {
            'title': 'auto_animated',
            'image': 'images/day22_app.png',
            'screen': const Day22(),
            'category': 'UI',
          },
        ]);
      });
    });
  }

  String? selectedCategory;

  List<Map<String, dynamic>> get filteredItems {
    if (selectedCategory == null) return allItems;
    return allItems.where((item) => item['category'] == selectedCategory).toList();
  }

  void _showFilterSheet() async {
    final selected = await showCupertinoModalBottomSheet<String?>(
      context: context,
      topRadius: const Radius.circular(16),
      builder: (context) => CategoryFilterSheet(current: selectedCategory),
    );
    if (selected != null || selectedCategory != null) {
      setState(() {
        selectedCategory = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DraggableHome(
      title: Text(
        'Flutter パッケージ 100days',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'ZenMaruGothic',
          color: colorScheme.onSurface,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.filter_alt, color: colorScheme.primary),
        onPressed: _showFilterSheet,
      ),
      actions: [
        IconButton(
          icon: Icon(
            isDark ? Icons.lightbulb : Icons.lightbulb_outline,
            color: colorScheme.primary,
          ),
          onPressed: () {
            ref.read(themeModeProvider.notifier).toggleMode();
          },
        ),
      ],
      appBarColor: Theme.of(context).appBarTheme.backgroundColor,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      headerWidget: Container(
        height: 140,
        width: double.infinity,
        padding: const EdgeInsets.only(top: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.surface,
              colorScheme.background,
            ],
          ),
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(32),
          ),
        ),
        child: AnimatedTextKit(
          isRepeatingAnimation: false,
          totalRepeatCount: 1,
          animatedTexts: [
            TyperAnimatedText(
              'Flutter パッケージ 100days',
              textStyle: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'ZenMaruGothic',
                color: isDark ? Colors.white : colorScheme.onSurface,
              ),
              speed: const Duration(milliseconds: 60),
            ),
          ],
        ),
      ),
      body: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: isLoading
              ? MasonryGridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: AspectRatio(
                        aspectRatio: 2 / 3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : MasonryGridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    return Bounceable(
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
                      child: AspectRatio(
                        aspectRatio: 2 / 3,
                        child: ClayContainer(
                          borderRadius: 20,
                          color: isDark ? const Color(0xFF3A3A3C) : colorScheme.surface,
                          depth: isDark ? 20 : 40,
                          spread: isDark ? 4 : 6,
                          curveType: isDark ? CurveType.concave : CurveType.convex,
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
                                          Colors.black.withOpacity(0.4),
                                          Colors.black.withOpacity(0.85),
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
                        ),
                      ),
                    ).animate().fadeIn(
                      duration: 600.ms,
                      delay: (index * 100).ms,
                    ).moveY(
                      begin: 30,
                      end: 0,
                      curve: Curves.easeOut,
                    );
                  },
                ),
        ),
      ],
    );
  }
}
