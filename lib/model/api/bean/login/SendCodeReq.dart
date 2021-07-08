class SendCodeReq {
    String email;

    SendCodeReq({required this.email});

    factory SendCodeReq.fromJson(Map<String, dynamic> json) {
        return SendCodeReq(
            email: json['email'], 
        );
    }

    Map<String, dynamic> toJson() {
        final data = <String, dynamic>{};
        data['email'] = email;
        return data;
    }
}