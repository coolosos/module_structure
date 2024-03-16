import 'package:module_structure/model/codeable.dart';
import 'package:module_structure/model/params.dart';

import 'params/get_param.dart';
import 'request.dart';

mixin GetRequest<Info extends Codeable> on Request<GetParam, Info> {
  @override
  Future<Info> call({required Params params}) async {
    final GetParam requestParams = generateCallRequeriment(params: params);

    final callUri = requestParams.modifyUriWithUrlParams(uri);

    observer.onCall(
      callUri,
      datasourceName: runtimeType.toString(),
    );

    final response = await client.get(
      callUri,
      headers: requestParams.headers,
    );

    return checkInformation(
      response: response,
      requestHeaders: requestParams.headers,
      requestUri: callUri,
    );
  }
}
