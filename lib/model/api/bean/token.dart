import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

///run "flutter pub run build_runner build" to generate login_resp.g.dart
part 'token.g.dart';

@JsonSerializable()
class Token extends Equatable {
  @JsonKey(name: 'accessToken')
  final String accessToken;
  @JsonKey(name: 'accessTokenExpireAt')
  final String accessTokenExpireAt;
  @JsonKey(name: 'refreshToken')
  final String refreshToken;
  @JsonKey(name: 'refreshTokenExpireAt')
  final String refreshTokenExpireAt;

  Token(this.accessToken, this.accessTokenExpireAt, this.refreshToken, this.refreshTokenExpireAt);

  @override
  List<Object?> get props => [accessToken, accessTokenExpireAt, refreshToken, refreshTokenExpireAt];

  @override
  String toString() {
    return 'token{accessToken: $accessToken, accessTokenExpireAt: $accessTokenExpireAt, refreshToken: $refreshToken, refreshTokenExpireAt: $refreshTokenExpireAt}';
  }

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);

  static Token fromJsonModel(Map<String, dynamic> json) => Token.fromJson(json);

}