import 'package:github_stars/app/list/domain/entities/git_repository.dart';
import 'package:github_stars/app/list/domain/entities/user.dart';

abstract class SearchUsers {
  Future<List<User>> call(String searchText);
}
