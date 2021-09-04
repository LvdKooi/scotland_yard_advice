import 'package:flutter/material.dart';

class MovementStepper extends StatefulWidget {

  const MovementStepper({Key? key}) : super(key: key);

  @override
  _MovementStepperState createState() => _MovementStepperState();
}

class _MovementStepperState extends State<MovementStepper> {

  int _index = 0;
  int _max_steps = 4;

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
          if (_index != _max_steps) {
            _index += 1;
          }
        });
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
        });
      },
      steps: <Step>[
        Step(
          title: const Text('Movement 1'),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const Text('Content for Step 1')),
        ),
        Step(
          title: Text('Movement 2'),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const Text('Content for Step 2')),
        ),
        Step(
          title: Text('Movement 3'),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const Text('Content for Step 3')),
        ),
        Step(
          title: Text('Movement 4'),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const Text('Content for Step 4')),
        ),
        Step(
          title: Text('Movement 5'),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const Text('Content for Step 5')),
        ),
      ],
    );
  }
}