import 'package:flutter_test/flutter_test.dart';
import 'package:github_stars/app/errors/errors.dart';
import 'package:github_stars/app/list/domain/entities/user.dart';
import 'package:github_stars/app/list/domain/repositories/list_repository.dart';
import 'package:github_stars/app/list/domain/usecases/search_users_impl.dart';
import 'package:github_stars/app/list/infra/models/user_repository_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../util/user_data.dart';
import 'list_usecase_test.mocks.dart';

@GenerateMocks([ListRepository])
void main() {
  final repository = MockListRepository();

  group('Search User by text use case tests', () {
    final useCase = SearchUsersImpl(repository);
    final text = 'fsdfsf';
    final user = kUserListData
        .map<UserRepositoryModel>((user) => UserRepositoryModel.fromMap(user))
        .toList();

    test('Must complete search call', () {
      when(repository.searchUsersByText(any))
          .thenAnswer((realInvocation) async => user);
      final future = useCase(text);
      expect(future, completes);
    });

    test('Must return a list of User', () async {
      when(repository.searchUsersByText(any))
          .thenAnswer((realInvocation) async => user);
      final users = await useCase(text);
      expect(users, isNotNull);
      expect(users, isNotEmpty);
      expect(users.first, isA<User>());
    });

    test('Must return whatever the repository return/throw (UserRepository)',
        () async {
      when(repository.searchUsersByText(any)).thenThrow(DatasourceError());
      expect(() => useCase(text), throwsA(isA<DatasourceError>()));
      reset(repository);
      when(repository.searchUsersByText(any)).thenThrow(NotAuthenticated());
      expect(() => useCase(text), throwsA(isA<NotAuthenticated>()));
      reset(repository);
      when(repository.searchUsersByText(any))
          .thenAnswer((realInvocation) => Future.error('error'));
      expect(() => useCase(text), throwsA('error'));
    });
  });
}
