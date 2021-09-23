import 'package:github_stars/app/list/domain/entities/git_repository.dart';

class User {
  String? name;
  String? nickName;
  String? avatar;
  String? bio;
  String? location;
  String? email;
  String? url;
  List<GitRepository>? repositories;

  User({
    this.name,
    this.nickName,
    this.avatar,
    this.bio,
    this.location,
    this.email,
    this.url,
    this.repositories,
  });

  User copyWith({
    String? name,
    String? nickName,
    String? avatar,
    String? bio,
    String? location,
    String? email,
    String? url,
    List<GitRepository>? repositories,
  }) =>
      User(
        name: name ?? this.name,
        nickName: nickName ?? this.nickName,
        avatar: avatar ?? this.avatar,
        bio: bio ?? this.bio,
        location: location ?? this.location,
        email: email ?? this.email,
        url: url ?? this.url,
        repositories: repositories ?? this.repositories,
      );
}
