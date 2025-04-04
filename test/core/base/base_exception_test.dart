import 'package:flutter_test/flutter_test.dart';
import 'package:wendys_challenge/core/base/base_exception.dart';

class MockException extends BaseException {
  const MockException(super.message);
}

class MockFailure extends Failure {
  const MockFailure(super.message);
}

void main() {
  group('BaseException', () {
    const testMessage = 'Test error message';

    test('should store the message passed to constructor', () {
      const exception = MockException(testMessage);
      expect(exception.message, testMessage);
    });

    test('should implement Exception interface', () {
      const exception = MockException(testMessage);
      expect(exception, isA<Exception>());
    });

    test('should be usable in try-catch blocks', () {
      const exception = MockException(testMessage);

      void throwException() {
        throw exception;
      }

      expect(throwException, throwsA(isA<MockException>()));
    });

    test('should include message in toString', () {
      const exception = MockException(testMessage);
      expect(exception.message, contains(testMessage));
    });
  });

  group('Failure', () {
    const testMessage = 'Test failure message';

    test('should extend BaseException', () {
      const failure = MockFailure(testMessage);
      expect(failure, isA<BaseException>());
    });

    test('should store the message passed to constructor', () {
      const failure = MockFailure(testMessage);
      expect(failure.message, testMessage);
    });

    test('should implement Exception interface', () {
      const failure = MockFailure(testMessage);
      expect(failure, isA<Exception>());
    });

    test('should be usable in try-catch blocks', () {
      const failure = MockFailure(testMessage);

      void throwFailure() {
        throw failure;
      }

      expect(throwFailure, throwsA(isA<MockFailure>()));
    });

    test('should allow catching as BaseException', () {
      const failure = MockFailure(testMessage);

      void throwAndCatch() {
        try {
          throw failure;
        } on BaseException catch (e) {
          expect(e.message, testMessage);
        }
      }

      throwAndCatch();
    });
  });
}
