import 'package:flutter/foundation.dart';

import '../../observers/repository/repository_observer_instances.dart';

abstract class Repository {
  Repository() {
    _repositoryObserver.onCreate(runtimeType.toString());
  }

  static final SimpleRepositoryObserver _repositoryObserver =
      RepositoryObserverInstances.repositoryObserver;

  @mustCallSuper
  void dispose() {
    _repositoryObserver.onDispose(runtimeType.toString());
  }
}
