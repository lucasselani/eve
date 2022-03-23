import 'dart:async';

import 'package:eve_core/src/utils/event_bus.dart';
import 'package:flutter_test/flutter_test.dart';

class _Test {}

void main() {
  final instance = _Test();
  var numberOfEvents = 0;
  StreamSubscription? sub;

  void listenAndSend<T extends Object>(T? eventSent) {
    sub?.cancel();
    sub = null;
    numberOfEvents = 0;
    sub = EventBus().on<T>().listen((event) {
      if (eventSent != null) {
        expect(event, equals(eventSent));
      }
      numberOfEvents++;
    });
    EventBus().send('test');
    EventBus().send(1);
    EventBus().send(instance);
  }

  test('Should only listen to String type when String type is given', () async {
    listenAndSend<String>('test');
    await Future.delayed(const Duration(seconds: 1));
    expect(numberOfEvents, 1);
  });

  test('Should only listen to Object type when Object type is given', () async {
    listenAndSend<_Test>(instance);
    await Future.delayed(const Duration(seconds: 1));
    expect(numberOfEvents, 1);
  });
}
