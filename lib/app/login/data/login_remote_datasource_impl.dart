import 'dart:io';

import 'package:dio/dio.dart';
import 'package:github_stars/app/errors/errors.dart';
import 'package:github_stars/app/login/infra/datasources/login_remote_datasource.dart';
import 'package:github_stars/app/secrets/secrets.dart';

class LoginRemoteDatasourceImpl implements LoginRemoteDatasource {
  final Dio dio;
  final String server;

  LoginRemoteDatasourceImpl(this.dio, this.server);

  @override
  Future<String> getAccessTokenData(String? code) async {
    try {
      final response = await dio.post(
        server,
        queryParameters: {
          'client_id': kClientId,
          'client_secret': kClientSecret,
          'code': code,
        },
      );
      if (response.statusCode == HttpStatus.ok) {
        return response.data.toString().split('&').first.split('=').last;
      } else {
        throw NotAuthenticated();
      }
    } on NotAuthenticated {
      rethrow;
    } catch (e) {
      print(e.toString());
      throw DatasourceError();
    }
  }
}
