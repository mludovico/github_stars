import 'package:github_stars/app/errors/errors.dart';
import 'package:github_stars/app/login/infra/datasources/login_local_datasource.dart';
import 'package:github_stars/constants/prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginLocalDatasourceImpl implements LoginLocalDatasource {
  final SharedPreferences prefs;

  LoginLocalDatasourceImpl(this.prefs);

  @override
  Future<void> cacheAccessTokenData(String? accessToken) async {
    if (accessToken == null) throw InvalidToken();
    try {
      prefs.setString(kAccessTokenPrefsKey, accessToken);
    } on InvalidToken {
      rethrow;
    } on Exception {
      throw DatasourceError();
    }
  }

  @override
  Future<String?> getCachedAccessTokenData() async {
    final accessToken = prefs.getString(kAccessTokenPrefsKey);
    return accessToken;
  }
}
