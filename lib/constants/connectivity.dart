import 'package:github_stars/app/secrets/secrets.dart';

const kProductionServer = 'https://api.github.com/graphql';
const kLocalServerUrl = 'http://localhost:8080';
final kOAuthUrl = Uri(
  scheme: 'https',
  host: 'github.com',
  path: '/login/oauth/authorize',
  queryParameters: {
    'client_id': kClientId,
    'redirect_uri': kLocalServerUrl,
    'scope': 'user:email',
  },
);
const kAccessTokenUrl = 'https://github.com/login/oauth/access_token';
