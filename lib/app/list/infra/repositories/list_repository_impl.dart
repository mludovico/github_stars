import 'package:flutter/foundation.dart';
import 'package:github_stars/app/errors/errors.dart';
import 'package:github_stars/app/list/domain/entities/user.dart';
import 'package:github_stars/app/list/domain/repositories/list_repository.dart';
import 'package:github_stars/app/list/infra/datasources/list_remote_datasource.dart';
import 'package:github_stars/app/list/infra/models/user_repository_model.dart';

class ListRepositoryImpl implements ListRepository {
  final ListRemoteDatasource datasource;

  ListRepositoryImpl(this.datasource);

  @override
  Future<List<User>> searchUsersByText(String text) async {
    try {
      final listData = await datasource.searchUsersData(text);
      final list = listData
          .map<UserRepositoryModel>((user) => UserRepositoryModel.fromMap(user))
          .toList();
      return list;
    } on DatasourceError {
      return Future.error('Houve um erro n comunicação com o servidor.');
    } on NotAuthenticated {
      return Future.error(
          'Você não tem permissão para visualizar estas informações.');
    } catch (e) {
      debugPrint(e.toString());
      return Future.error('Erro desconhecido.');
    }
  }
}
