import 'package:module_structure/model/codeable.dart';
import 'package:universal_io/io.dart';

import '../../http_datasource.dart';

/// Contains all 4XX inadmisible status code:
/// *  badRequest = 400
/// *  unauthorized = 401
/// *  paymentRequired = 402
/// *  forbidden = 403
/// *  notFound = 404
/// *  methodNotAllowed = 405
/// *  notAcceptable = 406
/// *  proxyAuthenticationRequired = 407
/// *  requestTimeout = 408
/// *  conflict = 409
/// *  gone = 410
/// *  lengthRequired = 411
/// *  preconditionFailed = 412
/// *  requestEntityTooLarge = 413
/// *  requestUriTooLong = 414
/// *  unsupportedMediaType = 415
/// *  requestedRangeNotSatisfiable = 416
/// *  expectationFailed = 417
/// *  misdirectedRequest = 421
/// *  unprocessableEntity = 422
/// *  locked = 423
/// *  failedDependency = 424
/// *  upgradeRequired = 426
/// *  preconditionRequired = 428
/// *  tooManyRequests = 429
/// *  requestHeaderFieldsTooLarge = 431
/// *  connectionClosedWithoutResponse = 444
/// *  unavailableForLegalReasons = 451
/// *  clientClosedRequest = 499
mixin CompleteInadmissible<Info extends Codeable> on HttpDataSource<Info> {
  @override
  List<int> get inadmissibleStatusCode => [
        HttpStatus.badRequest,
        HttpStatus.unauthorized,
        HttpStatus.paymentRequired,
        HttpStatus.forbidden,
        HttpStatus.notFound,
        HttpStatus.methodNotAllowed,
        HttpStatus.notAcceptable,
        HttpStatus.proxyAuthenticationRequired,
        HttpStatus.requestTimeout,
        HttpStatus.conflict,
        HttpStatus.gone,
        HttpStatus.lengthRequired,
        HttpStatus.preconditionFailed,
        HttpStatus.requestEntityTooLarge,
        HttpStatus.requestUriTooLong,
        HttpStatus.unsupportedMediaType,
        HttpStatus.requestedRangeNotSatisfiable,
        HttpStatus.expectationFailed,
        HttpStatus.misdirectedRequest,
        HttpStatus.unprocessableEntity,
        HttpStatus.locked,
        HttpStatus.failedDependency,
        HttpStatus.upgradeRequired,
        HttpStatus.preconditionRequired,
        HttpStatus.tooManyRequests,
        HttpStatus.requestHeaderFieldsTooLarge,
        HttpStatus.connectionClosedWithoutResponse,
        HttpStatus.unavailableForLegalReasons,
        HttpStatus.clientClosedRequest,
      ];
}
