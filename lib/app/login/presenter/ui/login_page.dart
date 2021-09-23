import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:github_stars/app/login/presenter/stores/login_store.dart';
import 'package:github_stars/constants/connectivity.dart';
import 'package:github_stars/constants/routes.dart';
import 'package:github_stars/constants/theme.dart';
import 'package:mobx/mobx.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginStore = LoginStore();

  @override
  void initState() {
    super.initState();
    when(
      (_) => loginStore.code != null,
      () => Navigator.of(context).pushNamed(kListPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Git Stars'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('In order to query into github api you need to login.'),
          ),
          Expanded(
            child: Observer(
              builder: (_) {
                if (loginStore.loading) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Carregando suas informações...',
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Center(
                          child: LinearProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(kPrimaryColor),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                if (loginStore.error != null) {
                  return Center(
                    child: Text(
                      loginStore.error!,
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: kOAuthUrl,
                  ),
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      cacheEnabled: false,
                    ),
                  ),
                  onLoadStart: (controller, uri) {
                    print(uri);
                    if (uri?.host == 'localhost' && uri?.port == 8080) {
                      controller.loadUrl(
                        urlRequest: URLRequest(
                          url: Uri.parse('about:blank'),
                        ),
                      );
                      print('code returned');
                      loginStore.setCode(uri?.query.split('=').last);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
