import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_resp.g.dart';

@JsonSerializable()
class RegisterResp extends Equatable {
  @JsonKey(name: 'userId')
  final int userId;

  RegisterResp(this.userId);

  @override
  List<Object?> get props => [userId];

  factory RegisterResp.fromJson(Map<String, dynamic> json) => _$RegisterRespFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRespToJson(this);

  static RegisterResp fromJsonModel(Map<String, dynamic> json) => RegisterResp.fromJson(json);

}