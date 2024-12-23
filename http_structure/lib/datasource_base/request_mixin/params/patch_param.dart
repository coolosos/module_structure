import 'request_param.dart';

base class PatchParam extends RequestParam {
  const PatchParam({
    super.headers,
    super.encodeBody,
    super.urlParams,
  });
}
