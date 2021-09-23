import 'package:flutter/cupertino.dart';
import 'package:github_stars/app/list/presenter/ui/list_page.dart';
import 'package:github_stars/app/login/presenter/ui/login_page.dart';

const kHomePage = '/';
const kListPage = '/list';

final Map<String, Widget Function(BuildContext)> kRoutes = {
  kHomePage: (context) => LoginPage(),
  kListPage: (context) => ListPage(),
};
