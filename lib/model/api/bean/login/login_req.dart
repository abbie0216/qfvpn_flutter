import 'dart:convert';

LoginReq loginReqFromJson(String str) => LoginReq.fromJson(json.decode(str));

String loginReqToJson(LoginReq data) => json.encode(data.toJson());

class LoginReq {
  LoginReq({
    required this.email,
    required this.password,
    this.device,
  });

  final String email;
  Device? device;
  final String password;

  factory LoginReq.fromJson(Map<String, dynamic> json) => LoginReq(
    email: json['email'],
    device: json['device'] == null ? null : Device.fromJson(json['device']),
    password: json['password'],
  );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    if (device != null) {
      data['device'] = device!.toJson();
    }
    data['password'] = password;
    return data;
  }
}

class Device {
  Device({
    required this.ua,
    required this.osType,
    required this.osVersion,
    required this.make,
    required this.model,
    required this.brand,
    required this.connectionType,
    required this.carrier,
    required this.androidId,
    required this.idfa,
    required this.idfv,
  });

  final String ua;
  final String osType;
  final String osVersion;
  final String make;
  final String model;
  final String brand;
  final String connectionType;
  final String carrier;
  final String androidId;
  final String idfa;
  final String idfv;

  factory Device.fromJson(Map<String, dynamic> json) => Device(
    ua: json['ua'],
    osType: json['osType'],
    osVersion: json['osVersion'],
    make: json['make'],
    model: json['model'],
    brand: json['brand'],
    connectionType: json['connectionType'],
    carrier: json['carrier'],
    androidId: json['androidId'],
    idfa: json['idfa'],
    idfv: json['idfv'],
  );

  Map<String, dynamic> toJson() => {
    'ua': ua,
    'osType': osType,
    'osVersion': osVersion,
    'make': make,
    'model': model,
    'brand': brand,
    'connectionType': connectionType,
    'carrier': carrier,
    'androidId': androidId,
    'idfa': idfa,
    'idfv': idfv,
  };
}
