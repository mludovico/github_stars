import 'dart:io';

import 'package:dio/dio.dart';
import 'package:github_stars/app/secrets/secrets.dart';

void main() async {
  final code = '6500559d81906f35423a';
  final endpoint = 'https://github.com/login/oauth/access_token';
  final queryParams = {
    'client_id': kClientId,
    'client_secret': kClientSecret,
    'code': code,
  };
  final options = Options(
    headers: {
      'Content-Type': 'application/json',
    },
    validateStatus: (code) => code! < HttpStatus.internalServerError,
  );
  final dio = Dio();
  final response = await dio.post(
    endpoint,
    queryParameters: queryParams,
    options: options,
  );
  print(
      '${response.requestOptions.method} ${response.requestOptions.path} - ${response.statusCode} ${response.data}');
}
