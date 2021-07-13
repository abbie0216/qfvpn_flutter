import 'package:qfvpn/model/api/bean/product/product_list_resp.dart';

class UserCouponListResp {
  List<Coupon>? coupons;
  int pageNo;
  int pageSize;
  int totalCount;
  int totalPage;

  UserCouponListResp(
      {this.coupons,
      required this.pageNo,
      required this.pageSize,
      required this.totalCount,
      required this.totalPage});

  factory UserCouponListResp.fromJson(Map<String, dynamic> json) {
    return UserCouponListResp(
      coupons: json['items'] != null
          ? (json['items'] as List).map((i) => Coupon.fromJson(i)).toList()
          : null,
      pageNo: json['pageNo'],
      pageSize: json['pageSize'],
      totalCount: json['totalCount'],
      totalPage: json['totalPage'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['pageNo'] = pageNo;
    data['pageSize'] = pageSize;
    data['totalCount'] = totalCount;
    data['totalPage'] = totalPage;
    if (coupons != null) {
      data['items'] = coupons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

