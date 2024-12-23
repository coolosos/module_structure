import 'package:module_structure/model/codable.dart';
import 'package:module_structure/model/params.dart';

import '../http_datasource.dart';
import 'params/patch_param.dart';

mixin PatchRequest<Info extends Codable> on HttpDataSource<Info> {
  @override
  Future<Info> call({required Params params}) async {
    final PatchParam patchParams = generateCallRequirement(params: params);

    final callUri = patchParams.modifyUriWithUrlParams(uri);

    final body = patchParams.encodeBody?.call();

    observer.onCall(
      callUri,
      body: body?.toString(),
      datasourceName: runtimeType.toString(),
    );

    final response = await client.patch(
      callUri,
      headers: patchParams.headers,
      body: body,
    );

    return checkInformation(
      response: response,
      requestHeaders: patchParams.headers,
      requestUri: callUri,
      requestBody: body,
    );
  }

  @override
  PatchParam generateCallRequirement({required covariant Params params});
}
