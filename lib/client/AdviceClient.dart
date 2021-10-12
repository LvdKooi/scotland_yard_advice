import 'dart:convert';

import 'package:http/http.dart' as http;

import '../dto/ErrorDto.dart';
import '../dto/Move.dart';


Future<List<int>> getAdvice(int startingPoint, List<Move> moves) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:8080/rest/advice?startingPoint=' +
        startingPoint.toString()),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(toJson(moves)),
  );
  if (response.statusCode == 200) {
    var body = response.body;
    var adviceList = <int>[];

    body.replaceAll("[", "").replaceAll("]", "").split(",").forEach((element) {
      adviceList.add(int.parse(element));
    });

    return adviceList;
  } else if (response.statusCode >= 400) {
    var error = ErrorDto.fromJson(jsonDecode(response.body));
    throw Exception(error.reason);
  } else {
    throw Exception(response.body);
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
