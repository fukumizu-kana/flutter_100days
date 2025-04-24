import 'package:flutter/material.dart';
import '/pages/gallery_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return const MaterialApp(
      title: 'Flutter 100Days',
      debugShowCheckedModeBanner: false,
      home: GalleryScreen(),
    );
  }
}
