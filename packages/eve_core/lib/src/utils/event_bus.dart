import 'dart:async';

/// Dispatches events to listeners using the Dart [Stream] API. The [EventBus]
/// enables decoupled applications. It allows objects to interact without
/// requiring to explicitly define listeners and keeping track of them.
///
/// Not all events should be broadcasted through the [EventBus] but only those of
/// general interest.
///
/// Events are normal Dart objects. By specifying a class, listeners can
/// filter events.
///

class EventBus {
  static final EventBus _instance = EventBus._();

  final StreamController _streamController;

  /// Creates an [Invoker].
  ///
  /// If [sync] is true, events are passed directly to the stream's listeners
  /// during a [cast] call. If false (the default), the event will be passed to
  /// the listeners at a later time, after the code creating the event has
  /// completed.
  EventBus._() : _streamController = StreamController.broadcast();

  factory EventBus() => _instance;

  /// Listens for events of Type [T] and its subtypes.
  ///
  /// The method is called like this: myEventBus.on<MyType>();
  ///
  /// If the method is called without a type parameter, the null is returned
  ///
  /// The returned [Stream] is a broadcast stream so multiple subscriptions are
  /// allowed.
  ///
  /// Each listener is handled independently, and if they pause, only the pausing
  /// listener is affected. A paused listener will buffer events internally until
  /// unpaused or canceled. So it's usually better to just cancel and later
  /// subscribe again (avoids memory leak).
  ///
  Stream<T> on<T>() {
    return _streamController.stream.where((event) => event is T).cast<T>();
  }

  /// Cast a new event on the event bus with the specified [event].
  ///
  void cast(event) {
    _streamController.add(event);
  }

  /// Destroy this [StreamController]. This is generally only in a testing context.
  ///
  void destroy() {
    _streamController.close();
  }
}
