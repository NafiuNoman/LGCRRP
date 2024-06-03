import 'package:com.lged.lgcrrp.misulgi/data/remote/model/contact_super_model.dart';

class OtpModel {
  final int code;
  final String message;
  final int otp_code;
  final int otp_expiry_time_in_minute;
  final int contact_id;
  final ContactModel? contact_details;

  OtpModel(
      {required this.code,
      required this.message,
      required this.otp_code,
      required this.otp_expiry_time_in_minute,
      required this.contact_id,
      required this.contact_details});

  factory OtpModel.fromJson(Map<String, dynamic> map) {
    return OtpModel(
      code: map["code"],
      message: map["message"],
      otp_code: map["otp_code"],
      otp_expiry_time_in_minute: map['otp_expiry_time_in_minute'],
      contact_id: map['contact_id'] ?? 0,//if null set 0;
      contact_details: map['contact_details'] != null
          ? ContactModel.fromJson(map['contact_details'])
          : null,
    );
  }

}
