
import 'package:scotland_yard_advice/Dto/MeansOfTransportation.dart';

class Move {
  final MeansOfTransportation meansOfTransportation;
  final Set<int> playerLocations;

  Move(this.meansOfTransportation, this.playerLocations);

  Map<String, dynamic> toJson() => {
        'meansOfTransportation': meansOfTransportation.name.toUpperCase(),
        'playerLocations': playerLocations.toList(),
      };
}
