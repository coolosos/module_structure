import 'package:rxdart/rxdart.dart';

import '../service.dart';

abstract base class BehaviorSubjectService<T> implements Service {
  BehaviorSubjectService();

  BehaviorSubject<T>? _behaviourSubject;

  Future<void> work();

  Stream<T>? get stream async* {
    final stream = _behaviourSubject?.stream;
    if (stream != null) {
      yield* stream;
    }
  }

  void add(T event) {
    if (_behaviourSubject?.isClosed == false) {
      _behaviourSubject?.add(event);
    }
  }

  @override
  void start() {
    if (_behaviourSubject == null || (_behaviourSubject?.isClosed ?? true)) {
      _behaviourSubject = BehaviorSubject<T>();
    }

    work();
  }

  void dispose() {
    stop();
    _behaviourSubject?.close();
  }

  @override
  void stop() {}
}
