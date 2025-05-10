import 'package:flutter/material.dart';

class CategoryFilterSheet extends StatefulWidget {
  final String? current;

  const CategoryFilterSheet({super.key, required this.current});

  @override
  State<CategoryFilterSheet> createState() => _CategoryFilterSheetState();
}

class _CategoryFilterSheetState extends State<CategoryFilterSheet> {
  final List<String> categories = ['UI', 'UX'];
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    if (widget.current != null) {
      selectedIndex = categories.indexOf(widget.current!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFFFF0F7),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Text(
                'カテゴリで絞り込み',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8B3A62),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(categories.length, (index) {
                  final isSelected = selectedIndex == index;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        Navigator.of(context).pop(categories[index]);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF8B3A62) : Colors.transparent,
                          border: Border.all(color: const Color(0xFF8B3A62)),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          categories[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : const Color(0xFF8B3A62),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.of(context).pop(null),
                child: const Text(
                  'すべて表示',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF8B3A62),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
