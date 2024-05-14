import 'package:module_structure/model/codeable.dart';
import 'package:universal_io/io.dart';

import '../../http_datasource.dart';

///Contains all 20X response as admissible responses for the datasource
/// *  ok = 200
/// *  created = 201
/// *  accepted = 202
/// *  nonAuthoritativeInformation = 203
/// *  noContent = 204
/// *  resetContent = 205
/// *  partialContent = 206
/// *  multiStatus = 207
/// *  alreadyReported = 208
mixin CompleteAdmissible<Info extends Codeable> on HttpDataSource<Info> {
  @override
  List<int> get admissibleStatusCode => [
        HttpStatus.ok,
        HttpStatus.created,
        HttpStatus.accepted,
        HttpStatus.nonAuthoritativeInformation,
        HttpStatus.noContent,
        HttpStatus.resetContent,
        HttpStatus.partialContent,
        HttpStatus.multiStatus,
        HttpStatus.alreadyReported,
      ];
}
