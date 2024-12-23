import 'package:module_structure/model/codable.dart';
import 'package:universal_io/io.dart';

import '../../http_datasource.dart';

///Contains only 200 response
mixin OnlyOKAdmissible<Info extends Codable> on HttpDataSource<Info> {
  @override
  List<int> get admissibleStatusCode => [
        HttpStatus.ok,
      ];
}
