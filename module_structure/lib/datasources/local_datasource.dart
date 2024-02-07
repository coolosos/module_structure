import 'datasource.dart';

abstract class LocalDatasource<ValueType, Driver> extends DataSource {
  LocalDatasource(this.driver);
  final Driver driver;

  String get key;

  Future<void> put(ValueType? value) async {
    assert(value != null, 'The value puted on local for $key is null');
    if (value == null) {
      await delete();
    } else {
      await _save(value);
    }
  }

  Future<void> _save(ValueType value);

  Future<ValueType?> call() => read;
  Future<ValueType?> get read;

  Future<void> delete();
}
