import 'package:github_stars/app/login/domain/repositories/login_repository.dart';
import 'package:github_stars/app/login/presenter/usecases/login_usecases.dart';

class GetAccessTokenImpl implements GetAccessToken {
  final LoginRepository repository;

  GetAccessTokenImpl(this.repository);

  @override
  Future<void> call(String? code) async {
    await repository.getAccessTokenFromRemote(code);
  }
}
