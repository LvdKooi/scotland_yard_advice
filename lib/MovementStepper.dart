import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scotland_yard_advice/MeansOfTransportation.dart';
import 'package:scotland_yard_advice/StepInput.dart';

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
  var moveMap = new Map();
  var playerPositions = new HashMap<int, int>();

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
            child: StepInput(submitFunction: printMeans)),
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
                var positions = playerPositions.values;
                print(positions);
                playerPositions.clear();
                submitFunction(_index);
                if (_index != _MAX_STEPS) {
                  _index += 1;
                }
                Navigator.pop(context, 'Lost');
              })
            },
        icon: Icon(Icons.where_to_vote)));
    return tfList;
  }

  void printMeans(MeansOfTransportation means) {
    print(means.name);
    print('from index ' + _index.toString());
  }

  void addPlayerLocation(int player, dynamic location) {
    print('adding ' + location);
    playerPositions[player] = int.parse(location);
  }
}
