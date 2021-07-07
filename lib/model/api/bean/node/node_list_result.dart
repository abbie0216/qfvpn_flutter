/// items : [{"nodeId":2,"name":"台湾","country":"cn","loadLevel":2},{"nodeId":3,"name":"CN-GD-广东-183-aliyun.com","country":"cn","loadLevel":3},{"nodeId":4,"name":"CN-TW-台湾-35-cht.com.tw","country":"tw","loadLevel":3},{"nodeId":5,"name":"JP-日本-东京-150","country":"jp","loadLevel":3},{"nodeId":6,"name":"USA-美国-费利蒙-9","country":"us","loadLevel":3},{"nodeId":7,"name":"USA-美国-洛杉矶-147","country":"us","loadLevel":3},{"nodeId":8,"name":"USA-美国-纽瓦克-3","country":"us","loadLevel":3},{"nodeId":9,"name":"NLD-荷兰-阿姆斯特丹-66","country":"us","loadLevel":3},{"nodeId":10,"name":"@SSRSUB-加拿大ssr01","country":"CA","loadLevel":3},{"nodeId":11,"name":"@SSRSUB-台湾ssr09","country":"tw","loadLevel":3},{"nodeId":1,"name":"123","country":"us","loadLevel":1}]

class NodeListResult {
  List<Items>? _items;

  List<Items>? get items => _items;

  NodeListResult({List<Items>? items}) {
    _items = items;
  }

  NodeListResult.fromJson(dynamic json) {
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_items != null) {
      map['items'] = _items?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// nodeId : 2
/// name : "台湾"
/// country : "cn"
/// loadLevel : 2

class Items {
  int? _nodeId;
  String? _name;
  String? _country;
  int? _loadLevel;

  int? get nodeId => _nodeId;

  String? get name => _name;

  String? get country => _country;

  int? get loadLevel => _loadLevel;

  Items({int? nodeId, String? name, String? country, int? loadLevel}) {
    _nodeId = nodeId;
    _name = name;
    _country = country;
    _loadLevel = loadLevel;
  }

  Items.fromJson(dynamic json) {
    _nodeId = json['nodeId'];
    _name = json['name'];
    _country = json['country'];
    _loadLevel = json['loadLevel'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['nodeId'] = _nodeId;
    map['name'] = _name;
    map['country'] = _country;
    map['loadLevel'] = _loadLevel;
    return map;
  }
}
