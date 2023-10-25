import 'package:meta/meta.dart';

@immutable
abstract class Params {
  const Params();
  bool validate();
  bool isNotValidate() => !validate();
}

class NoParams extends Params {
  const NoParams();
  @override
  bool validate() => true;
}

const NoParams noParams = NoParams();
