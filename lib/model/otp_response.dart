class OTPResponse {
  String type;
  String message;
  int timeleft;
  String phoneOtpValidUntil;

  OTPResponse(
      {this.type, this.message, this.timeleft, this.phoneOtpValidUntil});

  OTPResponse.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    message = json['message'];
    timeleft = json['timeleft'];
    phoneOtpValidUntil = json['phone_otp_valid_until'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['message'] = this.message;
    data['timeleft'] = this.timeleft;
    data['phone_otp_valid_until'] = this.phoneOtpValidUntil;
    return data;
  }
}
