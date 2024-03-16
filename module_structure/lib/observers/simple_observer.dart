import 'package:flutter/foundation.dart';

abstract interface class SimpleObserver {
  const SimpleObserver();

  @mustCallSuper
  void onCreate(String name) {}

  @mustCallSuper
  void onDispose(String name) {}
}
