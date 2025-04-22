import 'dart:math';
import 'package:flutter/material.dart';

class FallingLeaf extends StatefulWidget {
  final String imagePath;
  final double startX;
  final Duration delay;

  const FallingLeaf({
    required this.imagePath,
    required this.startX,
    required this.delay,
    super.key,
  });

  @override
  State<FallingLeaf> createState() => _FallingLeafState();
}

class _FallingLeafState extends State<FallingLeaf>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _position;
  late Animation<double> _rotation;
  late double size;
  late double adjustedStartX;

  @override
  void initState() {
    super.initState();

    size = Random().nextDouble() * 100 + 130;

    adjustedStartX = widget.startX;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      setState(() {
        adjustedStartX = min(widget.startX, screenWidth - size);
      });
    });

    final screenHeight = WidgetsBinding.instance.window.physicalSize.height /
        WidgetsBinding.instance.window.devicePixelRatio;

    _position = Tween<double>(
      begin: -size,
      end: screenHeight + size,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    _rotation = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Positioned(
          top: _position.value,
          left: adjustedStartX,
          child: Transform.rotate(
            angle: _rotation.value,
            child: Image.asset(
              widget.imagePath,
              width: size,
              height: size,
            ),
          ),
        );
      },
    );
  }
}
