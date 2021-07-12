/// inviteCode : "4TLDX"
/// inviteUrl : "http://google.com"
/// inviteCount : 0
/// totalPoint : 0

class InviteInfoResp {
  String? _inviteCode;
  String? _inviteUrl;
  int? _inviteCount;
  int? _totalPoint;

  String? get inviteCode => _inviteCode;
  String? get inviteUrl => _inviteUrl;
  int? get inviteCount => _inviteCount;
  int? get totalPoint => _totalPoint;

  InviteInfoResp({
      String? inviteCode, 
      String? inviteUrl, 
      int? inviteCount, 
      int? totalPoint}){
    _inviteCode = inviteCode;
    _inviteUrl = inviteUrl;
    _inviteCount = inviteCount;
    _totalPoint = totalPoint;
}

  InviteInfoResp.fromJson(dynamic json) {
    _inviteCode = json['inviteCode'];
    _inviteUrl = json['inviteUrl'];
    _inviteCount = json['inviteCount'];
    _totalPoint = json['totalPoint'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['inviteCode'] = _inviteCode;
    map['inviteUrl'] = _inviteUrl;
    map['inviteCount'] = _inviteCount;
    map['totalPoint'] = _totalPoint;
    return map;
  }

}