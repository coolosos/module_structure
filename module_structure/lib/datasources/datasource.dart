import 'package:meta/meta.dart';

import '../../observers/datasource/datasource_observer_instances.dart';
import '../../observers/simple_observer.dart';

abstract class DataSource {
  DataSource() {
    _datasourceObserver.onCreate(runtimeType.toString());
  }

  static final SimpleObserver _datasourceObserver =
      DatasourceObserverInstances.datasourceObserver;

  @mustCallSuper
  void dispose() {
    _datasourceObserver.onDispose(runtimeType.toString());
  }
}
