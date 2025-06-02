import 'package:flutter/material.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Day22 extends StatefulWidget {
  const Day22({super.key});

  @override
  State<Day22> createState() => _Day22State();
}

class _Day22State extends State<Day22> {
  final zodiacIcons = {
    'ねずみ': '🐭',
    'うし': '🐮',
    'とら': '🐯',
    'うさぎ': '🐰',
    'たつ': '🐉',
    'へび': '🐍',
    'うま': '🐴',
    'ひつじ': '🐑',
    'さる': '🐵',
    'とり': '🐔',
    'いぬ': '🐶',
    'いのしし': '🐗',
  };

  final List<String> luckyItems = [
    'カップケーキ',
    'カフェラテ',
    '虹色ボールペン',
    'お気に入りの本',
    'お花のハンカチ',
    'ゆったりソファ',
    'イヤホン',
    'ぬいぐるみ',
    'アロマキャンドル',
    'ミントのガム',
    '小さな鏡',
    'ストラップ付きボトル',
  ];

  late List<Map<String, String>> ranking;

  @override
  void initState() {
    super.initState();
    ranking = List.generate(zodiacIcons.length, (i) {
      final name = zodiacIcons.keys.elementAt(i);
      return {
        'name': name,
        'icon': zodiacIcons[name]!,
        'item': luckyItems[i],
      };
    })..shuffle();
  }

  void _showDetails(String zodiacName, String item) {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$zodiacName座のあなた', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text('今日のラッキーアイテムは「$item」です！'),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('auto_animated'),
        backgroundColor: const Color(0xFFF6B3C5),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF6F0), Color(0xFFFFEBEF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LiveList.options(
            options: const LiveOptions(
              delay: Duration(milliseconds: 300),
              showItemInterval: Duration(milliseconds: 100),
              showItemDuration: Duration(milliseconds: 500),
              visibleFraction: 0.05,
            ),
            itemCount: ranking.length,
            itemBuilder: (context, index, animation) {
              final data = ranking[index];
              final name = data['name']!;
              final icon = data['icon']!;
              final item = data['item']!;

              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.3),
                    end: Offset.zero,
                  ).animate(animation),
                  child: Bounceable(
                    onTap: () => _showDetails(name, item),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      color: const Color(0xFFFFF9FB),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.pinkAccent.shade100,
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          '$icon $name座のあなた',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF5D3A58),
                          ),
                        ),
                        subtitle: Text(
                          'ラッキーアイテム：$item',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF8D6E8A),
                          ),
                        ),
                      ),
                    ).animate().fadeIn(duration: 400.ms).scale(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
