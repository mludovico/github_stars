import 'package:flutter_test/flutter_test.dart';
import 'package:github_stars/app/errors/errors.dart';
import 'package:github_stars/app/list/domain/entities/user.dart';
import 'package:github_stars/app/list/infra/datasources/list_remote_datasource.dart';
import 'package:github_stars/app/list/infra/repositories/list_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../util/user_data.dart';
import 'repository_test.mocks.dart';

@GenerateMocks([ListRemoteDatasource])
void main() {
  final datasource = MockListRemoteDatasource();
  final repository = ListRepositoryImpl(datasource);
  final text = 'fgfdgdsf';
  final dataSourceErrorMessage = 'Houve um erro n comunicação com o servidor.';
  final notAuthenticatedErrorMessage =
      'Você não tem permissão para visualizar estas informações.';
  final unknownErrorMessage = 'Erro desconhecido.';

  group('Mocked datasource Repository search tests', () {
    final data = kUserListData;

    test('Must complete repository search call', () async {
      when(datasource.searchUsersData(any))
          .thenAnswer((realInvocation) async => data);
      final future = repository.searchUsersByText(text);
      expect(future, completes);
    });

    test('Must return a list of User', () async {
      when(datasource.searchUsersData(any))
          .thenAnswer((realInvocation) async => data);
      final result = await repository.searchUsersByText(text);
      expect(result, isNotNull);
      expect(result.first, isA<User>());
    });

    test(
        'Must return "Erro de comunicação" when datasource throws Datasource Error',
        () async {
      when(datasource.searchUsersData(any)).thenThrow(DatasourceError());
      final future = repository.searchUsersByText(text);
      expect(future, throwsA(dataSourceErrorMessage));
    });

    test(
        'Must return "Sem permissão" when datasource throws NotAuthenticated Error',
        () async {
      when(datasource.searchUsersData(any)).thenThrow(NotAuthenticated());
      final future = repository.searchUsersByText(text);
      expect(future, throwsA(notAuthenticatedErrorMessage));
    });

    test(
        'Must return "Erro de comunicação" when repository throws internal Error',
        () async {
      when(datasource.searchUsersData(any)).thenThrow(Exception());
      final future = repository.searchUsersByText(text);
      expect(future, throwsA(unknownErrorMessage));
    });
  });
}
