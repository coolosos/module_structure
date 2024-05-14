import 'package:module_structure/model/codeable.dart';
import 'package:module_structure/model/params.dart';

import '../http_datasource.dart';

import 'params/request_param.dart';

mixin Request<ParamsType extends RequestParam, Info extends Codeable>
    on HttpDataSource<Info> {
  @override
  ParamsType generateCallRequeriment({required covariant Params params});
}
