import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_stars/app/secrets/secrets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  group('Real invocation tests (should not be run within test bundle)', () {
    test('Call github graphql api with dio', () async {
      final url = 'https://api.github.com/graphql';
      final httpLink = HttpLink(url);
      final authLink = AuthLink(getToken: () => 'Bearer $kAccessToken');
      final link = authLink.concat(httpLink);
      final client = GraphQLClient(
          link: link, cache: GraphQLCache(store: InMemoryStore()));
      final username = 'mludovico';
      final data = '''
query (\$username: String!) {
  search (query: \$username, type: USER, first: 50) {
      edges {
          node {
              ... on User {
                  login
                  name
                  starredRepositories {
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
}
''';
      final document = gql(data);
      final options = QueryOptions(
        document: document,
        variables: {
          'username': username,
        },
      );
      final result = await client.query(options);
      print(result.data);
    });
  });

  group('Real invocations tests with Dio', () {
    final dio = Dio();
    final link = 'https://api.github.com/graphql';
    final headers = {
      'Authorization': 'Bearer $kAccessToken',
    };
    final options = Options(
      validateStatus: (code) => code! < HttpStatus.internalServerError,
      headers: headers,
    );
    final data = {
      "query": "query (\$username: String!) {"
          "search(query: \$username, type: USER, first: 50) {"
          "edges {"
          "node {"
          "... on User {"
          "login "
          "name "
          "starredRepositories {"
          "nodes {"
          "name "
          "description "
          "stargazerCount "
          "}"
          "}"
          "}"
          "}"
          "}"
          "}"
          "}",
      "variables": {"username": "kdmoreira"}
    };
    test('Manually call post on graphql api', () async {
      final future = dio.post(
        link,
        options: options,
        data: data,
      );
      expect(future, completes);
      final result = await future;
      expect(result.data, isNotNull);
      print(result.data);
    });
  });
}
