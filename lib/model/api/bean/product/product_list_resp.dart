import 'package:flutter_fimber/flutter_fimber.dart';

/// items : [{"productId":4,"price":400,"itemName":"360天VIP","monthPrice":25,"isNewCustomer":false,"extraDays":360,"coupons":[]},{"productId":2,"price":120,"itemName":"90天VIP","monthPrice":30,"isNewCustomer":false,"extraDays":90,"coupons":[{"userCouponId":70,"couponId":2,"status":0,"statusLabel":"未使用","title":"90天优惠券","reduceAmount":20,"minThreshold":0,"thresholdText":"90天VIP可用","validStartAt":"2021-06-11T08:37:06.509Z","validEndAt":"2021-07-11T08:37:06.509Z"},{"userCouponId":71,"couponId":2,"status":0,"statusLabel":"未使用","title":"90天优惠券","reduceAmount":20,"minThreshold":0,"thresholdText":"90天VIP可用","validStartAt":"2021-06-11T08:37:06.509Z","validEndAt":"2021-07-11T08:37:06.509Z"},{"userCouponId":72,"couponId":2,"status":0,"statusLabel":"未使用","title":"90天优惠券","reduceAmount":20,"minThreshold":0,"thresholdText":"90天VIP可用","validStartAt":"2021-06-11T08:37:06.509Z","validEndAt":"2021-07-11T08:37:06.509Z"}]},{"productId":5,"price":40,"itemName":"30天VIP","monthPrice":40,"isNewCustomer":true,"extraDays":0,"coupons":[{"userCouponId":67,"couponId":1,"status":0,"statusLabel":"未使用","title":"30天优惠券","reduceAmount":10,"minThreshold":0,"thresholdText":"30天VIP可用","validStartAt":"2021-06-11T08:36:27.456Z","validEndAt":"2021-07-11T08:36:27.456Z"},{"userCouponId":68,"couponId":1,"status":0,"statusLabel":"未使用","title":"30天优惠券","reduceAmount":10,"minThreshold":0,"thresholdText":"30天VIP可用","validStartAt":"2021-06-11T08:36:27.456Z","validEndAt":"2021-07-11T08:36:27.456Z"},{"userCouponId":69,"couponId":1,"status":0,"statusLabel":"未使用","title":"30天优惠券","reduceAmount":10,"minThreshold":0,"thresholdText":"30天VIP可用","validStartAt":"2021-06-11T08:36:27.456Z","validEndAt":"2021-07-11T08:36:27.456Z"}]},{"productId":3,"price":240,"itemName":"180天VIP","monthPrice":28,"isNewCustomer":true,"extraDays":181,"coupons":[{"userCouponId":73,"couponId":3,"status":0,"statusLabel":"未使用","title":"180天优惠券","reduceAmount":40,"minThreshold":0,"thresholdText":"180天VIP可用","validStartAt":"2021-06-11T08:39:24.754Z","validEndAt":"2021-07-11T08:39:24.754Z"},{"userCouponId":74,"couponId":3,"status":0,"statusLabel":"未使用","title":"180天优惠券","reduceAmount":40,"minThreshold":0,"thresholdText":"180天VIP可用","validStartAt":"2021-06-11T08:39:24.754Z","validEndAt":"2021-07-11T08:39:24.754Z"},{"userCouponId":75,"couponId":3,"status":0,"statusLabel":"未使用","title":"180天优惠券","reduceAmount":40,"minThreshold":0,"thresholdText":"180天VIP可用","validStartAt":"2021-06-11T08:39:24.754Z","validEndAt":"2021-07-11T08:39:24.754Z"},{"userCouponId":76,"couponId":3,"status":0,"statusLabel":"未使用","title":"180天优惠券","reduceAmount":40,"minThreshold":0,"thresholdText":"180天VIP可用","validStartAt":"2021-06-11T08:39:24.754Z","validEndAt":"2021-07-11T08:39:24.754Z"},{"userCouponId":77,"couponId":3,"status":0,"statusLabel":"未使用","title":"180天优惠券","reduceAmount":40,"minThreshold":0,"thresholdText":"180天VIP可用","validStartAt":"2021-06-11T08:39:24.754Z","validEndAt":"2021-07-11T08:39:24.754Z"}]}]

class ProductListResp {
  List<Items>? _items;

  List<Items>? get items => _items;

  ProductListResp({
      List<Items>? items}){
    _items = items;
}

