import 'package:module_structure/model/codable.dart';

import '../datasource_base/observer/http_datasource_observer.dart';
import '../datasource_base/request_mixin/post_request.dart';
import '../datasource_base/response_mixin/admissible/only_ok_admissible.dart';
import '../datasource_base/http_datasource.dart';
import '../datasource_base/response_mixin/inadmissible/complete_inadmissible.dart';

export 'package:http/src/response.dart';

export 'dart:io' show HttpHeaders, ContentType, HttpStatus;

abstract class PostAuthDataSource<T extends Codable> extends HttpDataSource<T>
    with PostRequest<T>, OnlyOKAdmissible<T>, CompleteInadmissible<T> {
  PostAuthDataSource(
    this.client,
  );

  @override
  final BaseClient client;
}
