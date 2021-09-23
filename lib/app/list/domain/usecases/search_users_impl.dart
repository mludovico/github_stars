import 'package:github_stars/app/list/domain/entities/user.dart';
import 'package:github_stars/app/list/domain/repositories/list_repository.dart';
import 'package:github_stars/app/list/presenter/usecases/list_usecases.dart';

class SearchUsersImpl implements SearchUsers {
  final ListRepository repository;

  SearchUsersImpl(this.repository);

  @override
  Future<List<User>> call(String searchText) {
    final list = repository.searchUsersByText(searchText);
    return list;
  }
}
