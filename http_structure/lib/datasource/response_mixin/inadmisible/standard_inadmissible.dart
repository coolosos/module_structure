import 'package:module_structure/model/codeable.dart';
import 'package:universal_io/io.dart';

import '../../http_datasource.dart';

///Contains the common Standard inadmissible errors:
/// * badRequest = 400
/// * unauthorized = 401
/// * forbidden = 403
/// * notFound = 404
/// * methodNotAllowed = 405
/// * notAcceptable = 406
mixin StandardClientInadmissible<Info extends Codeable>
    on HttpDataSource<Info> {
  @override
  List<int> get inadmissibleStatusCode => [
        HttpStatus.badRequest,
        HttpStatus.unauthorized,
        HttpStatus.forbidden,
        HttpStatus.notFound,
        HttpStatus.methodNotAllowed,
        HttpStatus.notAcceptable,
      ];
}
