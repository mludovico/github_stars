class AccessTokenRepositoryModel {
  String? accessToken;
  String? scope;
  String? tokenType;

  AccessTokenRepositoryModel({this.accessToken, this.scope, this.tokenType});

  AccessTokenRepositoryModel copyWith(
    String? accessToken,
    String? scope,
    String? tokenType,
  ) =>
      AccessTokenRepositoryModel(
        accessToken: accessToken ?? this.accessToken,
        scope: scope ?? this.scope,
        tokenType: tokenType ?? this.tokenType,
      );

  factory AccessTokenRepositoryModel.parse(String data) {
    final parts = data.split('&');
    Map<String, String> map = {};
    for (var part in parts) {
      final key = part.split('=').first;
      final value = part.split('=').last;
      map[key] = value;
    }
    return AccessTokenRepositoryModel(
      accessToken: map['access_token'],
      scope: map['scope'],
      tokenType: map['token_type'],
    );
  }
}
