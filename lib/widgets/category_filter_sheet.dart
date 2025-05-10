import 'package:flutter/material.dart';

class CategoryFilterSheet extends StatelessWidget {
  final String? current;

  const CategoryFilterSheet({super.key, required this.current});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFFFF0F7),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'カテゴリで絞り込み',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8B3A62),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: ['UI', 'UX'].map((cat) {
                final isSelected = current == cat;
                return ChoiceChip(
                  label: Text(cat),
                  selectedColor: const Color(0xFFFEE3F0),
                  selected: isSelected,
                  onSelected: (_) {
                    Navigator.of(context).pop(cat);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(null);
              },
              child: const Text(
                'すべて表示',
                style: TextStyle(color: Color(0xFF8B3A62)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
