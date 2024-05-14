import 'package:module_structure/model/codeable.dart';
import 'package:module_structure/model/params.dart';

import 'params/patch_param.dart';
import 'request.dart';

mixin PatchRequest<Info extends Codeable> on Request<PatchParam, Info> {
  @override
  Future<Info> call({required Params params}) async {
    final PatchParam patchParams = generateCallRequeriment(params: params);

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
}
