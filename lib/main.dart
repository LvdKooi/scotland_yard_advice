import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Move.dart';
import 'MovementStepper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  static const String _title = 'Scotland Yard Advice';
  var _startingPoint = 0;
  var moves = <Move>{};
  var currentAdvice = <int>{};

  void _setStartingPoint(String position) {
    setState(() {
      _startingPoint = int.parse(position);
    });
  }

  void _addMove(Move move) {
    moves.add(move);
  }

  void _fetchAdvice() {
    setState(() {
      print('Advice');
    });
  }

  void _reset() {
    setState(() {
      _startingPoint = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: Column(
          children: [
            Center(
                child: _startingPoint == 0
                    ? new TextField(
                        decoration: new InputDecoration(
                            labelText: "Last known position of Mr. X."),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onSubmitted: _setStartingPoint)
                    : null),
            Center(
                child: _startingPoint != 0
                    ? MovementStepper(
                        submitFunction: _fetchAdvice,
                      )
                    : null),
            Center(
                child: _startingPoint != 0
                    ? TextButton(
                        onPressed: () => _reset(), child: Text('Restart'))
                    : null)
          ],
        ),
      ),
    );
  }
}
