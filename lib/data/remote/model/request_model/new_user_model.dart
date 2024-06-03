import 'dart:io';

class NewUserModel {
  int? id;
  String name_en;
  String name_bn;
  String email;
  String mobile_number;
  String? whats_app_number;
  String? blood_group;
  String? gender;
  //TODO:need to fix this two
  String? remove_existing_profile_image;
  String? existing_profile_image;

  int division_id;
  int district_id;
  int organogram_id;
  int designation_id;
  String date_of_birth;
  String? present_address;
  String? nid_number;
  String? permanent_address;
  File? profile_image;

  NewUserModel(
      {this.id,
      required this.name_en,
      required this.name_bn,
      required this.email,
      this.remove_existing_profile_image = "no",
      this.existing_profile_image = "",
      required this.mobile_number,
       this.whats_app_number,
      required this.division_id,
      required this.district_id,
      required this.organogram_id,
      required this.designation_id,
      required this.date_of_birth,
      this.blood_group,
      this.nid_number,
      this.gender,
      this.permanent_address,
      this.present_address,
        this.profile_image,
      });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['name_en'] = name_en;
    json['name_bn'] = name_bn;
    json['email'] = email;
    json['remove_existing_profile_image']=remove_existing_profile_image;
    json['existing_profile_image']=existing_profile_image;
    json['mobile_number'] = mobile_number;
    json['whats_app_number'] = whats_app_number;
    json['division_id'] = division_id;
    json['district_id'] = district_id;
    json['organogram_id'] = organogram_id;
    json['designation_id'] = designation_id;
    json['date_of_birth'] = date_of_birth;
    json['permanent_address'] = permanent_address;
    json['present_address'] = present_address;
    json['blood_group'] = blood_group;
    json['gender'] = gender;
    json['profile_image']=profile_image;
    json['nid_number']=nid_number;

    return json;
  }
}
