import 'package:flutter/foundation.dart';
import 'package:module_structure/observers/simple_observer.dart';

import 'package:http/http.dart';
export 'package:http/http.dart';

abstract interface class HttpDatasourceObserver implements SimpleObserver {
  const HttpDatasourceObserver();

  @mustCallSuper
  void onInadmissibleException(
    int statusCode,
    String body,
    Response response,
    List<int> inadmissibleList, {
    required String datasourceName,
    Map<String, String>? requestHeaders,
    Uri? requestUri,
    Object? requestBody,
  }) {}

  @mustCallSuper
  void onAdmissible(
    Response response,
    Object? objectResult, {
    required String datasourceName,
  }) {}

  @mustCallSuper
  void onUnControlException(
    int statusCode,
    String body,
    Response response,
    List<int> inadmissibleList,
    List<int> admissibleList, {
    required String datasourceName,
    Map<String, String>? requestHeaders,
    Uri? requestUri,
    Object? requestBody,
  }) {}

  @mustCallSuper
  void onUriCreation(
    String? url,
    Map<String, String> modifyParameters,
    Uri? uri, {
    required String datasourceName,
  }) {}

  @mustCallSuper
  void onCall(
    Uri uri, {
    required String datasourceName,
    String? body,
  }) {}
}
