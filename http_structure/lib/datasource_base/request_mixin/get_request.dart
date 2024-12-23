import 'package:module_structure/model/codable.dart';
import 'package:module_structure/model/params.dart';

import '../http_datasource.dart';
import 'params/get_param.dart';

mixin GetRequest<Info extends Codable> on HttpDataSource<Info> {
  @override
  Future<Info> call({required Params params}) async {
    final GetParam requestParams = generateCallRequirement(params: params);

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

  @override
  GetParam generateCallRequirement({required covariant Params params});
}
