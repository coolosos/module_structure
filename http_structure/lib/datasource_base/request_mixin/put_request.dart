import 'package:module_structure/model/codable.dart';
import 'package:module_structure/model/params.dart';

import '../http_datasource.dart';
import 'params/put_params.dart';

mixin PutRequest<Info extends Codable> on HttpDataSource<Info> {
  @override
  Future<Info> call({required Params params}) async {
    final PutParam putParams = generateCallRequirement(params: params);

    final callUri = putParams.modifyUriWithUrlParams(uri);

    final body = putParams.encodeBody?.call();

    observer.onCall(
      callUri,
      datasourceName: runtimeType.toString(),
      body: body.toString(),
    );

    final response = await client.put(
      callUri,
      headers: putParams.headers,
      body: body,
    );
    return checkInformation(
      response: response,
      requestHeaders: putParams.headers,
      requestUri: callUri,
      requestBody: body,
    );
  }

  @override
  PutParam generateCallRequirement({required covariant Params params});
}
