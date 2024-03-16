import 'package:module_structure/model/codeable.dart';
import 'package:module_structure/model/params.dart';

import 'params/post_param.dart';
import 'request.dart';

mixin PostRequest<Info extends Codeable> on Request<PostParam, Info> {
  @override
  Future<Info> call({required Params params}) async {
    final PostParam postParams = generateCallRequeriment(params: params);

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
}
