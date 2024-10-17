import 'package:flutter/material.dart';

class MessageButton extends StatelessWidget {
  const MessageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('message-button'),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('嗨！妳好'),
        ));
      },
      child: const Text('顯示訊息'),
    );
  }
}
