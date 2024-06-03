import 'package:floor/floor.dart';

import '../../common_response.dart';

@Entity(tableName: 'scheme_user_login')
class SchemeLogInResModel extends CommonResponse {

  String api_token;
  @primaryKey
  int user_id;
  int user_division_id;
  int user_district_id;
  int user_organogram_id;
  String? user_level;
  String? user_name_en;
  String? username;

  // SchemeLogInResModel({required super.code, required super.message});

  SchemeLogInResModel({
    required super.code,
    required super.message,
    required this.user_id,
    required this.api_token,
    this.user_division_id = 0,
    this.user_district_id = 0,
    this.user_organogram_id = 0,
    this.user_level,
    this.user_name_en,
    this.username,
  });

factory SchemeLogInResModel.fromJson(Map<String, dynamic> json) =>
    SchemeLogInResModel(
      code: json['code'],
      message: json['message'],
      user_id: json['user_id'] ?? 0,
      api_token: json['api_token']??'',
      user_division_id: json['user_division_id'] ?? 0,
      user_district_id: json['user_district_id'] ?? 0,
      user_organogram_id: json['user_organogram_id'] ?? 0,
      user_level: json['user_level'],
      user_name_en: json['user_name_en'],
      username: json['username']
    );
}
