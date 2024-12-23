import 'dart:convert';

import 'package:module_structure/model/codable.dart';
import 'package:module_structure/model/params.dart';

import '../datasource_base/request_mixin/params/get_param.dart';

import '../datasource_base/request_mixin/params/post_param.dart';
import 'post_auth_data_source.dart';

final class LoginDatasource extends PostAuthDataSource<LoginTokenRemote> {
  LoginDatasource(super.client);

  @override
  PostParam generateCallRequirement({required LoginDatasourceParams params}) {
    return PostParam(
      encodeBody: () => params.toMap(),
    );
  }

  @override
  String get host => "https://awesome-datasource.com";

  @override
  String? get path => "/login";

  @override
  LoginTokenRemote transformation({required Response remoteResponse}) {
    return const LoginTokenRemote().decode(remoteResponse.body);
  }
}

final class LoginTokenRemote extends Codable<String> {
  const LoginTokenRemote({this.access, this.refresh});

  factory LoginTokenRemote.fromJson(Map<String, dynamic> body) =>
      LoginTokenRemote(
        access: body["access"],
        refresh: body["refresh"],
      );

  final String? access;
  final String? refresh;
  @override
  LoginTokenRemote decode(String remote) {
    //..
    return LoginTokenRemote.fromJson(json.decode(remote));
  }

  @override
  List<Object?> get props => [
        //..
      ];
}

final class LoginDatasourceParams extends Params {
  const LoginDatasourceParams({
    required this.user,
    required this.password,
  });

  final String user;
  final String password;

  Map<String, String> toMap() => {
        "user": user,
        "password": password,
      };
  @override
  bool validate() {
    return user.isNotEmpty && password.isNotEmpty;
  }
}
