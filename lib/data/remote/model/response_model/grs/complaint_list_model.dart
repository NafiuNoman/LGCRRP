import 'package:floor/floor.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/common_response.dart';

class ComplaintListModel extends CommonResponse {
  ComplaintDataModel complaintList;

  ComplaintListModel(
      {required super.code,
      required super.message,
      required this.complaintList});

  factory ComplaintListModel.fromJson(Map<String, dynamic> json) =>
      ComplaintListModel(
          code: json['code'],
          message: json['message'],
          complaintList: ComplaintDataModel.fromJson(json['complaintList']));
}

class ComplaintDataModel {
  int? current_page;
  int? last_page;
  List<ComplaintDetailsModel>? data;

  ComplaintDataModel({this.current_page, this.last_page, this.data});

  factory ComplaintDataModel.fromJson(Map<String, dynamic> json) =>
      ComplaintDataModel(
          current_page: json['current_page'],
          last_page: json['last_page'],
          data: List.from(json['data'])
              .map((e) => ComplaintDetailsModel.fromJson(e))
              .toList());
}

@Entity(tableName: 'complaint')
class ComplaintDetailsModel {
  @primaryKey
  final int id;
  final String tracking_number;
  final String complaint_submit_date;
  final int division_id;
  final int district_id;
  final int organogram_id;
  final String site_office;
  final int complaint_type_id;
  final String complaint_title;
  final String complaint_explanation;
  final String? complainant_name;
  final String? complainant_email;
  final String? complainant_phone;
  final String? complainant_address;
  final String submission_media;
  final String complaint_status;
  final String division_name_en;
  final String districts_name_en;
  final String organogram_name_en;

  ComplaintDetailsModel(
      {required this.id,
      required this.tracking_number,
      required this.complaint_submit_date,
      required this.division_id,
      required this.district_id,
      required this.organogram_id,
      required this.site_office,
      required this.complaint_type_id,
      required this.complaint_title,
      required this.complaint_explanation,
      required this.submission_media,
      required this.complaint_status,
      this.complainant_name,
      this.complainant_email,
      this.complainant_phone,
      this.complainant_address,
      required this.division_name_en,
      required this.districts_name_en,
      required this.organogram_name_en});

  factory ComplaintDetailsModel.fromJson(Map<String, dynamic> json) =>
      ComplaintDetailsModel(
        id: json['id'],
        tracking_number: json['tracking_number'],
        complaint_submit_date: json['complaint_submit_date'],
        division_id: json['division_id'],
        district_id: json['district_id'],
        organogram_id: json['organogram_id'],
        site_office: json['site_office'],
        complaint_type_id: json['complaint_type_id'],
        complaint_title: json['complaint_title'],
        complaint_explanation: json['complaint_explanation'],
        submission_media: json['submission_media'],
        complaint_status: json['complaint_status'],
        districts_name_en: json['districts_name_en'],
        division_name_en: json['division_name_en'],
        organogram_name_en: json['organogram_name_en'],
        complainant_phone: json['complainant_phone'],
        complainant_address: json['complainant_address'],
        complainant_email: json['complainant_email'],
        complainant_name: json['complainant_name'],

      );
}
