import 'dart:async';

import '../../model/params.dart';
import 'datasource.dart';

abstract class DataSourceCalleable<ValueType> extends DataSource {
  DataSourceCalleable();

  FutureOr<ValueType> call({required Params params});
}
