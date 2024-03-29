import 'package:flutter/material.dart';
import 'package:scotland_yard_advice/Dto/MeansOfTransportation.dart';

class StepInput extends StatefulWidget {
  final Function submitFunction;

  const StepInput({Key? key, required this.submitFunction}) : super(key: key);

  @override
  _StepInputState createState() => _StepInputState(submitFunction);
}

class _StepInputState extends State<StepInput> {
  final Function submitFunction;
  MeansOfTransportation? _means = MeansOfTransportation.TAXI;

  _StepInputState(this.submitFunction);

  @override
  Widget build(BuildContext context) {
    return Column(children: _getListTiles());
  }

  _getListTiles() {
    var listTiles = <Widget>[];

    MeansOfTransportation.values.forEach((element) {
      listTiles.add(ListTile(
          title: Text(element.name),
          visualDensity: VisualDensity.compact,
          leading: Radio<MeansOfTransportation>(
            activeColor: Colors.green,
            value: element,
            groupValue: _means,
            onChanged: (MeansOfTransportation? value) {
              setState(() {
                _means = value;
                submitFunction(value);
              });
            },
          )));
    });

    return listTiles;
  }
}
