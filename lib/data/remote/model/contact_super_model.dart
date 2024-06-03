import 'package:com.lged.lgcrrp.misulgi/data/remote/model/common_response.dart';
import 'package:floor/floor.dart';

class ContactSuperModel extends CommonResponse {
UlgiContactsModel? ulgiContacts;

  ContactSuperModel(
      {required super.code, required super.message, this.ulgiContacts});

  factory ContactSuperModel.fromJson(Map<String, dynamic> json) =>
      ContactSuperModel(
          code: json['code'],
          message: json['message'],
          ulgiContacts:  UlgiContactsModel.fromJson(json['ulgiContacts']));
}

class UlgiContactsModel {
  final int current_page;
  final int last_page;
  final List<ContactModel>? data;

  UlgiContactsModel(
      {required this.current_page,
      required this.last_page,
      required this.data});

  factory UlgiContactsModel.fromJson(Map<String, dynamic> json) =>
      UlgiContactsModel(
          current_page: json['current_page'],
          last_page: json['last_page'],
          data: List.from(json['data'])
              .map((e) => ContactModel.fromJson(e))
              .toList());
}
@Entity(tableName: 'contact')
class ContactModel {
  @primaryKey
  int id;
  int division_id;
  int district_id;
  int organogram_id;
  int? designation_id;
  String name_en;
  String? name_bn;
  String email;
  String mobile_number;
  String? whats_app_number;
  String? division_name_en;
  String? district_name_en;
  String? organogram_name_en;
  String? blood_group;
  String? gender;
  String? date_of_birth;
  String? present_address;
  String? permanent_address;
  String? nid_number;
  String? profile_image;
  String? profile_image_url;

  ContactModel(
      {required this.id,
      required this.division_id,
      required this.organogram_id,
      required this.district_id,
      required this.designation_id,
      required this.name_en,
      required this.name_bn,
      required this.email,
      required this.mobile_number,
      this.whats_app_number,
      this.division_name_en,
      this.district_name_en,
      this.organogram_name_en,
      this.blood_group,
      required this.gender,
      this.date_of_birth,
      this.present_address,
      this.permanent_address,
      this.nid_number,
      this.profile_image,
      this.profile_image_url});

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        id: json['id'],
        division_id: json['division_id'],
        district_id: json['district_id'],
        organogram_id: json['organogram_id'],
        designation_id: json['designation_id'],
        name_en: json['name_en'],
        name_bn: json['name_bn'],
        email: json['email'],
        mobile_number: json['mobile_number'],
        whats_app_number: json['whats_app_number'],
        district_name_en: json['district_name_en'],
        division_name_en: json['division_name_en'],
        organogram_name_en: json['organogram_name_en'],
        date_of_birth: json['date_of_birth'],
        gender: json['gender'],
        blood_group: json['blood_group'],
        present_address: json['present_address'],
        permanent_address: json['permanent_address'],
        nid_number: json['nid_number'],
        profile_image: json['profile_image'],
        profile_image_url: json['profile_image_url'],
      );
}
