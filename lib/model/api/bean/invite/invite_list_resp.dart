/// items : [{"inviteAt":"2021-07-09T06:49:51.522Z","email":"string","point":0}]
/// totalCount : 0
/// pageSize : 0
/// pageNo : 0
/// totalPage : 0

class InviteListResp {
  List<Items>? _items;
  int? _totalCount;
  int? _pageSize;
  int? _pageNo;
  int? _totalPage;

  List<Items>? get items => _items;
  int? get totalCount => _totalCount;
  int? get pageSize => _pageSize;
  int? get pageNo => _pageNo;
  int? get totalPage => _totalPage;

  InviteListResp({
      List<Items>? items, 
      int? totalCount, 
      int? pageSize, 
      int? pageNo, 
      int? totalPage}){
    _items = items;
    _totalCount = totalCount;
    _pageSize = pageSize;
    _pageNo = pageNo;
    _totalPage = totalPage;
}

  InviteListResp.fromJson(dynamic json) {
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(Items.fromJson(v));
      });
    }
    _totalCount = json['totalCount'];
    _pageSize = json['pageSize'];
    _pageNo = json['pageNo'];
    _totalPage = json['totalPage'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_items != null) {
      map['items'] = _items?.map((v) => v.toJson()).toList();
    }
    map['totalCount'] = _totalCount;
    map['pageSize'] = _pageSize;
    map['pageNo'] = _pageNo;
    map['totalPage'] = _totalPage;
    return map;
  }

}

/// inviteAt : "2021-07-09T06:49:51.522Z"
/// email : "string"
/// point : 0

class Items {
  String? _inviteAt;
  String? _email;
  int? _point;

  String? get inviteAt => _inviteAt;
  String? get email => _email;
  int? get point => _point;

  Items({
      String? inviteAt, 
      String? email, 
      int? point}){
    _inviteAt = inviteAt;
    _email = email;
    _point = point;
}

  Items.fromJson(dynamic json) {
    _inviteAt = json['inviteAt'];
    _email = json['email'];
    _point = json['point'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['inviteAt'] = _inviteAt;
    map['email'] = _email;
    map['point'] = _point;
    return map;
  }

}