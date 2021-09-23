import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_stars/app/errors/errors.dart';
import 'package:github_stars/app/list/data/list_remote_datasource_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../util/user_data.dart';
import 'list_remote_datasource_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final client = MockDio();
  final datasource = ListRemoteDatasourceImpl(client, '');
  final userName = 'sdgdfg';
  final response = Response(
    statusCode: HttpStatus.ok,
    requestOptions: RequestOptions(path: ''),
    data: {
      'data': {
        'search': {
          'nodes': kUserListData,
        },
      },
    },
  );

  group('mocked GraphQL datasource tests', () {
    test('Must complete datasource search call', () async {
      when(client.post(any, data: anyNamed('data')))
          .thenAnswer((_) async => response);
      final future = datasource.searchUsersData(userName);
      expect(future, completes);
    });

    test('Must return a list', () async {
      when(client.post(any, data: anyNamed('data')))
          .thenAnswer((_) async => response);
      final result = await datasource.searchUsersData(userName);
      expect(result, isNotNull);
      expect(result, isA<List>());
    });

    test('Must throw datasource error upon error in dio', () async {
      when(client.post(any, data: anyNamed('data'))).thenThrow(Exception());
      final future = datasource.searchUsersData(userName);
      expect(future, throwsA(isA<DatasourceError>()));
    });

    test('Must throw NotAuthenticated error when not http ok', () async {
      when(client.post(any, data: anyNamed('data'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 400,
        ),
      );
      final future = datasource.searchUsersData(userName);
      expect(future, throwsA(isA<NotAuthenticated>()));
    });
  });
}
