class SendCodeResp {
    String token;

    SendCodeResp({required this.token});

    factory SendCodeResp.fromJson(Map<String, dynamic> json) {
        return SendCodeResp(
            token: json['token'], 
        );
    }

    Map<String, dynamic> toJson() {
        final data = <String, dynamic>{};
        data['token'] = token;
        return data;
    }
}