import 'package:scotland_yard_advice/service/Node.dart';
import 'package:scotland_yard_advice/service/NodeHelper.dart';

import '../exception/NotFoundException.dart';

Node? getNode(int id) {
  if (!NodeHelper.nodes.containsKey(id)) {
    throw NotFoundException("Node $id doesn't exist.");
  }
  return NodeHelper.nodes[id];
}
