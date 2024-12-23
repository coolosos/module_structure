import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class Codable<T> with EquatableMixin {
  const Codable();

  Codable decode(T remote);

  @override
  bool? get stringify => true;
}
