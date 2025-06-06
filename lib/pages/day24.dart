import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Day24 extends StatefulWidget {
  const Day24({super.key});

  @override
  State<Day24> createState() => _Day24State();
}

class _Day24State extends State<Day24> {
  final List<_StructuredItem> items = [
    const _StructuredItem(
      time: '17:30',
      icon: Icons.directions_walk,
      color: Colors.pinkAccent,
      title: '本屋に行く',
      detail: '午後5時30分〜6時00分（30分）',
    ),
    const _StructuredItem(
      time: '18:00',
      icon: Icons.computer,
      color: Colors.pinkAccent,
      title: 'プログラミング',
      detail: '午後6時00分〜6時30分（30分）',
    ),
    const _StructuredItem(
      time: '18:30',
      icon: Icons.laptop_mac,
      color: Colors.brown,
      title: 'Udemy',
      detail: '残り2分',
    ),
  ];

  final Set<int> checkedIndices = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'timeline_tile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        removeTop: true,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 32),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            final isChecked = checkedIndices.contains(index);

            return TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.2,
              isFirst: index == 0,
              isLast: index == items.length - 1,
              indicatorStyle: IndicatorStyle(
                width: 60,
                height: 40,
                indicator: Container(
                  decoration: BoxDecoration(
                    color: item.color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Icon(item.icon, color: Colors.white),
                ),
              ),
              beforeLineStyle: const LineStyle(color: Colors.white24, thickness: 2),
              afterLineStyle: const LineStyle(color: Colors.white24, thickness: 2),
              endChild: Container(
                margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.detail,
                      style: TextStyle(
                        color: isChecked ? Colors.white : Colors.white70,
                        fontSize: 13,
                        decoration: isChecked ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: isChecked ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: isChecked,
                        activeColor: item.color,
                        checkColor: Colors.white,
                        onChanged: (_) {
                          setState(() {
                            if (isChecked) {
                              checkedIndices.remove(index);
                            } else {
                              checkedIndices.add(index);
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _StructuredItem {
  final String time;
  final IconData icon;
  final Color color;
  final String title;
  final String detail;

  const _StructuredItem({
    required this.time,
    required this.icon,
    required this.color,
    required this.title,
    required this.detail,
  });
}
