import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import '/pages/gallery_screen.dart';
import '/providers/theme_mode_provider.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: 'Flutter 100Days',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: FlexThemeData.light(
        scheme: FlexScheme.mandyRed,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 10,
        subThemesData: const FlexSubThemesData(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: FlexThemeData.dark(
        colors: const FlexSchemeColor(
          primary: Color(0xFF8B3A62),
          primaryContainer: Color(0xFF1C1C1E),
          secondary: Color(0xFF8B3A62),
          secondaryContainer: Color(0xFF2C2C2E),
        ),
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 10,
        subThemesData: const FlexSubThemesData(),
        appBarStyle: FlexAppBarStyle.background,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const GalleryScreen(),
    );
  }
}
