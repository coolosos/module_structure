import 'dart:async';

import '../../model/params.dart';
import 'datasource.dart';

abstract class DataSourceCallable<ValueType> extends DataSource {
  DataSourceCallable();

  FutureOr<ValueType> call({required Params params});
}
