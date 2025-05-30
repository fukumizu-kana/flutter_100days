import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class Day21 extends StatefulWidget {
  const Day21({super.key});

  @override
  State<Day21> createState() => _Day21State();
}

class _Day21State extends State<Day21> {
  List<Post> posts = [];

  final _users = [
    {'name': 'みかっち', 'handle': 'mikacchi'},
    {'name': 'アップル', 'handle': 'apple'},
    {'name': 'リリアン', 'handle': 'lillian'},
    {'name': 'ちゃちゃまる', 'handle': 'chacha'},
    {'name': 'モニカ', 'handle': 'monica'},
    {'name': 'アセロラ', 'handle': 'acerola'},
    {'name': 'フランソワ', 'handle': 'francoise'},
    {'name': 'パッチ', 'handle': 'patchy'},
    {'name': 'クリスチーヌ', 'handle': 'chris'},
    {'name': 'サラ', 'handle': 'sara'},
  ];

  final _messages = [
    'ねぇ、今日ってなんだか、すっごくイイ日になりそうな気がしない？',
    'おそろいの服って、テンション上がっちゃうよね〜っ！',
    'ヒマすぎて、ハンモックで寝返り100回してた〜っ！',
    'お菓子のこと考えてたら、ほっぺが落ちそうだったよぉ〜！',
    '今日の空ってなんかおいしそうじゃない！？',
    '筋肉痛って、努力の勲章だよねっ♪',
    '部屋の模様替えしたらテンションMAX〜！見てほしいよぉ！',
    '夢の中でタピオカまみれになってたんだよね…飲みすぎた？',
    '毎日が文化祭みたいだったらいいのに〜っ！',
    '早起きしたらラジオ体操してみたくならない？なんかさ！',
  ];

  @override
  void initState() {
    super.initState();
    final random = Random();
    posts = List.generate(10, (_) {
      final index = random.nextInt(_users.length);
      final user = _users[index];
      final message = _messages[random.nextInt(_messages.length)];
      return Post(
        username: user['name']!,
        handle: user['handle']!,
        content: message,
        timestamp: DateTime.now(),
      );
    });
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(milliseconds: 800));
    final index = Random().nextInt(_users.length);
    final user = _users[index];
    final message = _messages[Random().nextInt(_messages.length)];
    setState(() {
      posts.insert(
        0,
        Post(
          username: user['name']!,
          handle: user['handle']!,
          content: message,
          timestamp: DateTime.now(),
        ),
      );
    });
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE6),
      appBar: AppBar(
        title: const Text('liquid_pull_to_refresh'),
        backgroundColor: const Color(0xFFA8D5BA),
        elevation: 0,
      ),
      body: LiquidPullToRefresh(
        onRefresh: _refresh,
        color: const Color(0xFFA8D5BA),
        backgroundColor: Colors.white,
        showChildOpacityTransition: false,
        height: 100,
        animSpeedFactor: 2.0,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return Card(
              color: const Color(0xFFFDFCF3),
              margin: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFF9CCC65),
                  child: Text(
                    post.username.characters.first,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  '${post.username}  @${post.handle}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D473A),
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),
                    Text(
                      post.content,
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DateFormat('yyyy/MM/dd HH:mm').format(post.timestamp),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
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

class Post {
  final String username;
  final String handle;
  final String content;
  final DateTime timestamp;

  Post({
    required this.username,
    required this.handle,
    required this.content,
    required this.timestamp,
  });
}
