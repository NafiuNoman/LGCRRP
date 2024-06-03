import 'package:floor/floor.dart';

class SchemeListModel {
  final int code;
  final String message;
  final SchemeDataModel schemesList;

  SchemeListModel({
    required this.code,
    required this.message,
    required this.schemesList,
  });

  factory SchemeListModel.fromJson(Map<String, dynamic> json) =>
      SchemeListModel(
          code: json['code'],
          message: json['message'],
          schemesList: SchemeDataModel.fromJson(json['schemesList']));
}

class SchemeDataModel {
  int? current_page;
  int? last_page;
  final List<Scheme>? data;

  SchemeDataModel({this.current_page, this.last_page, this.data});

  factory SchemeDataModel.fromJson(
          Map<String, dynamic> json) =>
      SchemeDataModel(
          current_page: json['current_page'],
          last_page: json['last_page'],
          data:
              List.from(json['data']).map((e) => Scheme.fromJson(e)).toList());
}

@Entity(tableName: "scheme")
class Scheme {
  @primaryKey
  final int id;
  final int division_id;
  final int district_id;
  final int? upazila_id;
  final int is_lipw;
  final int? organogram_id;
  final String scheme_name;
  final String scheme_status;

  final String? scheme_type_name_en;
  final String? scheme_type_name_bn;
  final String? scheme_work_type_en;
  final String? scheme_work_type_bn;

  final String? package_name_en;
  final String? package_name_bn;

  final String concurred_estimated_amount;
  final String contractor_name;
  final String contracted_amount;

  final String reporting_date;
  final String date_of_agreement;
  final String date_of_commencement;

  //
  final String date_commencement_of_work_planned;
  final String date_conceptual_proposal_submitted_to_pmu;
  final String date_final_proposal_submitted_to_pmu;
  final String date_proposal_approved_for_preparation_of_bid;
  final String date_invitation_of_bid;
  final String date_award_of_contract;
  final String safeguard_related_issues;
  final String remarks;
  final String piller_name_en;
  final int is_climate_risk_incorporated;
  final int has_safeguard_related_issues;
  final int? scheme_category_id;
  final int? scheme_sub_category_id;

  //

  final String date_of_planned_completion_date;
  final String date_of_actual_completion_date;

  final int number_of_male_beficiary;
  final int number_of_female_beficiary;

  @ignore
  final List<MyLatLng>? geo_tags_array;

  Scheme(
      {required this.id,
      required this.division_id,
      required this.district_id,
      this.upazila_id = 0,
      this.organogram_id = 0,
      this.is_lipw = 0,
      required this.scheme_name,
      required this.scheme_status,
      this.scheme_type_name_en,
      this.scheme_type_name_bn,
      this.scheme_work_type_en,
      this.scheme_work_type_bn,
      this.package_name_en,
      this.package_name_bn,
      this.concurred_estimated_amount = "0",
      this.contracted_amount = "0",
      this.contractor_name = "N/A",
      this.number_of_female_beficiary = 0,
      this.number_of_male_beficiary = 0,
      this.reporting_date = "N/A",
      this.date_of_agreement = "N/A",
      this.date_of_commencement = "N/A",
      this.date_of_planned_completion_date = "N/A",
      this.date_of_actual_completion_date = "N/A",
      this.geo_tags_array,
      this.date_commencement_of_work_planned = "N/A",
      this.date_conceptual_proposal_submitted_to_pmu = "N/A",
      this.date_final_proposal_submitted_to_pmu = "N/A",
      this.date_proposal_approved_for_preparation_of_bid = "N/A",
      this.date_invitation_of_bid = "N/A",
      this.date_award_of_contract = "N/A",
      this.safeguard_related_issues = 'N/A',
      this.remarks = 'N/A',
      this.is_climate_risk_incorporated = 0,
      this.has_safeguard_related_issues = 0,
      this.scheme_category_id,
      this.scheme_sub_category_id,this.piller_name_en="N/A"});

  factory Scheme.fromJson(Map<String, dynamic> json) => Scheme(
        id: json['id'],
        division_id: json['division_id'],
        district_id: json['district_id'],
        upazila_id: json['upazila_id'] ?? 0,
        is_lipw: json['is_lipw'] ?? 0,
        organogram_id: json['organogram_id'] ?? 0,
        scheme_name: json['scheme_name'],
        scheme_status: json['scheme_status'],
        scheme_type_name_en: json['scheme_type_name_en'],
        scheme_type_name_bn: json['scheme_type_name_bn'],
        scheme_work_type_bn: json['scheme_work_type_bn'],
        scheme_work_type_en: json['scheme_work_type_en'],
        package_name_bn: json['package_name_bn'],
        package_name_en: json['package_name_en'],
        concurred_estimated_amount: json['concurred_estimated_amount'] ?? "N/A",
        contracted_amount: json['contracted_amount'] ?? "N/A",
        contractor_name: json['contractor_name'] ?? "N/A",
        number_of_female_beficiary: json['number_of_female_beficiary'] ?? 0,
        number_of_male_beficiary: json['number_of_male_beficiary'] ?? 0,
        reporting_date: json['reporting_date'] ?? "N/A",
        date_of_agreement: json['date_of_agreement'] ?? "N/A",
        date_of_commencement: json['date_of_commencement'] ?? "N/A",
        date_of_planned_completion_date:
            json['date_of_planned_completion_date'] ?? "N/A",
        date_of_actual_completion_date:
            json['date_of_actual_completion_date'] ?? "N/A",
        geo_tags_array: json['geo_tags_array'] == null
            ? []
            : List.from(json['geo_tags_array'])
                .map((e) => MyLatLng.fromJson(e, json['id']))
                .toList(),
        date_commencement_of_work_planned:
            json['date_commencement_of_work_planned'] ?? 'N/A',
        date_conceptual_proposal_submitted_to_pmu:
            json['date_conceptual_proposal_submitted_to_pmu'] ?? 'N/A',
        date_final_proposal_submitted_to_pmu:
            json['date_final_proposal_submitted_to_pmu'] ?? 'N/A',
        date_proposal_approved_for_preparation_of_bid:
            json['date_proposal_approved_for_preparation_of_bid'] ?? 'N/A',
        date_invitation_of_bid: json['date_invitation_of_bid'] ?? 'N/A',
        date_award_of_contract: json['date_award_of_contract'] ?? 'N/A',
        is_climate_risk_incorporated: json['is_climate_risk_incorporated'] ?? 0,
        has_safeguard_related_issues: json['has_safeguard_related_issues'] ?? 0,
        safeguard_related_issues: json['safeguard_related_issues'] ?? 'N/A',
        remarks: json['remarks'] ?? 'N/A',
        scheme_sub_category_id: json['scheme_sub_category_id'],
        scheme_category_id: json['scheme_category_id'],
        piller_name_en: json['piller_name_en'],

      );
}

@Entity(tableName: 'proposed_poly_line')
class MyLatLng {
  @PrimaryKey(autoGenerate: true)
  int? id;
  final String lat;
  final String lng;
  final int schemeId;

  MyLatLng({
    required this.lat,
    required this.lng,
    required this.schemeId,
  });

  factory MyLatLng.fromJson(Map<String, dynamic> json, int id) => MyLatLng(
      lat: json['lat'].toString(), lng: json['lng'].toString(), schemeId: id);
}
