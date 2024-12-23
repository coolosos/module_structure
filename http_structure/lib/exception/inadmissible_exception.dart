part of 'datasource_exception.dart';

final class InadmissibleException extends DataSourceException {
  const InadmissibleException({
    required this.body,
    required this.statusCode,
    super.requestHeaders,
    super.requestUri,
    super.requestBody,
  });

  final String body;
  final int statusCode;

  @override
  String toString() {
    return 'InadmissibleException(requestUri: $requestUri, requestBody: $requestBody, requestHeaders: $requestHeaders, statusCode: $statusCode, body: $body,)';
  }
}