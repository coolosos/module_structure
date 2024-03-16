part of 'datasource_exception.dart';


final class UnControlException extends DataSourceException {
  const UnControlException({
    this.body,
    this.statusCode,
    this.message,
    super.requestHeaders,
    super.requestUri,
    super.requestBody,
  });

  final String? body;
  final int? statusCode;
  final List<Object>? message;

  @override
  String toString() {
    return 'UnControlException(requestUri: $requestUri, requestBody: $requestBody, requestHeaders: $requestHeaders, statusCode: $statusCode, body: $body,)';
  }
}