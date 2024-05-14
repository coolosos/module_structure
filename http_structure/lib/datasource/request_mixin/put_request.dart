import 'package:module_structure/model/codeable.dart';
import 'package:module_structure/model/params.dart';

import 'params/put_params.dart';
import 'request.dart';

mixin PutRequest<Info extends Codeable> on Request<PutParam, Info> {
  @override
  Future<Info> call({required Params params}) async {
    final PutParam putParams = generateCallRequeriment(params: params);

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
}
