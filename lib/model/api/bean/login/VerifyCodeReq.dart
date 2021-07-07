class VerifyCodeReq {
    String code;
    String token;

    VerifyCodeReq({required this.code, required this.token});

    factory VerifyCodeReq.fromJson(Map<String, dynamic> json) {
        return VerifyCodeReq(
            code: json['code'], 
            token: json['token'], 
        );
    }

    Map<String, dynamic> toJson() {
        final data = <String, dynamic>{};
        data['code'] = code;
        data['token'] = token;
        return data;
    }
}