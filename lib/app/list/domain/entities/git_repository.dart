class GitRepository {
  String? name;
  String? description;
  int? starCount;

  GitRepository({
    this.name,
    this.description,
    this.starCount,
  });

  GitRepository copyWith(
    String? name,
    String? description,
    int? starCount,
  ) =>
      GitRepository(
        name: name ?? this.name,
        description: description ?? this.description,
        starCount: starCount ?? this.starCount,
      );
}
