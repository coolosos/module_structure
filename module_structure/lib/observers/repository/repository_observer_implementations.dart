part of 'repository_observer_instances.dart';

class _DefaultRepositoryImp implements RepositoryDatasourceCallableObserver {
  @override
  void onCreate(String name) {
    log('⛅️ Repository $name create');
  }

  @override
  void onDispose(String name) {
    log('💨 Repository $name dispose');
  }

  @override
  void afterCall(String name, String datasourceName, Object? datasourceValue) {
    log('💨 Repository $name call $datasourceName with value $datasourceValue');
  }

  @override
  void beforeCall(String name, String datasourceName) {
    log('💨 Repository $name are going to call $datasourceName');
  }
}
