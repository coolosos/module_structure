library datasource.http;

import 'package:flutter/foundation.dart';
import 'package:module_structure/model/codable.dart';
import 'package:module_structure/datasources/callable_datasource.dart';
import 'package:module_structure/model/params.dart';

import 'package:universal_io/io.dart' hide HttpClient;

import '../exception/datasource_exception.dart';
import 'observer/http_datasource_observer.dart';
import 'observer/http_observer.dart';
import 'request_mixin/params/request_param.dart';
export 'package:universal_io/io.dart' show HttpHeaders, ContentType;

///Provide the required abstract method and values for remote datasource management
///
///To clarify and simply use is usually use with some mixin:
/// * Request mixin: Provide the overrides to call method:
///   * Delete: DeleteRequest
///   * Get:  GetRequest
///   * Patch: PatchRequest
///   * Post: PostRequest
///   * Put: PutRequest
/// * Admissible mixin: Provide overrides to admissible status code
///   * RequestAdmissible: With all the success status
///   * OnlyOKAdmissible:  With the 200 status code
///   * StandardAdmissible: With 200/201/202
/// * Inadmissible mixin: Provide overrides to inadmissible status code
///   * CompleteInadmissible:  With all the client error status
///   * OnlyBadRequestInadmissible: With the 400 status code
///   * StandardClientInadmissible: With 400/401/403/404/405/406
///
/// Example:
/// ```dart
/// class ExampleSource extends HttpDataSource<RemoteObject> with GetResponse<RemoteObject>, OnlyOKAdmissible<RemoteObject>, BadRequestInadmissible<RemoteObject>{
///
///   @override
///   String get url => 'https://www.example.es'
///
///   @override
///   http.Client get client => http.Client()
///
///   @override
///   Future<Info> transformation({
///   required String body,
///   }){
///     final RemoteObject data = RemoteObject();
///     return data.decode(body);
///   }
///
///   GetParam generateCallRequirement({required NoParams params}){
///     return GetParam();
///   }
/// }
/// ...
/// class RemoteObject extends Codable{
/// @override
///   RemoteObject decode(String body) {
///     return fromMap(bodyToMap(body));
///   }
///   @override
///   RemoteObject fromMap(Map<String, dynamic> data) {
///     ...
///   }
///  @override
///
///   List<Object?> get props => ...
///   @override
///   Map<String, dynamic> toMap() {
///     ...
///   }
/// }
/// ```
abstract class HttpDataSource<Info extends Codable>
    extends DataSourceCallable<Info> {
  HttpDataSource();

  HttpDatasourceObserver get observer =>
      HttpObserverInstances.httpDatasourceObserver;

  ///host of the provide information, can contains port and scheme
  String get host;

  ///path of the provide information
  String? get path;

  ///path of the provide information
  Map<String, String> get pathModification => {};

  ///List of [HttpStatus] with the admissible status codes.
  ///
  ///Usually statusCode = 200 is provide in this list
  List<int> get admissibleStatusCode => [];

  ///List of [HttpStatus] with the inadmissible status codes.
  ///
  ///Usually statusCode = 400 is provide in this list.
  ///When inadmissible statusCode is return in call a [InadmissibleFailure] with the current information.
  ///
  ///Usually this must be uses for datasource error status code control.
  List<int> get inadmissibleStatusCode => [];

  ///Provide http client for call requirements any implementation of client will be accepted
  BaseClient get client;

  ///Current url transformation to URI.
  ///
  ///In tryParse failures [FormatException] will be throw.
  Uri get uri {
    final uri = Uri.parse(host); //!will be throw.
    final checkPath = uri.path.replaceFirst('/', '');

    if (uri.host.isEmpty || checkPath.isNotEmpty) {
      throw const FormatException('Url provide is not a valid URL');
    }

    String? modifyPath = path;
    pathModification.forEach(
      (key, value) => modifyPath = modifyPath?.replaceFirst(key, value),
    );

    final Uri completeUri = Uri(
      host: uri.host,
      port: uri.port,
      path: modifyPath,
      scheme: uri.scheme,
    );

    observer.onUriCreation(
      path,
      pathModification,
      completeUri,
      datasourceName: runtimeType.toString(),
    );

    return completeUri;
  }

  ///Function call after response success.
  ///
  ///Transform the information of response.body in [Info] object.
  ///This function is required because factory of T is not possible.
  Info transformation({
    required Response remoteResponse,
  });

  ///Usually use after server call to return the required data or failure.
  ///
  ///Start checking inadmissible and later if is not an admissible
  ///
  ///By default, [transformation] function will be call after success response.
  @mustCallSuper
  Info checkInformation({
    required Response response,
    required Map<String, String>? requestHeaders,
    required Uri? requestUri,
    Object? requestBody,
  }) {
    if (inadmissibleStatusCode.contains(response.statusCode)) {
      observer.onInadmissibleException(
        response.statusCode,
        response.body,
        response,
        List.from(inadmissibleStatusCode),
        datasourceName: runtimeType.toString(),
        requestBody: requestBody,
        requestHeaders: requestHeaders,
        requestUri: requestUri,
      );

      throw InadmissibleException(
        statusCode: response.statusCode,
        body: response.body,
        requestBody: requestBody,
        requestHeaders: requestHeaders,
        requestUri: requestUri,
      );
    }
    if (!admissibleStatusCode.contains(response.statusCode)) {
      observer.onUnControlException(
        response.statusCode,
        response.body,
        response,
        List.from(inadmissibleStatusCode),
        List.from(admissibleStatusCode),
        datasourceName: runtimeType.toString(),
        requestBody: requestBody,
        requestHeaders: requestHeaders,
        requestUri: requestUri,
      );

      throw UnControlException(
        statusCode: response.statusCode,
        body:
            'Unexpect error. No admissible values provide by server.\n Body: ${response.body}',
        message: [
          {'body': response.body},
          {'reasonPhrase': response.reasonPhrase},
        ],
        requestBody: requestBody,
        requestHeaders: requestHeaders,
        requestUri: requestUri,
      );
    }

    final objectResult = transformation(remoteResponse: response);

    observer.onAdmissible(
      response,
      objectResult,
      datasourceName: runtimeType.toString(),
    );

    return objectResult;
  }

  ///Generate a request params
  RequestParam generateCallRequirement({required covariant Params params});

  ///Manage the server connection.
  ///
  ///Usually use with [checkInformation] function for control server answer.
  @override
  Future<Info> call({required covariant Params params});
}
