import 'package:module_structure/model/codable.dart';
import 'package:module_structure/model/params.dart';

import '../http_datasource.dart';
import 'params/post_param.dart';

mixin PostRequest<Info extends Codable> on HttpDataSource<Info> {
  @override
  Future<Info> call({required Params params}) async {
    final PostParam postParams = generateCallRequirement(params: params);

    final callUri = postParams.modifyUriWithUrlParams(uri);

    final body = postParams.encodeBody?.call();

    observer.onCall(
      callUri,
      body: body?.toString(),
      datasourceName: runtimeType.toString(),
    );

    final response = await client.post(
      callUri,
      headers: postParams.headers,
      body: body,
    );

    return checkInformation(
      response: response,
      requestHeaders: postParams.headers,
      requestUri: callUri,
      requestBody: body,
    );
  }

  @override
  PostParam generateCallRequirement({required covariant Params params});
}
