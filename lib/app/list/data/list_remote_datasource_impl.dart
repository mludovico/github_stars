import 'dart:io';

import 'package:dio/dio.dart';
import 'package:github_stars/app/errors/errors.dart';
import 'package:github_stars/app/list/infra/datasources/list_remote_datasource.dart';

class ListRemoteDatasourceImpl implements ListRemoteDatasource {
  final Dio dio;
  final String server;
  String query = '''query (\$text: String!) {
  search (query: \$text, type: USER, first: 10) {
    nodes {
      ... on User {
        name 
        login 
        avatarUrl 
        bio 
        location 
        email 
        url 
        starredRepositories (first: 10) {
          nodes {
            name 
            description 
            stargazerCount 
          }
        }
      }
    }
  }
}
''';

  ListRemoteDatasourceImpl(this.dio, this.server);

  @override
  Future<List> searchUsersData(String username) async {
    try {
      final result = await dio.post(
        server,
        data: {
          'query': query,
          'variables': {'text': username},
        },
      );
      if (result.statusCode == HttpStatus.ok) {
        return result.data?['data']['search']['nodes'];
      } else {
        throw NotAuthenticated();
      }
    } on NotAuthenticated {
      rethrow;
    } on Exception {
      throw DatasourceError();
    }
  }
}
