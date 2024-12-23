import 'package:module_structure/model/codable.dart';
import 'package:module_structure/model/params.dart';

import '../http_datasource.dart';
import 'params/delete_param.dart';

mixin DeleteRequest<Info extends Codable> on HttpDataSource<Info> {
  @override
  Future<Info> call({required Params params}) async {
    final DeleteParam requestParams = generateCallRequirement(params: params);

    final callUri = requestParams.modifyUriWithUrlParams(uri);

    final body = requestParams.encodeBody?.call();

    observer.onCall(
      callUri,
      datasourceName: runtimeType.toString(),
      body: body?.toString(),
    );

    final response = await client.delete(
      callUri,
      headers: requestParams.headers,
      body: body,
    );

    return checkInformation(
      response: response,
      requestHeaders: requestParams.headers,
      requestUri: callUri,
    );
  }

  @override
  DeleteParam generateCallRequirement({required covariant Params params});
}
