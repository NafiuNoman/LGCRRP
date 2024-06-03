import 'package:floor/floor.dart';
import 'package:com.lged.lgcrrp.misulgi/util/common_method.dart';

class SchemeProgressModel {
  final int code;
  final String message;
  final List<SchemeProgress>? schemesProgress;

  SchemeProgressModel(
      {required this.code, required this.message, this.schemesProgress});

  factory SchemeProgressModel.fromJson(Map<String, dynamic> json) =>
      SchemeProgressModel(
          code: json['code'],
          message: json['message'],
          schemesProgress: List.from(json['schemesProgress'])
              .map((e) => SchemeProgress.fromJson(e))
              .toList());
}

@Entity(
  tableName: 'scheme_progress',
  indices: [
    Index(value: ["id"], unique: true)
  ],
)
class SchemeProgress {
  @PrimaryKey(autoGenerate: true)
  int? selfId;
  int? id;
  int scheme_id;
  int? division_id;
  int? district_id;
  int? upazila_id;
  int? organogram_id;
  String? reported_date;
  int? male_labor_number_reported;
  int? female_labor_number_reported;
  int? male_labor_days_reported;
  int? female_labor_days_reported;
  int? women_number_paid_employement;
  String? physical_progress;
  String? financial_progress;
  String? amount_spent_in_bdt;
  String? total_labor_cost_paid;
  int? scheme_status;
  int? status; // approval status/progress status
  int? is_road_map;
  String? monthName;
  String? dayOfMonth;
  String? year;
  String? remarks;
  @ignore
  List<ProgressLatLngModel>? progress_geo_tags_array;
  @ignore
  List<ProgressImageModel>? schemeProgressImages;

  SchemeProgress(
      {this.id,
      required this.scheme_id,
      this.division_id,
      this.district_id,
      this.upazila_id,
      this.organogram_id,
      this.reported_date,
      this.male_labor_number_reported,
      this.female_labor_number_reported,
      this.male_labor_days_reported,
      this.female_labor_days_reported,
      this.women_number_paid_employement,
      this.physical_progress,
      this.financial_progress,
      this.amount_spent_in_bdt,
      this.total_labor_cost_paid,
      this.is_road_map,
      this.scheme_status,
      this.status,
      this.monthName,
      this.dayOfMonth,
      this.year,
      this.progress_geo_tags_array,
      this.schemeProgressImages,
      this.remarks});

//
  factory SchemeProgress.fromJson(Map<String, dynamic> json) => SchemeProgress(
      id: json['id'],
      scheme_id: json['scheme_id'],
      division_id: json['division_id'],
      district_id: json['district_id'],
      upazila_id: json['upazila_id'],
      organogram_id: json['organogram_id'],
      reported_date: json['reported_date'],
      male_labor_number_reported: json['male_labor_number_reported'],
      female_labor_number_reported: json['female_labor_number_reported'],
      male_labor_days_reported: json['male_labor_days_reported'],
      female_labor_days_reported: json['female_labor_days_reported'],
      women_number_paid_employement: json['women_number_paid_employement'],
      physical_progress: json['physical_progress']??'0.0',
      financial_progress: json['financial_progress']??'0.0',
      amount_spent_in_bdt: json['amount_spent_in_bdt'],
      total_labor_cost_paid: json['total_labor_cost_paid'],
      is_road_map: json['is_road_map'],
      scheme_status: int.parse(json['scheme_status'] ?? '0'),
      status: int.parse(json['status'] ?? '0'),
      monthName: makeRepresentableDate(json['reported_date'])['month'],
      dayOfMonth: makeRepresentableDate(json['reported_date'])['dayOfMonth'],
      year: makeRepresentableDate(json['reported_date'])['year'],
      remarks: json['remarks'],
      schemeProgressImages: json['schemeProgressImages'] == null
          ? []
          : List.from(json['schemeProgressImages'])
              .map((e) => ProgressImageModel.fromJson(e))
              .toList(),
      progress_geo_tags_array: json['progress_geo_tags_array'] == null
          ? []
          : List.from(json['progress_geo_tags_array'])
              .map((e) => ProgressLatLngModel.fromJson(
                    json: e,
                    schemeId: json['scheme_id'],
                    progressId: json['id'],
                  ))
              .toList());
}

@Entity(tableName: 'progress_image')
class ProgressImageModel {
  @PrimaryKey(autoGenerate: true)
  final int? selfId;
  @ColumnInfo(name: 'scheme_id')
  final int id;
  final int scheme_progress_id;
  final String scheme_progress_image_url;

  ProgressImageModel(

      {required this.id,
        this.selfId,
      required this.scheme_progress_id,
      required this.scheme_progress_image_url});

  factory ProgressImageModel.fromJson(Map<String, dynamic> json) =>
      ProgressImageModel(
          id: json['id'],
          scheme_progress_id: json['scheme_progress_id'],
          scheme_progress_image_url: json['scheme_progress_image_url']);
}

@Entity(tableName: "progress_lat_lng")
class ProgressLatLngModel {
  @PrimaryKey(autoGenerate: true)
  int? id;
  int selfId;
  final double lat;
  final double lng;
  final int schemeId;
  int? progressId;

  ProgressLatLngModel({
    required this.selfId,
    required this.lat,
    required this.lng,
    required this.schemeId,
    this.progressId,
  });

  factory ProgressLatLngModel.fromJson(
          {required Map<String, dynamic> json,
          required int schemeId,
          required int progressId}) =>
      ProgressLatLngModel(
        lat: json['lat'] ?? 0.0,
        lng: json['lng'] ?? 0.0,
        progressId: progressId,
        schemeId: schemeId,
        selfId: 0,
      );

  Map<String, dynamic> toJson() => {
        'lat': lat, // Convert lat to double
        'lng': lng, // Convert lng to double
      };
}

class ProgressResponseModel {
  final int code;
  final String message;
  final int? id;

  ProgressResponseModel({required this.code, required this.message, this.id});

  factory ProgressResponseModel.fromJson(Map<String, dynamic> json) =>
      ProgressResponseModel(
          code: json['code'], message: json['message'], id: json['id']);
}

String mapListToJson(List<ProgressLatLngModel> mapList) {
  String jsonString = '[';
  for (int i = 0; i < mapList.length; i++) {
    jsonString += '{"lat": ${mapList[i].lat}, "lng": ${mapList[i].lng}}';
    if (i != mapList.length - 1) {
      jsonString += ', ';
    }
  }
  jsonString += ']';
  return jsonString;
}
