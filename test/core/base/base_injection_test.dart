import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:wendys_challenge/core/base/base_injection.dart';

class MockInjection extends BaseInjection {
  MockInjection({required super.scopeName, required super.registrations});
}

class MockService {
  MockService(this.value);
  final String value;
}

void main() {
  late MockInjection testInjection;
  final testRegistrations = <void Function(GetIt)>[];
  final getIt = GetIt.instance;

  var registrationCalled = false;

  setUp(() {
    registrationCalled = false;

    testRegistrations
      ..clear()
      ..add((GetIt i) {
        registrationCalled = true;
        i.registerSingleton<MockService>(MockService('test-value'));
      });

    testInjection = MockInjection(
      scopeName: 'test-scope',
      registrations: testRegistrations,
    );
  });

  tearDown(() async {
    await GetIt.instance.reset();
  });

  group('BaseInjection', () {
    test('should have the correct scope name', () {
      expect(testInjection.scopeName, 'test-scope');
    });

    test('should hold registration functions', () {
      expect(testInjection.registrations, testRegistrations);
    });

    test('injector should reference GetIt.I', () {
      expect(testInjection.injector, GetIt.I);
    });

    test('setUp should create a new scope and call registrations', () async {
      await testInjection.setUp();

      expect(registrationCalled, isTrue);
      expect(getIt.currentScopeName, 'test-scope');
      expect(getIt<MockService>().value, 'test-value');
    });

    test('tearDown should remove the current scope', () async {
      await testInjection.setUp();
      expect(getIt.currentScopeName, 'test-scope');

      await testInjection.tearDown();

      expect(() => getIt.get<MockService>(), throwsA(isA<StateError>()));
    });

    test('registrations should be called in order', () async {
      final callOrder = <int>[];

      testRegistrations
        ..clear()
        ..add((i) => callOrder.add(1))
        ..add((i) => callOrder.add(2))
        ..add((i) => callOrder.add(3));

      await testInjection.setUp();

      expect(callOrder, [1, 2, 3]);
    });

    test('should handle multiple registrations of different types', () async {
      testRegistrations
        ..clear()
        ..add((i) => i.registerSingleton<String>('string-value'))
        ..add((i) => i.registerSingleton<int>(42));

      await testInjection.setUp();

      expect(getIt<String>(), 'string-value');
      expect(getIt<int>(), 42);
    });

    test('should throw when trying to tear down without setup', () async {
      expect(() => testInjection.tearDown(), throwsA(isA<StateError>()));
    });
  });
}