  ProductListResp.fromJson(dynamic json) {
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

/// productId : 4
/// price : 400
/// itemName : "360天VIP"
/// monthPrice : 25
/// isNewCustomer : false
/// extraDays : 360
/// coupons : []

class Items {
  int? _productId;
  int? _price;
  String? _itemName;
  int? _monthPrice;
  bool? _isNewCustomer;
  int? _extraDays;
  List<Coupon>? _coupons;

  int? get productId => _productId;
  int? get price => _price;
  String? get itemName => _itemName;
  int? get monthPrice => _monthPrice;
  bool? get isNewCustomer => _isNewCustomer;
  int? get extraDays => _extraDays;
  List<Coupon>? get coupons => _coupons;

  Items({
      int? productId, 
      int? price, 
      String? itemName, 
      int? monthPrice, 
      bool? isNewCustomer, 
      int? extraDays, 
      List<Coupon>? coupons}){
    _productId = productId;
    _price = price;
    _itemName = itemName;
    _monthPrice = monthPrice;
    _isNewCustomer = isNewCustomer;
    _extraDays = extraDays;
    _coupons = coupons;
}

  Items.fromJson(dynamic json) {
    _productId = json['productId'];
    _price = json['price'];
    _itemName = json['itemName'];
    _monthPrice = json['monthPrice'];
    _isNewCustomer = json['isNewCustomer'];
    _extraDays = json['extraDays'];
    if (json['coupons'] != null) {
      _coupons = [];
      json['coupons'].forEach((v) {
        _coupons?.add(Coupon.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['productId'] = _productId;
    map['price'] = _price;
    map['itemName'] = _itemName;
    map['monthPrice'] = _monthPrice;
    map['isNewCustomer'] = _isNewCustomer;
    map['extraDays'] = _extraDays;
    if (_coupons != null) {
      map['coupons'] = _coupons?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// userCouponId : 70
/// couponId : 2
/// status : 0
/// statusLabel : "未使用"
/// title : "90天优惠券"
/// reduceAmount : 20
/// minThreshold : 0
/// thresholdText : "90天VIP可用"
/// validStartAt : "2021-06-11T08:37:06.509Z"
/// validEndAt : "2021-07-11T08:37:06.509Z"

class Coupon {
  int? _userCouponId;
  int? _couponId;
  int? _status;
  String? _statusLabel;
  String? _title;
  int? _reduceAmount;
  int? _minThreshold;
  String? _thresholdText;
  String? _validStartAt;
  String? _validEndAt;

  int? get userCouponId => _userCouponId;
  int? get couponId => _couponId;
  int? get status => _status;
  String? get statusLabel => _statusLabel;
  String? get title => _title;
  int? get reduceAmount => _reduceAmount;
  int? get minThreshold => _minThreshold;
  String? get thresholdText => _thresholdText;
  String? get validStartAt => _validStartAt;
  String? get validEndAt => _validEndAt;

  Coupon({
    int? userCouponId,
    int? couponId,
    int? status,
    String? statusLabel,
    String? title,
    int? reduceAmount,
    int? minThreshold,
    String? thresholdText,
    String? validStartAt,
    String? validEndAt}){
    _userCouponId = userCouponId;
    _couponId = couponId;
    _status = status;
    _statusLabel = statusLabel;
    _title = title;
    _reduceAmount = reduceAmount;
    _minThreshold = minThreshold;
    _thresholdText = thresholdText;
    _validStartAt = validStartAt;
    _validEndAt = validEndAt;
  }

  Coupon.fromJson(dynamic json) {
    _userCouponId = json['userCouponId'];
    _couponId = json['couponId'];
    _status = json['status'];
    _statusLabel = json['statusLabel'];
    _title = json['title'];
    _reduceAmount = json['reduceAmount'];
    _minThreshold = json['minThreshold'];
    _thresholdText = json['thresholdText'];
    _validStartAt = json['validStartAt'];
    _validEndAt = json['validEndAt'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['userCouponId'] = _userCouponId;
    map['couponId'] = _couponId;
    map['status'] = _status;
    map['statusLabel'] = _statusLabel;
    map['title'] = _title;
    map['reduceAmount'] = _reduceAmount;
    map['minThreshold'] = _minThreshold;
    map['thresholdText'] = _thresholdText;
    map['validStartAt'] = _validStartAt;
    map['validEndAt'] = _validEndAt;
    return map;
  }

}