import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:github_stars/app/list/data/list_remote_datasource_impl.dart';
import 'package:github_stars/app/list/domain/repositories/list_repository.dart';
import 'package:github_stars/app/list/domain/usecases/search_users_impl.dart';
import 'package:github_stars/app/list/infra/datasources/list_remote_datasource.dart';
import 'package:github_stars/app/list/infra/repositories/list_repository_impl.dart';
import 'package:github_stars/app/list/presenter/usecases/list_usecases.dart';
import 'package:github_stars/app/login/data/login_local_datasource_impl.dart';
import 'package:github_stars/app/login/data/login_remote_datasource_impl.dart';
import 'package:github_stars/app/login/domain/repositories/login_repository.dart';
import 'package:github_stars/app/login/domain/usecases/get_access_token_impl.dart';
import 'package:github_stars/app/login/infra/datasources/login_local_datasource.dart';
import 'package:github_stars/app/login/infra/datasources/login_remote_datasource.dart';
import 'package:github_stars/app/login/infra/repositories/login_repository_impl.dart';
import 'package:github_stars/app/login/presenter/usecases/login_usecases.dart';
import 'package:github_stars/constants/connectivity.dart';
import 'package:github_stars/services/api_interceptors.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kActiveServer = kProductionServer;

setUpLocators() async {
  // Dio

  Dio dio = Dio();
  dio.interceptors.add(AuthInterceptor());

  GetIt.I.registerSingleton<Dio>(dio);

  // SharedPreferences

  SharedPreferences preferences = await SharedPreferences.getInstance();

  // Datasources

  GetIt.I.registerSingleton<ListRemoteDatasource>(
      ListRemoteDatasourceImpl(GetIt.I<Dio>(), kActiveServer));
  GetIt.I.registerSingleton<LoginRemoteDatasource>(
      LoginRemoteDatasourceImpl(GetIt.I<Dio>(), kAccessTokenUrl));
  GetIt.I.registerSingleton<LoginLocalDatasource>(
      LoginLocalDatasourceImpl(preferences));

  // Repositories

  GetIt.I.registerSingleton<ListRepository>(
      ListRepositoryImpl(GetIt.I<ListRemoteDatasource>()));
  GetIt.I.registerSingleton<LoginRepository>(LoginRepositoryImpl(
      GetIt.I<LoginRemoteDatasource>(), GetIt.I<LoginLocalDatasource>()));

  // Use cases

  GetIt.I.registerSingleton<SearchUsers>(
      SearchUsersImpl(GetIt.I<ListRepository>()));
  GetIt.I.registerSingleton<GetAccessToken>(
      GetAccessTokenImpl(GetIt.I<LoginRepository>()));
}
