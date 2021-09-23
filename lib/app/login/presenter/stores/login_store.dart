import 'package:get_it/get_it.dart';
import 'package:github_stars/app/login/presenter/usecases/login_usecases.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  String? code;

  @observable
  String? error;

  @observable
  bool loading = false;

  @action
  Future<void> setCode(String? value) async {
    loading = true;
    print('Set code with value $value');
    final getAccessToken = GetIt.I<GetAccessToken>();
    try {
      code = value;
      await getAccessToken(code);
    } catch (e) {
      error = e.toString();
      code = null;
    }
    loading = false;
  }
}
