import 'package:flutter/material.dart';

class MovementStepper extends StatefulWidget {
  final Function submitFunction;

  const MovementStepper({Key? key, required this.submitFunction})
      : super(key: key);

  @override
  _MovementStepperState createState() => _MovementStepperState(submitFunction);
}

class _MovementStepperState extends State<MovementStepper> {
  int _index = 0;
  int _maxSteps = 4;
  final Function submitFunction;

  _MovementStepperState(this.submitFunction);

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
            child: Text('Content for Step ' + (i + 1).toString())),
      ));
    }
    return steps;
  }
}
