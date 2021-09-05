import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Move.dart';
import 'StepperWidget.dart';

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
  var _index = -1;
  var _steps = <Step>[];
  var _maxSteps = 4;

  void _setStartingPoint(String position) {
    setState(() {
      _startingPoint = int.parse(position);
      _index = 0;
      // _addStep();
      _fillSteps();
    });
  }

  void _addMove(Move move) {
    moves.add(move);
  }

  void _fetchAdvice() {
    setState(() {
      _fillSteps();
      _index += 1;
    });
  }

  void _fillSteps() {
    _steps.clear();
    for (var i = 0; i <= _maxSteps; i++) {
      if (i <= _index) {
        _steps.add(Step(
          title: Text('Movement ' + (i + 1).toString()),
          content: Container(
              alignment: Alignment.centerLeft,
              child: Text('Content for Step ' + (i + 1).toString())),
        ));
      } else {
        _steps.add(Step(
          isActive: false,
          title: Text('Movement ' + (i + 1).toString()),
          content: Container(
              alignment: Alignment.centerLeft,
              child: Text('Content for Step ' + (i + 1).toString())),
        ));
      }
    }
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
                child: new TextField(
                    decoration: new InputDecoration(
                        labelText: "Last known position of Mr. X."),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onSubmitted: _setStartingPoint)),
            StepperWidget(
                steps: _steps, submitFunction: _fetchAdvice, index: _index)
          ],
        ),
      ),
    );
  }

  void _addStep() {
    _steps.add(Step(
        title: Text('Movement ' + (_index + 1).toString()),
        content: Container(
            alignment: Alignment.centerLeft,
            child: Text('Content for Step ' + (_index + 1).toString()))));
  }
}
