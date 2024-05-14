library datasource_exception;

part 'inadmissible_exception.dart';
part 'uncontrol_exception.dart';

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
