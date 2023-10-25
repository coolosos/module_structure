import 'dart:async';

import 'package:fpdart/fpdart.dart';

import '../../exceptions/datasource_exception.dart';
import '../../../model/failure.dart';

import '../repository.dart';

mixin SafeRepositoryHelper<Info> on Repository {
  ///Unhandled status code from server
  Failure Function(
    UnControlException exception,
    StackTrace stackTrace,
  ) get onUnControlException;

  ///Get invalid status code from server
  Failure Function(
    InadmissibleException exception,
    StackTrace stackTrace,
  ) get onInadmissibleException;

  ///Unhandled exception
  Failure Function(
    Object exception,
    StackTrace stackTrace,
  ) get onException;

  ///Control call exception and return some error management by failures:
  /// * onException
  /// * onInadmissibleException
  /// * onUnControlException
  FutureOr<Either<Failure, Info>> safeCall({
    required FutureOr<Either<Failure, Info>> call,
  }) async {
    try {
      return await call;
    } on UnControlException catch (e, s) {
      return Left(onUnControlException(e, s));
    } on InadmissibleException catch (e, s) {
      return Left(onInadmissibleException(e, s));
    } catch (exception, stackTrace) {
      //No esta pudiendo ser controlada la exception con lo que hay que tener cuidado
      return Left(onException(exception, stackTrace));
    }
  }
}
