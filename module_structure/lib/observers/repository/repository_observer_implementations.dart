part of repository_observers;

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
    // TODO: implement beforeCall
  }
}
