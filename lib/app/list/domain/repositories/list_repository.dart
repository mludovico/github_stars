import 'package:github_stars/app/list/domain/entities/user.dart';

abstract class ListRepository {
  Future<List<User>> searchUsersByText(String text);
}
