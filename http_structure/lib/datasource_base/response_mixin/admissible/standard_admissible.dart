import 'package:module_structure/model/codable.dart';
import 'package:universal_io/io.dart';

import '../../http_datasource.dart';

mixin StandardAdmissible<Info extends Codable> on HttpDataSource<Info> {
  @override
  List<int> get admissibleStatusCode => [
        HttpStatus.ok,
        HttpStatus.created,
        HttpStatus.accepted,
      ];
}
