import 'dart:math';

import 'package:flutter/material.dart';

class MovementStepperStateless extends StatelessWidget {
  final List<Step> steps;
  final Function submitFunction;
  final int index;

  const MovementStepperStateless(
      {Key? key,
      required this.steps,
      required this.submitFunction,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: min(index, steps.length - 1),
      onStepContinue: () => submitFunction(),
      steps: steps,
    );
  }
}
