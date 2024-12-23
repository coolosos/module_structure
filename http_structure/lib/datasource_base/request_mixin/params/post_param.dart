import 'request_param.dart';

base class PostParam extends RequestParam {
  const PostParam({
    super.headers,
    super.encodeBody,
    super.urlParams,
  });
}
