import 'dart:convert';

import 'package:github_stars/app/list/domain/entities/git_repository.dart';

class GitRepositoryRepositoryModel extends GitRepository {
  GitRepositoryRepositoryModel({
    String? name,
    String? description,
    int? starCount,
  }) : super(
          name: name,
          description: description,
          starCount: starCount,
        );

  factory GitRepositoryRepositoryModel.fromMap(Map<String, dynamic> map) =>
      GitRepositoryRepositoryModel(
        name: map['name'],
        description: map['description'],
        starCount: map['stargazerCount'],
      );

  factory GitRepositoryRepositoryModel.fromJson(String json) =>
      GitRepositoryRepositoryModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() => {
        'name': name,
        'description': description,
        'starCount': starCount,
      };

  String toJson() => jsonEncode(toMap());

  @override
  String toString() => toMap().toString();
}
