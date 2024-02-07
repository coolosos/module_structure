library datasource_observers;

import 'dart:developer';

import '../simple_observer.dart';

part 'datasource_observer_implementation.dart';
part 'simple_datasource_observer.dart';

class DatasourceObserverInstances {
  static SimpleDatasourceObserver? _datasourceObserver;

  static set datasourceObserver(SimpleDatasourceObserver observer) =>
      _datasourceObserver = observer;

  static SimpleDatasourceObserver get datasourceObserver =>
      _datasourceObserver ?? SimpleDatasourceObserverImpl();
}
