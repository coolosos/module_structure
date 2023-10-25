part of datasource_observers;

final class SimpleDatasourceObserverImpl implements SimpleDatasourceObserver {
  @override
  void onCreate(String name) {
    log('⛅️ Datasource $name create');
  }

  @override
  void onDispose(String name) {
    log('💨 Datasource $name dispose');
  }
}
