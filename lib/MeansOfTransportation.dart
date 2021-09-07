enum MeansOfTransportation {
  TAXI,
  BUS,
  UNDERGROUND,
  FERRY,
  UNKNOWN
}

extension MeansOfTransportationExtension on MeansOfTransportation {

  String get name {
    switch (this) {
      case MeansOfTransportation.BUS:
        return 'Bus';
      case MeansOfTransportation.FERRY:
        return 'Ferry';
      case MeansOfTransportation.TAXI:
        return 'Taxi';
      case MeansOfTransportation.UNDERGROUND:
        return 'Underground';
      case MeansOfTransportation.UNKNOWN:
        return 'Unknown';
    }
  }
}
