sealed class DataSourceException implements Exception {
  const DataSourceException({
    this.requestHeaders,
    this.requestUri,
    this.requestBody,
  });

  final Map<String, String>? requestHeaders;
  final Uri? requestUri;
  final Object? requestBody;
}

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
