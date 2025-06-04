import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';

class Day23 extends StatefulWidget {
  const Day23({super.key});

  @override
  State<Day23> createState() => _Day23State();
}

class _Day23State extends State<Day23> with TickerProviderStateMixin {
  String _season = '春';

  ParticleOptions getParticleOptions() {
    switch (_season) {
      case '夏':
        return const ParticleOptions(
          baseColor: Colors.lightBlueAccent,
          spawnMinSpeed: 10,
          spawnMaxSpeed: 20,
          spawnMinRadius: 3,
          spawnMaxRadius: 6,
          particleCount: 80,
        );
      case '秋':
        return const ParticleOptions(
          baseColor: Colors.orangeAccent,
          spawnMinSpeed: 5,
          spawnMaxSpeed: 10,
          spawnMinRadius: 4,
          spawnMaxRadius: 7,
          particleCount: 70,
        );
      case '冬':
        return const ParticleOptions(
          baseColor: Colors.blueGrey,
          spawnMinSpeed: 2,
          spawnMaxSpeed: 6,
          spawnMinRadius: 3,
          spawnMaxRadius: 6,
          particleCount: 100,
        );
      case '春':
      default:
        return const ParticleOptions(
          baseColor: Colors.pinkAccent,
          spawnMinSpeed: 5,
          spawnMaxSpeed: 10,
          spawnMinRadius: 4,
          spawnMaxRadius: 8,
          particleCount: 100,
          minOpacity: 0.3,
          maxOpacity: 0.8,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('animated_background'),
        backgroundColor: Colors.pink[100],
        elevation: 0,
      ),
      body: AnimatedBackground(
        vsync: this,
        behaviour: RandomParticleBehaviour(options: getParticleOptions()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _season,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ['春', '夏', '秋', '冬'].map((s) {
                final bool isSelected = _season == s;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _season = s;
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      side: BorderSide(
                        color: isSelected ? Colors.pinkAccent : Colors.grey.shade300,
                      ),
                      backgroundColor: isSelected ? Colors.pink[50] : Colors.grey.shade100,
                      foregroundColor: Colors.pink,
                    ),
                    child: Text(s),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
