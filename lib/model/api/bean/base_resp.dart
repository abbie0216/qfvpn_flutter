import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

///run "flutter pub run build_runner build" to generate base_resp.g.dart
part 'base_resp.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResp<T> extends Equatable {
  @JsonKey(name: 'errCode')
  final String errCode;
  @JsonKey(name: 'errMsg')
  final String errMsg;
  @JsonKey(name: 'data')
  final T data;

  BaseResp(this.errCode, this.errMsg, this.data);

  @override
  List<Object?> get props => [errCode, errMsg, data];

  @override
  String toString() {
    return 'BaseResp{errCode: $errCode, errMsg: $errMsg, data: $data}';
  }

  factory BaseResp.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseRespFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$BaseRespToJson(this, toJsonT);
}
