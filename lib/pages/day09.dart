import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class Day09 extends StatefulWidget {
  const Day09({super.key});

  @override
  State<Day09> createState() => _Day09State();
}

class _Day09State extends State<Day09> {
  final types.User _myUser = const types.User(id: 'user-1');
  final types.User _otherUser = const types.User(id: 'bot-1', firstName: 'チャットくん');

  final List<types.Message> _messages = [];

  @override
  void initState() {
    super.initState();

    final welcome = types.TextMessage(
      author: _otherUser,
      createdAt: DateTime.now().millisecondsSinceEpoch - 2000,
      id: 'msg-1',
      text: 'チャット画面を作ってみたよ！',
    );

    _messages.insert(0, welcome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      appBar: AppBar(
        title: const Text(
          'flutter_chat_ui\nflutter_chat_types',
          style: TextStyle(fontFamily: 'ZenMaruGothic', color: Colors.black87),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Chat(
        messages: _messages,
        user: _myUser,
        onSendPressed: (types.PartialText message) {
          final textMessage = types.TextMessage(
            author: _myUser,
            createdAt: DateTime.now().millisecondsSinceEpoch,
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            text: message.text,
          );

          setState(() {
            _messages.insert(0, textMessage);
          });
        },
        theme: const DefaultChatTheme(
          backgroundColor: Color(0xFFE5E5E5),
          primaryColor: Color(0xFFDCF8C6),
          secondaryColor: Colors.white,
          inputBackgroundColor: Colors.white,
          inputTextColor: Colors.black87,
          inputBorderRadius: BorderRadius.all(Radius.circular(24)),
          sentMessageBodyTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 14,
          ),
          receivedMessageBodyTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
