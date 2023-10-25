import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../service.dart';

abstract class TimerAndBehaviorService<T> implements Service {
  TimerAndBehaviorService({
    required Duration periodicDuration,
  })  : _periodicDuration = periodicDuration,
        super();

  Timer? _timer;
  BehaviorSubject<T>? _behaviorSubject;
  final Duration _periodicDuration;

  Future<void> work();

  Stream<T>? get stream async* {
    final stream = _behaviorSubject?.stream;
    if (stream != null) {
      yield* stream;
    }
  }

  void add(T event) {
    if (!(_behaviorSubject?.isClosed ?? true)) {
      _behaviorSubject?.add(event);
    }
  }

  @override
  void start() {
    if (_behaviorSubject == null || (_behaviorSubject?.isClosed ?? true)) {
      _behaviorSubject = BehaviorSubject<T>();
    }
    if (_timer?.isActive ?? false) {
      _periodic();
      return;
    }
    _timer = Timer.periodic(_periodicDuration, (timer) async {
      await _periodic();
    });
  }

  Future<void> _periodic() async {
    await work();
  }

  void dispose() {
    stop();
    _behaviorSubject?.close();
  }

  @override
  void stop() {
    _timer?.cancel();
  }
}
