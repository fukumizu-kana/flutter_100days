import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class Day16 extends StatelessWidget {
  const Day16({super.key});

  void _showSnackBar(BuildContext context, ContentType type) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: _getTitle(type),
        message: _getMessage(type),
        contentType: type,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String _getTitle(ContentType type) {
    switch (type) {
      case ContentType.success:
        return '成功！';
      case ContentType.failure:
        return 'エラー';
      case ContentType.warning:
        return '注意！';
      case ContentType.help:
        return 'ヘルプ';
    }
    return '';
  }

  String _getMessage(ContentType type) {
    switch (type) {
      case ContentType.success:
        return 'ギャラリーに追加されました';
      case ContentType.failure:
        return '保存中に問題が発生しました';
      case ContentType.warning:
        return '入力内容を確認してください';
      case ContentType.help:
        return 'ここでは画像をアップロードできます';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('awesome_snackbar_content')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () => _showSnackBar(context, ContentType.success),
                child: const Text('成功（success）'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => _showSnackBar(context, ContentType.failure),
                child: const Text('エラー（failure）'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => _showSnackBar(context, ContentType.warning),
                child: const Text('警告（warning）'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => _showSnackBar(context, ContentType.help),
                child: const Text('ヘルプ（help）'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
