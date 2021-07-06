class RefreshTokenResp {
    String accessToken;
    String accessTokenExpireAt;

    RefreshTokenResp({required this.accessToken, required this.accessTokenExpireAt});

    factory RefreshTokenResp.fromJson(Map<String, dynamic> json) {
        return RefreshTokenResp(
            accessToken: json['accessToken'], 
            accessTokenExpireAt: json['accessTokenExpireAt'], 
        );
    }

    Map<String, dynamic> toJson() {
        final data = <String, dynamic>{};
        data['accessToken'] = accessToken;
        data['accessTokenExpireAt'] = accessTokenExpireAt;
        return data;
    }
}