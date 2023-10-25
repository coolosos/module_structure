import '../datasources/datasource.dart';
import 'repository.dart';

abstract class RepositoryDataSource<ValueType, DS extends DataSource>
    extends Repository {
  RepositoryDataSource({required this.dataSource});

  final DS dataSource;
}
