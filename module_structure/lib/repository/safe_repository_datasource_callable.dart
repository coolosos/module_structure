import 'package:fpdart/src/either.dart';

import '../exceptions/datasource_exception.dart';
import '../../model/failure.dart';
import '../../model/params.dart';
import '../datasources/callable_datasource.dart';
import 'helpers/safe_repository_helper.dart';
import 'repository_datasource_callable.dart';

class SafeRepositoryDatasourceCallable<Info,
        DS extends DataSourceCalleable<Info>>
    extends RepositoryDataSourceCalleable<Info, DS>
    with SafeRepositoryHelper<Info> {
  SafeRepositoryDatasourceCallable({required super.dataSource});

  @override
  Future<Either<Failure, Info>> call({
    required covariant Params repositoryParams,
  }) async {
    return safeCall(call: super.call(repositoryParams: repositoryParams));
  }

  @override
  Failure Function(Object exception, StackTrace stackTrace) get onException =>
      throw UnimplementedError();

  @override
  Failure Function(InadmissibleException exception, StackTrace stackTrace)
      get onInadmissibleException => throw UnimplementedError();

  @override
  Failure Function(UnControlException exception, StackTrace stackTrace)
      get onUnControlException => throw UnimplementedError();
}
