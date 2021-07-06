class RefreshTokenReq {
    String refreshToken;

    RefreshTokenReq({required this.refreshToken});

    factory RefreshTokenReq.fromJson(Map<String, dynamic> json) {
        return RefreshTokenReq(
            refreshToken: json['refreshToken'],
        );
    }

    Map<String, dynamic> toJson() {
        final data = <String, dynamic>{};
        data['refreshToken'] = refreshToken;
        return data;
    }
}