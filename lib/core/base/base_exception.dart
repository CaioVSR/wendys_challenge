abstract class BaseException implements Exception {
  const BaseException(this.message);

  final String message;
}

abstract class Failure extends BaseException {
  const Failure(super.message);
}
