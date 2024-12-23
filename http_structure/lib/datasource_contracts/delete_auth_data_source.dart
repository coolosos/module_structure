import 'package:module_structure/model/codable.dart';
import '../datasource_base/http_datasource.dart';
import '../datasource_base/observer/http_datasource_observer.dart';
import '../datasource_base/request_mixin/delete_request.dart';

import '../datasource_base/response_mixin/inadmissible/complete_inadmissible.dart';

import '../datasource_base/response_mixin/admissible/only_ok_admissible.dart';

export 'package:http/src/response.dart';
export '../datasource_base/request_mixin/params/delete_param.dart';

export 'dart:io' show HttpHeaders, ContentType, HttpStatus;

abstract class DeleteAuthDataSource<T extends Codable> extends HttpDataSource<T>
    with DeleteRequest<T>, OnlyOKAdmissible<T>, CompleteInadmissible<T> {
  DeleteAuthDataSource(
    this.client,
  );

  @override
  final BaseClient client;
}
