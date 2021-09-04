import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scotland_yard_advice/MovementStepper.dart';

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
  var _lastPosition = 0;

  void _setLastPosition(String position) {
    setState(() {
      _lastPosition = int.parse(position);
      print(_lastPosition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: Column(
          children: [
            Center(
                child: new TextField(
                    decoration: new InputDecoration(
                        labelText: "Last known position of Mr. X."),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onSubmitted: _setLastPosition)),
            Center(child: MovementStepper())
          ],
        ),
      ),
    );
  }
}
