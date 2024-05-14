import 'package:module_structure/model/codeable.dart';
import 'package:module_structure/model/params.dart';

import 'params/delete_param.dart';
import 'request.dart';

mixin DeleteRequest<Info extends Codeable> on Request<DeleteParam, Info> {
  @override
  Future<Info> call({required Params params}) async {
    final DeleteParam requestParams = generateCallRequeriment(params: params);

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
}
