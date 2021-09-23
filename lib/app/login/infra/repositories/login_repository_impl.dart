import 'package:github_stars/app/errors/errors.dart';
import 'package:github_stars/app/login/domain/repositories/login_repository.dart';
import 'package:github_stars/app/login/infra/datasources/login_local_datasource.dart';
import 'package:github_stars/app/login/infra/datasources/login_remote_datasource.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginRemoteDatasource remoteDatasource;
  final LoginLocalDatasource localDatasource;

  LoginRepositoryImpl(this.remoteDatasource, this.localDatasource);

  @override
  Future<void> getAccessTokenFromRemote(String? code) async {
    try {
      final token = await remoteDatasource.getAccessTokenData(code);
      cacheAccessToken(token);
    } on InvalidToken {
      return Future.error(
          'Não foi possível verificar sua conta. Tente novamente.');
    } on DatasourceError {
      return Future.error('Houve um problema na comunicação com o servidor.');
    }
  }

  @override
  Future<void> cacheAccessToken(String? token) async {
    try {
      await localDatasource.cacheAccessTokenData(token);
    } on NotAuthenticated {
      return Future.error(
          'Não foi possível salvar suas credenciais. Tente novamente.');
    } on DatasourceError {
      return Future.error('Houve um erro ao salvar suas credenciais.');
    }
  }

  @override
  Future<String?> getCachedAccessToken() async {
    final accessToken = await localDatasource.getCachedAccessTokenData();
    return accessToken;
  }
}
