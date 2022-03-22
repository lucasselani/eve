class Failure {
  final String message;
  final int code;
  final FailureType type;

  Failure({
    required this.message,
    this.code = 0,
    this.type = FailureType.generic,
  });
}

enum FailureType {
  generic,
}
