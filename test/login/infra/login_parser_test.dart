import 'package:flutter_test/flutter_test.dart';
import 'package:github_stars/app/login/infra/access_token_repository_model.dart';

import '../../util/login_data.dart';

void main() {
  final data = login_data;
  group('Login parsers tests', () {
    test('Must return a non null AccessTokenRepositoryModel', () {
      final token = AccessTokenRepositoryModel.parse(data);
      expect(token, isNotNull);
      expect(token, isA<AccessTokenRepositoryModel>());
    });
    test('Must have non null properties', () {
      final token = AccessTokenRepositoryModel.parse(data);
      expect(token.accessToken, isNotNull);
      expect(token.accessToken, isA<String>());
      expect(token.accessToken, isNotEmpty);
      expect(token.scope, isNotNull);
      expect(token.scope, isA<String>());
      expect(token.scope, isNotEmpty);
      expect(token.tokenType, isNotNull);
      expect(token.tokenType, isA<String>());
      expect(token.tokenType, isNotEmpty);
    });
  });
}
