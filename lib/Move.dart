import 'package:scotland_yard_advice/MeansOfTransportation.dart';

class Move {
  final MeansOfTransportation meansOfTransportation;
  final Set<int> playerLocations;

  Move(this.meansOfTransportation, this.playerLocations);
}
