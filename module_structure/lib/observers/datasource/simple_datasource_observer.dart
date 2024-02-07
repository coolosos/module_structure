part of 'datasource_observer_instances.dart';

abstract interface class SimpleDatasourceObserver implements SimpleObserver {
  @override
  void onCreate(String name);

  @override
  void onDispose(String name);
}
