abstract class LoginRepository {
  Future<void> getAccessTokenFromRemote(String? code);
  Future<void> cacheAccessToken(String? token);
  Future<String?> getCachedAccessToken();
}
