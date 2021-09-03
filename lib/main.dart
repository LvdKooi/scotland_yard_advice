import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Scotland Yard Advice';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const Center(
          child: MyStatefulWidget(),
        ),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _index = 0;
  int _max_steps = 4;

  @override
  Widget build(BuildContext context) {
    print(_index);
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
          title: const Text('Step 1 title'),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const Text('Content for Step 1')),
        ),
        Step(
          title: Text('Step 2 title'),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const Text('Content for Step 2')),
        ),
        Step(
          title: Text('Step 3 title'),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const Text('Content for Step 3')),
        ),
        Step(
          title: Text('Step 4 title'),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const Text('Content for Step 4')),
        ),
        Step(
          title: Text('Step 5 title'),
          content: Container(
              alignment: Alignment.centerLeft,
              child: const Text('Content for Step 5')),
        ),
      ],
    );
  }
}
