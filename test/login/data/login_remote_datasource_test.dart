import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_stars/app/errors/errors.dart';
import 'package:github_stars/app/login/data/login_remote_datasource_impl.dart';
import 'package:github_stars/constants/connectivity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../list/data/list_remote_datasource_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final dio = MockDio();
  final server = kAccessTokenUrl;
  final datasource = LoginRemoteDatasourceImpl(dio, server);
  final code = 'sdsdgfg';
  final response = Response(
    requestOptions: RequestOptions(path: ''),
    statusCode: HttpStatus.ok,
  );
  group('mocked dio login remote datasource tests', () {
    test('Must complete upon datasource get token call', () {
      when(dio.post(any, queryParameters: anyNamed('queryParameters')))
          .thenAnswer(
        (_) async => response,
      );
      final future = datasource.getAccessTokenData(code);
      expect(future, completes);
    });
    test('Must return a String', () async {
      when(dio.post(any, queryParameters: anyNamed('queryParameters')))
          .thenAnswer(
        (_) async => response,
      );
      final result = await datasource.getAccessTokenData(code);
      expect(result, isNotNull);
      expect(result, isA<String>());
    });
    test('Must throw NotAuthenticated when dio response is != 200', () {
      when(dio.post(any, queryParameters: anyNamed('queryParameters')))
          .thenAnswer(
        (_) async => response..statusCode = 400,
      );
      final future = datasource.getAccessTokenData(code);
      expect(future, throwsA(isA<NotAuthenticated>()));
    });
    test('Must throw DatasourceError when dio crashes', () {
      when(dio.post(any, queryParameters: anyNamed('queryParameters')))
          .thenThrow(Exception());
      final future = datasource.getAccessTokenData(code);
      expect(future, throwsA(isA<DatasourceError>()));
    });
  });
}
