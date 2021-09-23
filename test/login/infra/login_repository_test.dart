import 'package:flutter_test/flutter_test.dart';
import 'package:github_stars/app/login/data/login_local_datasource_impl.dart';
import 'package:github_stars/app/login/infra/datasources/login_local_datasource.dart';
import 'package:github_stars/app/login/infra/datasources/login_remote_datasource.dart';
import 'package:github_stars/app/login/infra/repositories/login_repository_impl.dart';
import 'package:github_stars/constants/prefs_keys.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_repository_test.mocks.dart';

@GenerateMocks([LoginRemoteDatasource, LoginLocalDatasource])
void main() async {
  final remoteDatasource = MockLoginRemoteDatasource();
  final localDatasource = MockLoginLocalDatasource();
  final repository = LoginRepositoryImpl(remoteDatasource, localDatasource);
  final code = 'jhsdjkhfsd';
  final token = 'dfjhiudfhgkjdnf';

  group('Mocked datasources login repository get token testes', () {
    test('Must complete repo getToken call', () async {
      when(remoteDatasource.getAccessTokenData(any))
          .thenAnswer((_) async => token);
      final future = repository.getAccessTokenFromRemote(code);
      expect(future, completes);
    });

    test('Must call cacheToken', () async {
      when(remoteDatasource.getAccessTokenData(any))
          .thenAnswer((_) async => token);
      await repository.getAccessTokenFromRemote(code);
      verify(repository.cacheAccessToken(any));
    });
  });

  group('Mocked datasources login repository cache token testes', () {
    test('Must complete repo cacheToken call', () async {
      when(localDatasource.cacheAccessTokenData(any))
          .thenAnswer((_) async => null);
      final future = repository.cacheAccessToken(code);
      expect(future, completes);
    });

    test('Must call datasource cacheToken', () async {
      when(localDatasource.cacheAccessTokenData(any))
          .thenAnswer((_) async => null);
      await repository.cacheAccessToken(code);
      verify(localDatasource.cacheAccessTokenData(any));
    });

    test('Must have a token in prefs after getToken call', () async {
      // Empty shared preferences
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final datasource = LoginLocalDatasourceImpl(prefs);
      final repo = LoginRepositoryImpl(remoteDatasource, datasource);
      await repo.cacheAccessToken(code);
      final storedToken = prefs.getString(kAccessTokenPrefsKey);
      expect(storedToken, isNotNull);
      expect(storedToken, isA<String>());
      expect(storedToken, isNotEmpty);
    });
  });
}
