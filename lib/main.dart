import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'AdviceClient.dart';
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
  var _moves = <Move>[];
  late Future<List<int>> _currentAdvice;

  void _setStartingPoint(String position) {
    setState(() {
      _startingPoint = int.parse(position);
    });
  }

  void _addMove(int index, Move move) {
    if (_moves.isEmpty || _moves.length - 1 < index) {
      _moves.add(move);
    } else {
      _moves[index] = move;
    }

    _fetchAdvice();
  }

  void _fetchAdvice()  {
    _currentAdvice = getAdvice(_startingPoint, _moves);
  }

  Future<List<int>> _getAdvice() {
    return _currentAdvice;
  }

  void _resetState() {
    setState(() {
      _startingPoint = 0;
      _moves.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_title),
          actions: [
            IconButton(
                onPressed: () => _resetState(), icon: Icon(Icons.refresh))
          ],
        ),
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
                        submitFunction: _addMove,
                        resetFunction: _resetState,
                        getAdviceFunction: _getAdvice,
                      )
                    : null),
          ],
        ),
      ),
    );
  }
}
