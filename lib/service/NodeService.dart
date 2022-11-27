import 'package:scotland_yard_advice/service/Node.dart';
import 'package:scotland_yard_advice/service/NodeHelper.dart';

import '../exception/NotFoundException.dart';

class NodeService {
  Node getNode(int id) {
    var node = NodeHelper.nodes[id];
    if (node == null) {
      throw NotFoundException("Node $id doesn't exist.");
    } else {
      return node;
    }
  }
}
