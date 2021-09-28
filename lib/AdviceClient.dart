import 'dart:convert';

import 'package:http/http.dart' as http;

import 'Move.dart';

void getAdvice(int startingPoint, List<Move> moves) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:8080/rest/advice?startingPoint=' +
        startingPoint.toString()),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(toJson(moves)),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print("Succesvol teruggekomen");
    print(response.body);
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    print(response.body);
    throw Exception("HELAAS: " + response.statusCode.toString());
  }
}

List<Map<String, dynamic>> toJson(List<Move> move) {
  List<Map<String, dynamic>> movesList = [];
  move.forEach((element) {
    print(element.toJson());
    movesList.add(element.toJson());
  });

  return movesList;
}
