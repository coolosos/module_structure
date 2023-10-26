import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@Immutable('Entities must be immutable')
abstract base class Entity extends Equatable {
  const Entity();

  @override
  List<Object?> get props;

  @override
  bool? get stringify => true;
}
