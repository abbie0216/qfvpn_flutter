import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

///run "flutter pub run build_runner build" to generate user.g.dart
part 'user.g.dart';

/// {
///     "login": "octocat",
///     "id": 1,
///     "node_id": "MDQ6VXNlcjE=",
///     "avatar_url": "https://github.com/images/error/octocat_happy.gif",
///     "gravatar_id": "",
///     "url": "https://api.github.com/users/octocat",
///     "html_url": "https://github.com/octocat",
///     "followers_url": "https://api.github.com/users/octocat/followers",
///     "following_url": "https://api.github.com/users/octocat/following{/other_user}",
///     "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
///     "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
///     "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
///     "organizations_url": "https://api.github.com/users/octocat/orgs",
///     "repos_url": "https://api.github.com/users/octocat/repos",
///     "events_url": "https://api.github.com/users/octocat/events{/privacy}",
///     "received_events_url": "https://api.github.com/users/octocat/received_events",
///     "type": "User",
///     "site_admin": false
/// }

@JsonSerializable()
class User extends Equatable {
  @JsonKey(name:'login')
  final String login;
  @JsonKey(name:'id')
  final int id;
  @JsonKey(name:'node_id')
  final String nodeId;
  @JsonKey(name:'avatar_url')
  final String avatarUrl;
  @JsonKey(name:'gravatar_id')
  final String gravatarId;
  @JsonKey(name:'type')
  final String type;
  @JsonKey(name:'site_admin')
  final bool siteAdmin;

  const User({
    this.login = "",
    this.id = 0,
    this.nodeId = "",
    this.avatarUrl = "",
    this.gravatarId = "",
    this.type = "",
    this.siteAdmin = false,
  });

  @override
  List<Object> get props => [id];

  @override
  String toString() {
    return 'User{login: $login, id: $id, nodeId: $nodeId, avatarUrl: $avatarUrl, gravatarId: $gravatarId, type: $type, siteAdmin: $siteAdmin}';
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
