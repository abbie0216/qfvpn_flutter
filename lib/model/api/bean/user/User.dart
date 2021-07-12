class User {
    String email;
    bool isBindEmail;
    String userNo;
    String vipEndAt;
    bool isVip;
    bool isVipExpired;

    User({required this.email, required this.isBindEmail, required this.userNo, required this.vipEndAt, required this.isVip, required this.isVipExpired});

    factory User.fromJson(Map<String, dynamic> json) {
        return User(
            email: json['email'], 
            isBindEmail: json['isBindEmail'], 
            userNo: json['userNo'], 
            vipEndAt: json['vipEndAt'],
            isVip: json['isVip'],
            isVipExpired: json['isVipExpired']
        );
    }

    Map<String, dynamic> toJson() {
        final data = <String, dynamic>{};
        data['email'] = email;
        data['isBindEmail'] = isBindEmail;
        data['userNo'] = userNo;
        data['vipEndAt'] = vipEndAt;
        data['isVip'] = isVip;
        data['isVipExpired'] = isVipExpired;
        return data;
    }
}