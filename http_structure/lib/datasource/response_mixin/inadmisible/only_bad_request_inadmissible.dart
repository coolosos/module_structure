import 'package:module_structure/model/codeable.dart';
import 'package:universal_io/io.dart';

import '../../http_datasource.dart';

/// Contains only Bad Request 400 inadmissible
mixin OnlyBadRequestInadmissible<Info extends Codeable>
    on HttpDataSource<Info> {
  @override
  List<int> get inadmissibleStatusCode => [
        HttpStatus.badRequest,
      ];
}
