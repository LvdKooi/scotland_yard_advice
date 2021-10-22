import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scotland_yard_advice/exception/WrongInputException.dart';

import '../dto/ErrorDto.dart';
import '../dto/Move.dart';

Future<List<int>> getAdvice(int startingPoint, List<Move> moves) async {
  final response = await http.post(
    Uri.parse(
        'http://scotland-yard-advice-dev.eu-west-3.elasticbeanstalk.com/rest/advice?startingPoint=' +
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
  } else if (response.statusCode == 400) {
    var error = ErrorDto.fromJson(jsonDecode(response.body));
    throw WrongInputException(error.reason);
  } else {
    throw Exception(response.body);
  }
}

List<Map<String, dynamic>> toJson(List<Move> move) {
  List<Map<String, dynamic>> movesList = [];
  move.forEach((element) {
    movesList.add(element.toJson());
  });

  return movesList;
}
