enum MeansOfTransportation { TAXI, BUS, UNDERGROUND, UNKNOWN }

extension MeansOfTransportationExtension on MeansOfTransportation {
  String get name {
    switch (this) {
      case MeansOfTransportation.BUS:
        return 'Bus';
      case MeansOfTransportation.TAXI:
        return 'Taxi';
      case MeansOfTransportation.UNDERGROUND:
        return 'Underground';
      case MeansOfTransportation.UNKNOWN:
        return 'Unknown';
    }
  }
}
