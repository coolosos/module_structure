part of datasource_observers;

abstract interface class SimpleDatasourceObserver implements SimpleObserver {
  @override
  void onCreate(String name);

  @override
  void onDispose(String name);
}
