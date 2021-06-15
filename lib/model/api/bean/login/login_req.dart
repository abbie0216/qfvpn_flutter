
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_req.g.dart';

// {
//   "email": "sion.wang@silkrode.com.tw",
//   "device": {
//     "ua": "string",
//     "os_type": "android",
//     "os_version": "string",
//     "make": "string",
//     "model": "string",
//     "brand": "string",
//     "connection_type": "none",
//     "carrier": "string",
//     "android_id": "string",
//     "idfa": "string",
//     "idfv": "string"
//   },
//   "password": "aa123456"
// }

///run "flutter pub run build_runner build" to generate login_req.g.dart

@JsonSerializable()
class LoginReq extends Equatable {
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'password')
  final String password;

  LoginReq(this.email, this.password);

  @override
  List<Object?> get props => [email];

  @override
  String toString() {
    return 'LoginReq{email: $email, password: $password}';
  }

  factory LoginReq.fromJson(Map<String, dynamic> json) => _$LoginReqFromJson(json);

  Map<String, dynamic> toJson() => _$LoginReqToJson(this);
}