import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'client/AdviceClient.dart';
import 'dto/Move.dart';
import 'widget/MovementStepper.dart';

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
  bool _validate = false;
  late Future<List<int>> _currentAdvice;

  void _setStartingPoint(String position) {
    setState(() {
      if (position.isEmpty || int.parse(position) > 199) {
        _validate = true;
      } else {
        _validate = false;
        _startingPoint = int.parse(position);
      }
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

  void _fetchAdvice() {
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
          body: ListView(children: [
            Column(
              children: [
                Center(
                    child: _startingPoint == 0
                        ? new TextField(
                            decoration: new InputDecoration(
                              labelText: "Last known position of Mr. X.",
                              errorText: _validate
                                  ? 'Invalid position (valid positions are in the range of 1-199).'
                                  : null,
                            ),
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
          ])),
    );
  }
}
