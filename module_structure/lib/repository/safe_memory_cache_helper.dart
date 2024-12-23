import 'package:fpdart/fpdart.dart';

import '../../model/failure.dart';
import '../../model/params.dart';
import 'helpers/memory_repository_helper.dart';

import '../datasources/callable_datasource.dart';
import 'safe_repository_datasource_callable.dart';

abstract class SafeMemoryCacheRepository<Info,
        DS extends DataSourceCallable<Info>>
    extends SafeRepositoryDatasourceCallable<Info, DS>
    with MemoryCacheHelper<Info> {
  SafeMemoryCacheRepository({
    required super.dataSource,
    required this.refreshDuration,
  });

  @override
  final Duration refreshDuration;

  @override
  Future<Either<Failure, Info>> call({required Params repositoryParams}) async {
    if (!isRefreshRequired()) {
      final cachedData = cache;
      if (cachedData != null) {
        return Right(cachedData);
      }
    }
    final data = await super.call(repositoryParams: repositoryParams);
    cache = refreshCache(datasourceResponse: data);
    return data;
  }

  Info? refreshCache({
    required Either<Failure, Info> datasourceResponse,
  }) {
    return datasourceResponse.toNullable();
  }
}
