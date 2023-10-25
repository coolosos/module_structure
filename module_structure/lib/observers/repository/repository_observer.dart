part of repository_observers;

abstract interface class SimpleRepositoryObserver implements SimpleObserver {
  @override
  void onCreate(String name);

  @override
  void onDispose(String name);
}

abstract interface class RepositoryDatasourceCallableObserver
    implements SimpleRepositoryObserver {
  @mustCallSuper
  void beforeCall(String name, String callableName);

  @mustCallSuper
  void afterCall(String name, String datasourceName, Object? datasourceValue);
}
