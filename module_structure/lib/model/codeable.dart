import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class Codeable<T> with EquatableMixin {
  const Codeable();

  Codeable decode(T remote);

  @override
  bool? get stringify => true;
}
