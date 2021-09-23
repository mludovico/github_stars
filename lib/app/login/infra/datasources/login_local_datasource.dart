abstract class LoginLocalDatasource {
  Future<void> cacheAccessTokenData(String? accessToken);
  Future<String?> getCachedAccessTokenData();
}
