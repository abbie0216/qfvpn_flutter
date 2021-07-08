class ResetPasswordReq {
    String email;
    String newPassword;
    String token;
    String verifyCode;

    ResetPasswordReq({required this.email, required this.newPassword, required this.token, required this.verifyCode});

    factory ResetPasswordReq.fromJson(Map<String, dynamic> json) {
        return ResetPasswordReq(
            email: json['email'], 
            newPassword: json['newPassword'], 
            token: json['token'], 
            verifyCode: json['verifyCode'], 
        );
    }

    Map<String, dynamic> toJson() {
        final data = <String, dynamic>{};
        data['email'] = email;
        data['newPassword'] = newPassword;
        data['token'] = token;
        data['verifyCode'] = verifyCode;
        return data;
    }
}