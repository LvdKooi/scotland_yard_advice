import 'dart:collection';

import 'package:scotland_yard_advice/service/Node.dart';

import '../Dto/MeansOfTransportation.dart';
import '../dto/Move.dart';
import '../exception/WrongInputException.dart';
import 'NodeService.dart';

class AdviceService {
  final NodeService nodeService;

  AdviceService(this.nodeService);

  Future<List<int>> getPossibleLocations(
      int startingPositions, List<Move> moves) async {
    List<int> currentIds = [];

    Set<Node> currentNodes = HashSet<Node>();
    currentNodes.add(nodeService.getNode(startingPositions));

    for (var move in moves) {
      currentNodes = getPossibleNodesFromCurrentState(
          currentNodes, move.meansOfTransportation);

      currentNodes.removeWhere((element) {
        return move.playerLocations.contains(element.id);
      });
    }

    currentNodes.forEach((element) {
      currentIds.add(element.id);
    });

    return currentIds;
  }

  Set<Node> getPossibleNodesFromCurrentState(
      Set<Node> currentNodes, MeansOfTransportation transportation) {
    var nodesSet = HashSet<Node>();

    currentNodes.forEach((node) {
      getListOfNodeIdsByMeansOfTransportation(node, transportation)
          .forEach((element) {
        nodesSet.add(nodeService.getNode(element));
      });
    });

    if (nodesSet.isEmpty) {
      var transportationName = transportation.name;
      throw WrongInputException(
          "Mr. X made an illegal move: $transportationName is not an option considering the possible nodes he passed by.");
    }
    return nodesSet;
  }

  List<int> getListOfNodeIdsByMeansOfTransportation(
      Node node, MeansOfTransportation transportation) {
    switch (transportation) {
      case MeansOfTransportation.TAXI:
        return node.taxi;
      case MeansOfTransportation.BUS:
        return node.bus;
      case MeansOfTransportation.UNDERGROUND:
        return node.underground;
      case MeansOfTransportation.UNKNOWN:
        return [node.ferry, node.bus, node.taxi, node.underground]
            .expand((x) => x)
            .toList();
      default:
        return [];
    }
  }
}
