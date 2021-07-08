class User {
    String email;
    bool isBindEmail;
    String userNo;
    String vipEndAt;

    User({required this.email, required this.isBindEmail, required this.userNo, required this.vipEndAt});

    factory User.fromJson(Map<String, dynamic> json) {
        return User(
            email: json['email'], 
            isBindEmail: json['isBindEmail'], 
            userNo: json['userNo'], 
            vipEndAt: json['vipEndAt'], 
        );
    }

    Map<String, dynamic> toJson() {
        final data = <String, dynamic>{};
        data['email'] = email;
        data['isBindEmail'] = isBindEmail;
        data['userNo'] = userNo;
        data['vipEndAt'] = vipEndAt;
        return data;
    }
}