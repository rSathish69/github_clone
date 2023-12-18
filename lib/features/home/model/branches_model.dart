import 'dart:convert';

List<BranchesModel> branchesModelFromJson(String str) =>
    List<BranchesModel>.from(
        json.decode(str).map((x) => BranchesModel.fromJson(x)));

class BranchesModel {
  String name;
  Commit commit;
  bool protected;

  BranchesModel({
    required this.name,
    required this.commit,
    required this.protected,
  });

  factory BranchesModel.fromJson(Map<String, dynamic> json) => BranchesModel(
        name: json["name"] ?? "",
        commit: Commit.fromJson(json["commit"]),
        protected: json["protected"] ?? false,
      );
}

class Commit {
  String sha;
  String url;

  Commit({
    required this.sha,
    required this.url,
  });

  factory Commit.fromJson(Map<String, dynamic> json) => Commit(
        sha: json["sha"] ?? "",
        url: json["url"] ?? "",
      );
}
