class ChangePasswordReq {
    String newPassword;
    String oldPassword;

    ChangePasswordReq({required this.newPassword, required this.oldPassword});

    factory ChangePasswordReq.fromJson(Map<String, dynamic> json) {
        return ChangePasswordReq(
            newPassword: json['newPassword'], 
            oldPassword: json['oldPassword'], 
        );
    }

    Map<String, dynamic> toJson() {
        final data = <String, dynamic>{};
        data['newPassword'] = newPassword;
        data['oldPassword'] = oldPassword;
        return data;
    }
}