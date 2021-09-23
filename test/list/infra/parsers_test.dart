import 'package:flutter_test/flutter_test.dart';
import 'package:github_stars/app/list/domain/entities/git_repository.dart';
import 'package:github_stars/app/list/domain/entities/user.dart';
import 'package:github_stars/app/list/infra/models/git_repository_repository_model.dart';
import 'package:github_stars/app/list/infra/models/user_repository_model.dart';

import '../../util/user_data.dart';

void main() {
  group('User Repository model parser tests', () {
    final data = kUserListData;

    test('Must return a list of User', () {
      final list =
          data.map((user) => UserRepositoryModel.fromMap(user)).toList();
      expect(list, isNotNull);
      expect(list, isNotEmpty);
      expect(list.first, isA<User>());
    });

    test('Must not have null properties in User object', () {
      final list =
          data.map((user) => UserRepositoryModel.fromMap(user)).toList();
      expect(list.first, isNotNull);
      expect(list.first.name, isNotNull);
      expect(list.first.name, isA<String>());
      expect(list.first.nickName, isNotNull);
      expect(list.first.nickName, isA<String>());
      expect(list.first.avatar, isNotNull);
      expect(list.first.avatar, isA<String>());
      expect(list.first.bio, isNotNull);
      expect(list.first.bio, isA<String>());
      expect(list.first.location, isNotNull);
      expect(list.first.location, isA<String>());
      expect(list.first.email, isNotNull);
      expect(list.first.email, isA<String>());
      expect(list.first.url, isNotNull);
      expect(list.first.url, isA<String>());
    });
  });

  group('Git Repository model parser tests', () {
    final data = kGitRepositoryData;

    test('Must return a GitRepository', () {
      final repository = GitRepositoryRepositoryModel.fromMap(data);
      expect(repository, isNotNull);
      expect(repository, isA<GitRepository>());
    });

    test('Must not have null properties in GitRepository object', () {
      final repository = GitRepositoryRepositoryModel.fromMap(data);
      expect(repository.name, isNotNull);
      expect(repository.name, isA<String>());
      expect(repository.description, isNotNull);
      expect(repository.description, isA<String>());
      expect(repository.starCount, isNotNull);
      expect(repository.starCount, isA<int>());
    });
  });
}
