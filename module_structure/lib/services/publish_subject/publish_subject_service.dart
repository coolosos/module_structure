import 'package:rxdart/rxdart.dart';

import '../service.dart';

abstract base class PublishSubjectService<T> implements Service {
  PublishSubjectService() : super();

  PublishSubject<T>? _publishSubject;
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
  void start() async {
    if (_publishSubject == null || (_publishSubject?.isClosed ?? true)) {
      _publishSubject = PublishSubject();
    }

    await work();
  }

  void dispose() {
    stop();
    _publishSubject?.close();
  }

  @override
  void stop() {}
}
