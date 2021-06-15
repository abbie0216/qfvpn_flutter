import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

///run "flutter pub run build_runner build" to generate login_resp.g.dart
part 'login_resp.g.dart';

@JsonSerializable()
class LoginResp extends Equatable {
  @JsonKey(name: 'accessToken')
  final String accessToken;
  @JsonKey(name: 'accessTokenExpireAt')
  final String accessTokenExpireAt;
  @JsonKey(name: 'refreshToken')
  final String refreshToken;
  @JsonKey(name: 'refreshTokenExpireAt')
  final String refreshTokenExpireAt;

  LoginResp(this.accessToken, this.accessTokenExpireAt, this.refreshToken, this.refreshTokenExpireAt);

  @override
  List<Object?> get props => [accessToken, accessTokenExpireAt, refreshToken, refreshTokenExpireAt];

  @override
  String toString() {
    return 'LoginResp{accessToken: $accessToken, accessTokenExpireAt: $accessTokenExpireAt, refreshToken: $refreshToken, refreshTokenExpireAt: $refreshTokenExpireAt}';
  }

  factory LoginResp.fromJson(Map<String, dynamic> json) => _$LoginRespFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRespToJson(this);

  static LoginResp fromJsonModel(Map<String, dynamic> json) => LoginResp.fromJson(json);

}