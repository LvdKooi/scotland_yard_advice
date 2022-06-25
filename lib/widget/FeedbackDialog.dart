import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedbackDialog extends StatelessWidget {
  final Widget title;
  final Widget content;
  final Function? function;

  FeedbackDialog(this.title, this.content, {this.function});

  @override
  Widget build(BuildContext context) {
    var defaultFunction = () {
      Navigator.pop(context);
      function?.call();
    };

    return AlertDialog(title: title, content: content, actions: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.green),
        onPressed: defaultFunction,
        child: const Text('Dismiss'),
      )
    ]);
  }
}
