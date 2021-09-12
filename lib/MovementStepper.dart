import 'package:flutter/material.dart';
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
  int _maxSteps = 3;
  final Function submitFunction;
  final Function resetFunction;

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
        }
        else {
          setState(() {
            resetFunction();
          });
        }
      },
      onStepContinue: () {
        setState(() {
          submitFunction(_index);
          if (_index != _maxSteps) {
            _index += 1;
          }
        });
      },
      steps: getSteps(),
    );
  }

  List<Step> getSteps() {
    var steps = <Step>[];
    for (var i = 0; i <= _maxSteps; i++) {
      steps.add(Step(
        title: Text('Movement ' + (i + 1).toString()),
        content: Container(
            alignment: Alignment.centerLeft,
            child: StepInput(submitFunction: printMeans)),
      ));
    }
    return steps;
  }

  void printMeans(MeansOfTransportation means) {
    print(means.name);
    print('from index ' + _index.toString());
  }
}
