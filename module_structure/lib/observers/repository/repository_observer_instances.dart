library repository_observers;

import 'dart:developer';

import 'package:flutter/foundation.dart';

import '../simple_observer.dart';

part 'repository_observer.dart';
part 'repository_observer_implementations.dart';

class RepositoryObserverInstances {
  static SimpleRepositoryObserver? _repositoryObserver;
  static RepositoryDatasourceCallableObserver?
      _repositoryDatasourceCallableObserver;

  static set repositoryObserver(SimpleRepositoryObserver observer) =>
      _repositoryObserver = observer;

  static set repositoryDatasourceCallableObserver(
    RepositoryDatasourceCallableObserver observer,
  ) =>
      _repositoryDatasourceCallableObserver = observer;

  static SimpleRepositoryObserver get repositoryObserver =>
      _repositoryObserver ?? _DefaultRepositoryImp();

  static RepositoryDatasourceCallableObserver
      get repositoryDatasourceCallableObserver =>
          _repositoryDatasourceCallableObserver ?? _DefaultRepositoryImp();
}
