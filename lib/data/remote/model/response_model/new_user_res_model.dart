import '../common_response.dart';
import '../contact_super_model.dart';

//new user save
class NewUserSaveResponseModel extends CommonResponse {
  int? id;
  ContactModel? contact_details;

  NewUserSaveResponseModel(
      {required super.code,
      required super.message,
      this.id,
      this.contact_details});

  factory NewUserSaveResponseModel.fromJson(Map<String, dynamic> json) =>
      NewUserSaveResponseModel(
          code: json['code'],
          message: json['message'],
          id: json['id'],
          contact_details: ContactModel.fromJson(json['contact_details']));
}
class OldUserUpdateResponseModel extends CommonResponse {
  int? id;
  ContactModel? ulgiContactInfo;

  OldUserUpdateResponseModel(
      {required super.code,
      required super.message,
      this.id,
      this.ulgiContactInfo});

  factory OldUserUpdateResponseModel.fromJson(Map<String, dynamic> json) =>
      OldUserUpdateResponseModel(
          code: json['code'],
          message: json['message'],
          id: json['id'],
          ulgiContactInfo: ContactModel.fromJson(json['ulgiContactInfo']));
}
