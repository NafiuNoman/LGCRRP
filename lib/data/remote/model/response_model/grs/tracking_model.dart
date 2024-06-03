import 'package:com.lged.lgcrrp.misulgi/data/remote/model/common_response.dart';

class TrackingModel extends CommonResponse {
  String? complaintStatus;
  TrackInfoModel? complaint;

  TrackingModel(
      {required super.code, required super.message, this.complaintStatus, this.complaint});

  factory TrackingModel.fromJson(Map<String, dynamic> json)=>
      TrackingModel(code: json['code'],
          message: json['message'],
          complaintStatus: json['complaintStatus'],
          complaint: json['complaint']!=null?  TrackInfoModel.fromJson(json['complaint']):null);


}

class TrackInfoModel {
  String? grs_submission_date;
  String? grs_tracking_number;
  String? process_remarks;
  String? process_status;
  String? process_remediation_feedback;
  String? process_remediation_date;

  TrackInfoModel({this.grs_submission_date, this.grs_tracking_number,
    this.process_remarks, this.process_status,
    this.process_remediation_feedback, this.process_remediation_date});

  factory TrackInfoModel.fromJson(Map<String, dynamic> json)=>
      TrackInfoModel(grs_submission_date: json['grs_submission_date'],
          grs_tracking_number: json['grs_tracking_number'],
          process_remarks: json['process_remarks'],
          process_status: json['process_status'],
          process_remediation_feedback: json['process_remediation_feedback'],
          process_remediation_date: json['process_remediation_date']
      );


}
