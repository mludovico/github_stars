import 'dart:convert';

import 'package:github_stars/app/list/domain/entities/git_repository.dart';
import 'package:github_stars/app/list/domain/entities/user.dart';
import 'package:github_stars/app/list/infra/models/git_repository_repository_model.dart';

class UserRepositoryModel extends User {
  UserRepositoryModel({
    String? name,
    String? nickName,
    String? avatar,
    String? bio,
    String? location,
    String? email,
    String? url,
    List<GitRepository>? repositories,
  }) : super(
          name: name,
          nickName: nickName,
          avatar: avatar,
          bio: bio,
          location: location,
          email: email,
          url: url,
          repositories: repositories,
        );

  factory UserRepositoryModel.fromMap(Map<String, dynamic> map) =>
      UserRepositoryModel(
        name: map['name'],
        nickName: map['login'],
        avatar: map['avatarUrl'],
        bio: map['bio'],
        location: map['location'],
        email: map['email'],
        url: map['url'],
        repositories: map['starredRepositories']?['nodes'] == null
            ? null
            : map['starredRepositories']['nodes']
                .map<GitRepositoryRepositoryModel>((repository) =>
                    GitRepositoryRepositoryModel.fromMap(repository))
                .toList(),
      );

  factory UserRepositoryModel.fromJson(String json) =>
      UserRepositoryModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() => {
        'name': name,
        'login': nickName,
        'avatarUrl': avatar,
        'bio': bio,
        'location': location,
        'email': email,
        'url': url,
        'starredRepositories': {
          'nodes': repositories == null
              ? null
              : repositories!
                  .map<Map<String, dynamic>>((repository) =>
                      (repository as GitRepositoryRepositoryModel).toMap())
                  .toList(),
        }
      };

  String toJson() => jsonEncode(toMap());

  @override
  String toString() => toMap().toString();
}
