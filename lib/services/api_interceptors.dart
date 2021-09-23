import 'dart:io';

import 'package:dio/dio.dart';
import 'package:github_stars/constants/prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    RequestOptions authenticatedOptions = options.copyWith(
      headers: {
        'Content-Type': 'application/json',
      },
      validateStatus: (code) => code! < HttpStatus.internalServerError,
    );
    if (options.uri.path == '/graphql') {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(kAccessTokenPrefsKey);
      authenticatedOptions.headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }
    handler.next(authenticatedOptions);
  }
}
