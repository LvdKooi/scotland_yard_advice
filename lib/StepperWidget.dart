import 'package:flutter/material.dart';

import 'MovementStepperStateless.dart';

class StepperWidget extends StatelessWidget {
  final List<Step> steps;
  final Function submitFunction;
  final int index;

  const StepperWidget(
      {Key? key,
      required this.steps,
      required this.submitFunction,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: index > -1
            ? MovementStepperStateless(
                steps: steps, submitFunction: submitFunction, index: index)
            : null);
  }
}
