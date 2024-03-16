abstract base class RequestParam {
  const RequestParam({
    this.headers,
    this.encodeBody,
    this.urlParams,
  });

  ///Custom headers added in specific call
  final Map<String, String>? headers;

  ///Decode objecto to request body. Usually:
  ///
  /// * json => json.encode(Map<String, String> body)
  /// * xml => xml.encode(Obj body)
  final Object? Function()? encodeBody;

  ///Params that you need to be added in excution time
  ///
  /// * api/list?startAt=now&lenght=90
  final Map<String, dynamic>? urlParams;

  Uri modifyUriWithUrlParams(Uri uri) {
    final urlParams = this.urlParams;
    final queryParams =
        (uri.queryParameters.isNotEmpty || (urlParams?.isNotEmpty ?? false))
            ? {
                if (uri.queryParameters.isNotEmpty) ...uri.queryParameters,
                if (urlParams != null) ...urlParams,
              }
            : null;
    return Uri(
      host: uri.host,
      port: uri.port,
      path: uri.path,
      scheme: uri.scheme,
      queryParameters: queryParams,
    );
  }
}
