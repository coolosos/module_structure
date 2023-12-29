library usecase;

import 'dart:async';

import 'package:fpdart/fpdart.dart';
export 'package:fpdart/fpdart.dart' hide Order;

export 'package:meta/meta.dart';
import '../model/entity.dart';
import '../model/failure.dart';
import '../model/params.dart';

export '../model/failure.dart';

///Use case structure for single answer with one or more repositories
///
///Usecase must to management transformation between repository object and view object
abstract class UseCase<Type extends Entity, UsecaseParams extends Params> {
  FutureOr<Either<Failure, Type>> call(UsecaseParams params);
}

abstract class OneWayUseCase<Type extends Entity,
    UsecaseParams extends Params> {
  FutureOr<Option<Type>> call(UsecaseParams params);
}

abstract class OneWayFailureUseCase<Type extends Failure,
    UsecaseParams extends Params> {
  FutureOr<Option<Type>> call(UsecaseParams params);
}
