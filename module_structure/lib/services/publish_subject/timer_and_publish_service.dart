import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../service.dart';

abstract base class TimerAndPublishService<T> implements Service {
  TimerAndPublishService({
    required Duration periodicDuration,
  })  : _periodicDuration = periodicDuration,
        super();
  Timer? _timer;
  PublishSubject<T>? _publishSubject;
  final Duration _periodicDuration;

  Future<void> work();

  Stream<T>? get stream async* {
    final stream = _publishSubject?.stream;
    if (stream is Stream<T>) {
      yield* stream;
    }
  }

  void add(T event) {
    if (_publishSubject?.isClosed == false) {
      _publishSubject?.add(event);
    }
  }

  @override
  void start() {
    if (_publishSubject == null || (_publishSubject?.isClosed ?? true)) {
      _publishSubject = PublishSubject();
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

  void changePeriodicDuration(Duration newPeriodicDuration) {
    if (_publishSubject?.isClosed ?? true) return;
    _timer?.cancel();
    _timer = Timer.periodic((newPeriodicDuration - const Duration(minutes: 2)),
        (timer) async {
      await _periodic();
    });
  }

  void dispose() {
    stop();
    _publishSubject?.close();
  }

  @override
  void stop() {
    _timer?.cancel();
  }
}
