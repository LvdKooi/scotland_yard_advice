import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scotland_yard_advice/Dto/MeansOfTransportation.dart';
import 'package:scotland_yard_advice/exception/WrongInputException.dart';
import 'package:scotland_yard_advice/widget/StepInput.dart';

import '../dto/Move.dart';
import 'FeedbackDialog.dart';

class MovementStepper extends StatefulWidget {
  final Function submitFunction;
  final Function resetFunction;
  final Function getAdviceFunction;

  const MovementStepper(
      {Key? key,
      required this.submitFunction,
      required this.resetFunction,
      required this.getAdviceFunction})
      : super(key: key);

  @override
  _MovementStepperState createState() =>
      _MovementStepperState(submitFunction, resetFunction, getAdviceFunction);
}

class _MovementStepperState extends State<MovementStepper> {
  int _index = 0;
  static const int _MAX_STEPS = 4;
  static const int _MAX_PLAYERS = 5;

  final Function submitFunction;
  final Function resetFunction;
  final Function getAdviceFunction;
  var _playerPositions = new HashMap<int, int>();
  var _move = MeansOfTransportation.TAXI;

  _MovementStepperState(
      this.submitFunction, this.resetFunction, this.getAdviceFunction);

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: _index,
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        } else {
          setState(() {
            resetFunction();
          });
        }
      },
      onStepContinue: () {
        showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(title: Text("Player locations"), children: [
                Column(
                  children: _getPlayerInputs(),
                )
              ]);
            });
      },
      steps: _getSteps(),
    );
  }

  List<Step> _getSteps() {
    var steps = <Step>[];
    for (var i = 0; i <= _MAX_STEPS; i++) {
      steps.add(Step(
        title: Text('Movement ' + (i + 1).toString()),
        content: Container(
            alignment: Alignment.topLeft,
            child: StepInput(submitFunction: (move) => {this._move = move})),
      ));
    }
    return steps;
  }

  List<Widget> _getPlayerInputs() {
    var tfList = <Widget>[];
    for (var i = 0; i <= _MAX_PLAYERS; i++) {
      tfList.add(new TextField(
          cursorColor: Colors.white,
          decoration: new InputDecoration(
              labelText: "Player " + (i + 1).toString(),
              labelStyle: TextStyle(color: Colors.grey),
              focusedBorder: UnderlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
                ),
              )),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          cursorWidth: 3,
          onChanged: (value) => _addPlayerLocation(i + 1, value)));
    }

    tfList.add(IconButton(
        onPressed: () => {
              setState(() {
                if (!_isPlayerLocationsDistinct()) {
                  _showMovementDialog(
                      context,
                      "Wrong input",
                      new Text(
                          'There are duplicate entries in the player locations. Please check your input.'));
                } else {
                  submitFunction(_index, _createMove());
                  _resetUserInputState();
                  Navigator.pop(context);
                  _renderAdvice();
                }
              })
            },
        icon: Icon(Icons.check_circle_rounded)));

    return tfList;
  }

  void _addPlayerLocation(int player, dynamic location) {
    if (location.isNotEmpty) {
      var lastAddedNode = int.parse(location);
      if (lastAddedNode > 199) {
        _showMovementDialog(
            context,
            "Wrong input",
            new Text(
                'Invalid position (valid positions are in the range of 1-199).'));
      } else {
        _playerPositions[player] = lastAddedNode;
      }
    }
  }

  Move _createMove() {
    return Move(_move, _playerPositions.values.toSet());
  }

  Future<void> _renderAdvice() async {
    try {
      var currentAdvice = await getAdviceFunction.call();

      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return FeedbackDialog(new Text("Possible locations of Mr. X:"),
                new Text(_formatAdvice(currentAdvice)));
          });
      setState(() {
        if (_index != _MAX_STEPS) {
          _index += 1;
        }
      });
    } on WrongInputException catch (e) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return FeedbackDialog(new Text("Wrong input"), new Text(e.cause));
          });
    } on Exception catch (e) {
      _showMovementDialog(context, "Error",
          new Text(e.toString().replaceAll("Exception: ", "")));
    }
  }

  String _formatAdvice(List<int> adviceList) {
    var output = "";

    adviceList.sort();
    adviceList.forEach((element) {
      output = output + " " + element.toString();
    });
    return output;
  }

  void _resetUserInputState() {
    _playerPositions.clear();
    _move = MeansOfTransportation.TAXI;
  }

  bool _isPlayerLocationsDistinct() {
    var set = new HashSet<int>();
    var isDistinct = true;

    _playerPositions.values.forEach((element) {
      if (set.add(element) == false) {
        isDistinct = false;
      }
    });

    return isDistinct;
  }

  void _showMovementDialog(BuildContext context, String title, Text content) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return FeedbackDialog(new Text(title), content);
        });
  }
}
