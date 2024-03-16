import 'http_datasource_observer.dart';

class HttpObserverInstances {
  static HttpDatasourceObserver? _httpDatasourceObserver;

  static set httpDatasourceObserver(HttpDatasourceObserver observer) =>
      _httpDatasourceObserver = observer;

  static HttpDatasourceObserver get httpDatasourceObserver =>
      _httpDatasourceObserver ?? _DefaultHttpObserver();
}

class _DefaultHttpObserver implements HttpDatasourceObserver {
  @override
  void onAdmissible(
    Response response,
    Object? objectResult, {
    required String datasourceName,
  }) {}

  @override
  void onCall(Uri uri, {required String datasourceName, String? body}) {}

  @override
  void onCreate(String name) {}

  @override
  void onDispose(String name) {}

  @override
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

  @override
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

  @override
  void onUriCreation(
    String? url,
    Map<String, String> modifyParameters,
    Uri? uri, {
    required String datasourceName,
  }) {}
}
