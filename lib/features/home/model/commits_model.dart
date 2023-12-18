import 'dart:convert';

List<CommitsModel> commitsModelFromJson(String str) => List<CommitsModel>.from(
    json.decode(str).map((x) => CommitsModel.fromJson(x)));

class CommitsModel {
  String sha;
  String nodeId;
  Commit commit;
  String url;
  String htmlUrl;
  String commentsUrl;
  CommitsModelAuthor? author;
  CommitsModelAuthor? committer;
  List<Parent> parents;

  CommitsModel({
    required this.sha,
    required this.nodeId,
    required this.commit,
    required this.url,
    required this.htmlUrl,
    required this.commentsUrl,
    required this.author,
    required this.committer,
    required this.parents,
  });

  factory CommitsModel.fromJson(Map<String, dynamic> json) => CommitsModel(
        sha: json["sha"],
        nodeId: json["node_id"],
        commit: Commit.fromJson(json["commit"]),
        url: json["url"],
        htmlUrl: json["html_url"],
        commentsUrl: json["comments_url"],
        author: json["author"] == null
            ? null
            : CommitsModelAuthor.fromJson(json["author"]),
        committer: json["committer"] == null
            ? null
            : CommitsModelAuthor.fromJson(json["committer"]),
        parents:
            List<Parent>.from(json["parents"].map((x) => Parent.fromJson(x))),
      );
}

class CommitsModelAuthor {
  String login;
  int id;
  String nodeId;
  String avatarUrl;
  String gravatarId;
  String url;
  String htmlUrl;
  String followersUrl;
  String followingUrl;
  String gistsUrl;
  String starredUrl;
  String subscriptionsUrl;
  String organizationsUrl;
  String reposUrl;
  String eventsUrl;
  String receivedEventsUrl;
  String type;
  bool siteAdmin;

  CommitsModelAuthor({
    required this.login,
    required this.id,
    required this.nodeId,
    required this.avatarUrl,
    required this.gravatarId,
    required this.url,
    required this.htmlUrl,
    required this.followersUrl,
    required this.followingUrl,
    required this.gistsUrl,
    required this.starredUrl,
    required this.subscriptionsUrl,
    required this.organizationsUrl,
    required this.reposUrl,
    required this.eventsUrl,
    required this.receivedEventsUrl,
    required this.type,
    required this.siteAdmin,
  });

  factory CommitsModelAuthor.fromJson(Map<String, dynamic> json) =>
      CommitsModelAuthor(
        login: json["login"] ?? "",
        id: json["id"],
        nodeId: json["node_id"] ?? "",
        avatarUrl: json["avatar_url"],
        gravatarId: json["gravatar_id"],
        url: json["url"],
        htmlUrl: json["html_url"],
        followersUrl: json["followers_url"],
        followingUrl: json["following_url"],
        gistsUrl: json["gists_url"],
        starredUrl: json["starred_url"],
        subscriptionsUrl: json["subscriptions_url"],
        organizationsUrl: json["organizations_url"],
        reposUrl: json["repos_url"],
        eventsUrl: json["events_url"],
        receivedEventsUrl: json["received_events_url"],
        type: json["type"],
        siteAdmin: json["site_admin"],
      );
}

class Commit {
  CommitAuthor author;
  CommitAuthor committer;
  String message;
  Tree tree;
  String url;
  int commentCount;
  Verification verification;

  Commit({
    required this.author,
    required this.committer,
    required this.message,
    required this.tree,
    required this.url,
    required this.commentCount,
    required this.verification,
  });

  factory Commit.fromJson(Map<String, dynamic> json) => Commit(
        author: CommitAuthor.fromJson(json["author"]),
        committer: CommitAuthor.fromJson(json["committer"]),
        message: json["message"],
        tree: Tree.fromJson(json["tree"]),
        url: json["url"],
        commentCount: json["comment_count"],
        verification: Verification.fromJson(json["verification"]),
      );

}

class CommitAuthor {
  String name;
  String email;
  String date;

  CommitAuthor({
    required this.name,
    required this.email,
    required this.date,
  });

  factory CommitAuthor.fromJson(Map<String, dynamic> json) => CommitAuthor(
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        date: json["date"],
      );

}

enum Email {
  DEV_JULIANGONGGRIJP_COM,
  NOREPLY_GITHUB_COM,
  ROKUSU_GMAIL_COM,
  ROOT_DELPHI_LAN,
  SAMUEL_WILLIAMS_ORIONTRANSFER_CO_NZ,
  THE_95467104_ANOMAL00_US_USERS_NOREPLY_GITHUB_COM
}

final emailValues = EnumValues({
  "dev@juliangonggrijp.com": Email.DEV_JULIANGONGGRIJP_COM,
  "noreply@github.com": Email.NOREPLY_GITHUB_COM,
  "rokusu@gmail.com": Email.ROKUSU_GMAIL_COM,
  "root@delphi.lan": Email.ROOT_DELPHI_LAN,
  "samuel.williams@oriontransfer.co.nz":
      Email.SAMUEL_WILLIAMS_ORIONTRANSFER_CO_NZ,
  "95467104+anomal00us@users.noreply.github.com":
      Email.THE_95467104_ANOMAL00_US_USERS_NOREPLY_GITHUB_COM
});

enum Name {
  ANOMAL00_US,
  GIT_HUB,
  JULIAN_GONGGRIJP,
  RICARDO_MENDES,
  ROOT,
  SAMUEL_WILLIAMS
}

final nameValues = EnumValues({
  "anomal00us": Name.ANOMAL00_US,
  "GitHub": Name.GIT_HUB,
  "Julian Gonggrijp": Name.JULIAN_GONGGRIJP,
  "Ricardo Mendes": Name.RICARDO_MENDES,
  "root": Name.ROOT,
  "Samuel Williams": Name.SAMUEL_WILLIAMS
});

class Tree {
  String sha;
  String url;

  Tree({
    required this.sha,
    required this.url,
  });

  factory Tree.fromJson(Map<String, dynamic> json) => Tree(
        sha: json["sha"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "sha": sha,
        "url": url,
      };
}

class Verification {
  bool verified;
  Reason reason;
  String? signature;
  String? payload;

  Verification({
    required this.verified,
    required this.reason,
    required this.signature,
    required this.payload,
  });

  factory Verification.fromJson(Map<String, dynamic> json) => Verification(
        verified: json["verified"],
        reason: reasonValues.map[json["reason"]]!,
        signature: json["signature"],
        payload: json["payload"],
      );

  Map<String, dynamic> toJson() => {
        "verified": verified,
        "reason": reasonValues.reverse[reason],
        "signature": signature,
        "payload": payload,
      };
}

enum Reason { UNSIGNED, VALID }

final reasonValues =
    EnumValues({"unsigned": Reason.UNSIGNED, "valid": Reason.VALID});

class Parent {
  String sha;
  String url;
  String htmlUrl;

  Parent({
    required this.sha,
    required this.url,
    required this.htmlUrl,
  });

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
        sha: json["sha"],
        url: json["url"],
        htmlUrl: json["html_url"],
      );

  Map<String, dynamic> toJson() => {
        "sha": sha,
        "url": url,
        "html_url": htmlUrl,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
