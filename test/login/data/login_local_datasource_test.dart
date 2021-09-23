import 'package:flutter_test/flutter_test.dart';
import 'package:github_stars/app/login/data/login_local_datasource_impl.dart';
import 'package:github_stars/constants/prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  group('Mocked shared preferences login local datasource cache token tests',
      () {
    test('Must complete local datasource cache token call', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final datasource = LoginLocalDatasourceImpl(prefs);
      final accessToken = 'sdfkjbjsfd';
      await datasource.cacheAccessTokenData(accessToken);
      final storedToken = prefs.getString(kAccessTokenPrefsKey);
      expect(storedToken, isNotNull);
      expect(storedToken, isA<String>());
      expect(storedToken, equals(accessToken));
    });
  });

  group(
      'Mocked shared preferences login local datasource get cached token tests',
      () {
    test('Must complete local datasource cache token call', () async {
      final accessToken = 'sdfkjbjsfd';
      SharedPreferences.setMockInitialValues(
          {kAccessTokenPrefsKey: accessToken});
      final prefs = await SharedPreferences.getInstance();
      final datasource = LoginLocalDatasourceImpl(prefs);
      final storedToken = await datasource.getCachedAccessTokenData();
      expect(storedToken, isNotNull);
      expect(storedToken, isA<String>());
      expect(storedToken, equals(accessToken));
    });
  });
}
