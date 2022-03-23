import 'dart:async';

import 'package:eve_core/src/utils/lock.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const attempts = 100;
  late var i = 0;
  late Completer completer;
  late Lock lock;

  Future<int> slowIncrement() async {
    final i0 = i;
    await completer.future;
    i = i0 + 1;
    return i;
  }

  void failSlow() async {
    await completer.future;
    throw 'failed';
  }

  int failFast() {
    throw 'failed';
  }

  int fastIncrement() {
    final i0 = i;
    i = i0 + 1;
    return i;
  }

  setUp(() {
    i = 0;
    completer = Completer();
    lock = Lock();
  });

  test('Without synchronized(), all incrementers run concurrently', () async {
    final futures = List.generate(attempts, (i) => slowIncrement());
    expect(i, equals(0));
    completer.complete();
    await Future.wait(futures);
    expect(i, equals(1));
  });

  test('With synchronized(), all incrementers run sequentially', () async {
    final futures = List<Future<int>>.generate(
        attempts, (i) => lock.synchronized<int>(slowIncrement));
    expect(i, equals(0));
    completer.complete();
    final results = await Future.wait<int>(futures);
    expect(i, equals(attempts));
    expect(results, equals(List.generate(attempts, (i) => i + 1).toList()));
  });

  test('Non-async functions work correctly with synchronized()', () async {
    final futures =
        List.generate(attempts, (i) => lock.synchronized<int>(fastIncrement));
    final results = await Future.wait<int>(futures);
    expect(i, equals(attempts));
    expect(results, equals(List.generate(attempts, (i) => i + 1).toList()));
  });

  test('Exceptions are propagated', () async {
    expect(i, equals(0));
    final future1 = lock.synchronized(failSlow);
    final future2 = lock.synchronized(slowIncrement);
    final future3 = lock.synchronized(failFast);
    completer.complete();
    expect(future1, throwsA(equals('failed')));
    expect(future2, completion(equals(1)));
    expect(future3, throwsA(equals('failed')));
  });
}
