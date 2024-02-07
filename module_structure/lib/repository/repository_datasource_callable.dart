import 'dart:async';

import 'package:fpdart/fpdart.dart';

import '../../model/failure.dart';
import '../../model/params.dart';
import '../../observers/repository/repository_observer_instances.dart';
import '../datasources/callable_datasource.dart';
import 'repository_datasource.dart';

abstract class RepositoryDataSourceCalleable<ValueType,
        DS extends DataSourceCalleable<ValueType>>
    extends RepositoryDataSource<ValueType, DS> {
  RepositoryDataSourceCalleable({required super.dataSource});

  RepositoryDatasourceCallableObserver get observer =>
      RepositoryObserverInstances.repositoryDatasourceCallableObserver;

  FutureOr<Either<Failure, ValueType>> call({
    required covariant Params repositoryParams,
  }) async {
    observer.beforeCall(
      runtimeType.toString(),
      dataSource.runtimeType.toString(),
    );

    final data = await dataSource.call(params: repositoryParams);

    observer.afterCall(
      runtimeType.toString(),
      dataSource.runtimeType.toString(),
      data,
    );
    return Right(data);
  }
}
