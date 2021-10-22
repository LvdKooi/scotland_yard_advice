import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedbackDialog extends StatelessWidget {

  final Widget title;
  final Widget content;

  FeedbackDialog(this.title, this.content);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: title,
        content: content,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Dismiss'),
          )
        ]);
  }

}