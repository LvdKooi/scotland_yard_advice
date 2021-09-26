import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scotland_yard_advice/MeansOfTransportation.dart';
import 'package:scotland_yard_advice/StepInput.dart';

import 'Move.dart';

class MovementStepper extends StatefulWidget {
  final Function submitFunction;
  final Function resetFunction;

  const MovementStepper(
      {Key? key, required this.submitFunction, required this.resetFunction})
      : super(key: key);

  @override
  _MovementStepperState createState() =>
      _MovementStepperState(submitFunction, resetFunction);
}

class _MovementStepperState extends State<MovementStepper> {
  int _index = 0;
  static const int _MAX_STEPS = 4;
  static const int _MAX_PLAYERS = 5;

  final Function submitFunction;
  final Function resetFunction;
  var playerPositions = new HashMap<int, int>();
  var move = MeansOfTransportation.TAXI;

  _MovementStepperState(this.submitFunction, this.resetFunction);

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
                  children: getPlayerInputs(),
                )
              ]);
            });
      },
      steps: getSteps(),
    );
  }

  List<Step> getSteps() {
    var steps = <Step>[];
    for (var i = 0; i <= _MAX_STEPS; i++) {
      steps.add(Step(
        title: Text('Movement ' + (i + 1).toString()),
        content: Container(
            alignment: Alignment.topLeft,
            child: StepInput(submitFunction: (move) => {this.move = move})),
      ));
    }
    return steps;
  }

  List<Widget> getPlayerInputs() {
    var tfList = <Widget>[];
    for (var i = 0; i <= _MAX_PLAYERS; i++) {
      tfList.add(new TextField(
          decoration:
              new InputDecoration(labelText: "Player " + (i + 1).toString()),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          cursorWidth: 3,
          onChanged: (value) => addPlayerLocation(i + 1, value)));
    }

    tfList.add(IconButton(
        onPressed: () => {
              setState(() {
                submitFunction(_index, createMove());
                resetUserInputState();
                if (_index != _MAX_STEPS) {
                  _index += 1;
                }
                Navigator.pop(context, 'Lost');
              })
            },
        icon: Icon(Icons.where_to_vote)));
    return tfList;
  }

  void addPlayerLocation(int player, dynamic location) {
    playerPositions[player] = int.parse(location);
    print(playerPositions);
  }

  Move createMove() {
    return Move(move, playerPositions.values.toSet());
  }

  void resetUserInputState() {
    playerPositions.clear();
    move = MeansOfTransportation.TAXI;
  }
}
