
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_req.g.dart';

// {
// "inviteCode": "string",
// "email": "string",
// "password": "string"
// }

///run "flutter pub run build_runner build" to generate register_req.g.dart

@JsonSerializable()
class RegisterReq extends Equatable {
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'password')
  final String password;
  @JsonKey(name: 'inviteCode')
  final String inviteCode;

  RegisterReq(this.email, this.password, this.inviteCode);

  @override
  List<Object?> get props => [email];

  @override
  String toString() {
    return 'RegisterReq{email: $email, password: $password, inviteCode: $inviteCode}';
  }

  factory RegisterReq.fromJson(Map<String, dynamic> json) => _$RegisterReqFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterReqToJson(this);
}