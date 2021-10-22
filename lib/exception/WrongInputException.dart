class WrongInputException implements Exception {
  String cause;

  WrongInputException(this.cause);
}