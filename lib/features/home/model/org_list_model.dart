import 'dart:convert';

List<OrganisationListModel> organisationListModelFromJson(String str) =>
    List<OrganisationListModel>.from(
        json.decode(str).map((x) => OrganisationListModel.fromJson(x)));

class OrganisationListModel {
  String login;
  int id;
  String nodeId;
  String url;
  String reposUrl;
  String eventsUrl;
  String hooksUrl;
  String issuesUrl;
  String membersUrl;
  String publicMembersUrl;
  String avatarUrl;
  String description;

  OrganisationListModel({
    required this.login,
    required this.id,
    required this.nodeId,
    required this.url,
    required this.reposUrl,
    required this.eventsUrl,
    required this.hooksUrl,
    required this.issuesUrl,
    required this.membersUrl,
    required this.publicMembersUrl,
    required this.avatarUrl,
    required this.description,
  });

  factory OrganisationListModel.fromJson(Map<String, dynamic> json) =>
      OrganisationListModel(
        login: json["login"] ?? "",
        id: json["id"] ?? 0,
        nodeId: json["node_id"] ?? "",
        url: json["url"] ?? "",
        reposUrl: json["repos_url"] ?? "",
        eventsUrl: json["events_url"] ?? "",
        hooksUrl: json["hooks_url"] ?? "",
        issuesUrl: json["issues_url"] ?? "",
        membersUrl: json["members_url"] ?? "",
        publicMembersUrl: json["public_members_url"] ?? "",
        avatarUrl: json["avatar_url"] ?? "",
        description: json["description"] ?? "",
      );
}
