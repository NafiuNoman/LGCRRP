import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:com.lged.lgcrrp.misulgi/data/model/scheme_progress_model.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/contact_super_model.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/otp_model.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/request_model/complain_model.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/request_model/new_user_model.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/response_model/grs/complaint_list_model.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/response_model/grs/complaint_response_model.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/response_model/grs/tracking_model.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/response_model/new_user_res_model.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/response_model/scheme/login_response_model.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/response_model/scheme/scheme_list_model.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/response_model/scheme/scheme_setup_model.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/setup/setup_model.dart';

import '../model/image_info_model.dart';

class ApiService {
  // dev server
  // static String baseUrl = "http://103.69.149.45:9305/api/android/";

  // cumilla-ulgi/12345678

  // arif pc server
  // static String baseUrl = "http://192.168.50.124/api/android/";
  // admin-lgcrrp/lgcrrp#2024
  // cumilla-ulgi/12345678

  // Live server
  static String baseUrl = "https://lgcrrpmis.lged.gov.bd/api/android/";

  // User & Password: admin-lgcrrp/lgcrrp#2024
  // cumilla-ulgi/12345678

  static String otpRequestUrl = "request-for-otp";
  static String contactListUrl = "ulgi-contact/list";
  static String contactSetupDataUrl = "ulgi-contact/setup-data";
  static String newUserSaveUrl = "ulgi-contact/save";
  static String userUpdateUrl = "ulgi-contact/update";
  static String schemeLogInUrl = "app-login";
  static String schemeSetupDataUrl = "setup-data-all";
  static String schemeListUrl = "scheme/list";
  static String schemeProgressListUrl = "scheme-progress/list";
  static String schemeProgressSaveUrl = "scheme-progress/save";
  static String schemeProgressUpdateUrl = "scheme-progress/update";
  static String trackComplaintUrl = "complaint/complaint-status";
  static String postComplaintUrl = "complaint/complaint-store";
  static String complaintListUrl = "complaint/complaint-list";
  static String dashBoardDataUrl = "dashboard-data";

  static Future<OtpModel?> getUserOtpDetails(String phoneNo) async {
    final url = Uri.parse(baseUrl + otpRequestUrl);
    final headers = {
      'Content-Type': 'application/json',
      'charset': 'utf-8',
    };
    final payload = json.encode({"mobile_number": phoneNo});

    try {
      var response = await http
          .post(
        url,
        headers: headers,
        body: payload,
      )
          .timeout(const Duration(seconds: 15), onTimeout: () {
        return http.Response('error', 408);
      });

      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        OtpModel model = OtpModel.fromJson(data);

        return model;
      } else if (response.statusCode == 408) {
        Fluttertoast.showToast(msg: "time out code = ${response.statusCode}");
      }
    } catch (ex) {
      Fluttertoast.showToast(msg: ex.toString());
      throw Exception("Error fetching data.\n ${ex.toString()}");
    }
    return null;
  }

  static Future<ContactSuperModel?> getUserContactList(
      {required String divisionId,
      required String districtId,
      required String organogramId,
      required String search,
      required String pageNumber}) async {
    final query = {
      'divisionId': divisionId,
      'districtId': districtId,
      'organogramId': organogramId,
      'search': search,
      'paginate': "true",
      'items_per_page': "15",
      'page': pageNumber,
    };
    final url =
        Uri.parse(baseUrl + contactListUrl).replace(queryParameters: query);
    final headers = {
      'Content-Type': 'application/json',
      'charset': 'utf-8',
    };

    try{
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        ContactSuperModel model = ContactSuperModel.fromJson(data);
        if (model.code == 200) {
          return model;
        } else {
          return model;
        }
      } else {
        Fluttertoast.showToast(msg: '${response.statusCode} ${response.toString()}');
      }

    }catch(e,st)
    {
      print(e.toString());
      print(st);

      // print(e());
    }


  }

  static Future<SetupModel?> getContactSetupData() async {
    final url = Uri.parse(baseUrl + contactSetupDataUrl);
    final headers = {
      'Content-Type': 'application/json',
      'charset': 'utf-8',
    };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        SetupModel setupModel = SetupModel.fromJson(data);

        return setupModel;
      } else {
        Fluttertoast.showToast(
            msg: "Something went worng status code: ${response.statusCode} ");
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Exception:$e", toastLength: Toast.LENGTH_LONG);
    }
    return null;
  }

  static Future<NewUserSaveResponseModel?> postNewUserData(NewUserModel userModel) async {
    final url = Uri.parse(baseUrl + newUserSaveUrl);
    final headers = {
      'Content-Type': 'multipart/form-data',
      'charset': 'utf-8',
    };

    var request = http.MultipartRequest('POST', url);

    request.fields.addAll({
      'name_en': userModel.name_en,
      'name_bn': userModel.name_bn,
      'email': userModel.email,
      'mobile_number': userModel.mobile_number,
      'date_of_birth': userModel.date_of_birth,
      'designation_id': userModel.designation_id.toString(),
      'division_id': userModel.division_id.toString(),
      'district_id': userModel.district_id.toString(),
      'organogram_id': userModel.organogram_id.toString(),
      'whats_app_number': userModel.whats_app_number.toString(),
      'blood_group': userModel.blood_group.toString(),
      'present_address': userModel.present_address.toString(),
      'permanent_address': userModel.permanent_address.toString(),
      'remove_existing_profile_image': 'no',
      'existing_profile_image': '',
      'gender': userModel.gender.toString(),
      "nid_number": userModel.nid_number.toString(),

      // 'is_active': '1'
    });

    userModel.profile_image != null
        ? request.files.add(await http.MultipartFile.fromPath(
            'profile_image',
            userModel.profile_image!.path,
            //TODO: need to set dynamic 1. jpeg 2.png
            contentType: MediaType('image', 'jpeg'),
          ))
        : null;

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseString = await response.stream.bytesToString();
        Map<String, dynamic> data = json.decode(responseString);

        NewUserSaveResponseModel newUserResponse =
            NewUserSaveResponseModel.fromJson(data);
        if (newUserResponse.code == 200) {
          Fluttertoast.showToast(
              msg: newUserResponse.message,
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.green);

          return newUserResponse;

        } else {

          Fluttertoast.showToast(
              msg:
                  "code: ${newUserResponse.code}. message: ${newUserResponse.message}",
              toastLength: Toast.LENGTH_LONG);
          return null;
        }
      }else{
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Exception:$e", toastLength: Toast.LENGTH_LONG);
      return null;
    }
  }

  static Future<OldUserUpdateResponseModel?> postUpdateUserData(NewUserModel userModel) async {

    final url = Uri.parse(baseUrl + userUpdateUrl);
    final headers = {
      'Content-Type': 'multipart/form-data',
      'charset': 'utf-8',
    };

    var request = http.MultipartRequest('POST', url);

    request.fields.addAll({
      'id': userModel.id.toString(),
      'name_en': userModel.name_en,
      'name_bn': userModel.name_bn,
      'email': userModel.email,
      'mobile_number': userModel.mobile_number,
      'date_of_birth': userModel.date_of_birth,
      'designation_id': userModel.designation_id.toString(),
      'division_id': userModel.division_id.toString(),
      'district_id': userModel.district_id.toString(),
      'organogram_id': userModel.organogram_id.toString(),
      'whats_app_number': userModel.whats_app_number.toString(),
      'blood_group': userModel.blood_group.toString(),
      'present_address': userModel.present_address.toString(),
      'permanent_address': userModel.permanent_address.toString(),
      'remove_existing_profile_image': 'yes',
      'existing_profile_image': userModel.existing_profile_image.toString(),
      'gender': userModel.gender.toString(),
      "nid_number": userModel.nid_number.toString(),

      // 'is_active': '1'
    });

    userModel.profile_image != null
        ? request.files.add(await http.MultipartFile.fromPath(
            'profile_image',
            userModel.profile_image!.path,
            //TODO: need to set dynamic 1. jpeg 2.png
            contentType: MediaType('image', 'jpeg'),
          ))
        : null;

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseString = await response.stream.bytesToString();
        Map<String, dynamic> data = json.decode(responseString);

        OldUserUpdateResponseModel newUserResponse =
        OldUserUpdateResponseModel.fromJson(data);
        if (newUserResponse.code == 200) {
          Fluttertoast.showToast(
              msg: newUserResponse.message, toastLength: Toast.LENGTH_LONG,backgroundColor: Colors.green);

          return newUserResponse;
        } else {
          Fluttertoast.showToast(
              msg:
                  "code: ${newUserResponse.code}. message: ${newUserResponse.message}",
              toastLength: Toast.LENGTH_LONG);
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Exception:$e", toastLength: Toast.LENGTH_LONG);
    }
    return null;
  }

  static Future<SchemeLogInResModel?> schemeLogIn(
      String userName, String pass) async {
    final url = Uri.parse(baseUrl + schemeLogInUrl);
    final headers = {
      'Content-Type': 'application/json',
      'charset': 'utf-8',
    };
    final payload = json.encode({
      "username": userName,
      "password": pass,
    });

    try {
      var response = await http
          .post(url, headers: headers, body: payload)
          .timeout(const Duration(seconds: 15), onTimeout: () {
        return http.Response('error', 408);
      });

      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);

        SchemeLogInResModel model = SchemeLogInResModel.fromJson(data);

        if (model.code == 200) {
          Fluttertoast.showToast(
              msg: "Login Successful", backgroundColor: Colors.green);

          return model;
        } else {
          Fluttertoast.showToast(
              msg: model.message, backgroundColor: Colors.red);
          return null;
        }
      } else if (response.statusCode == 408) {
        Fluttertoast.showToast(msg: "time out code = ${response.statusCode}");
        return null;
      } else {
        Fluttertoast.showToast(msg: "${response.statusCode}");
      }
    } catch (ex) {
      Fluttertoast.showToast(msg: ex.toString());
      return null;
      // throw Exception("Error fetching data.\n ${ex.toString()}");
    }
    return null;
  }

  static Future<SchemeSetupData?> getSchemeSetUpData(String token) async {
    final headers = {
      'Authorization': token,
      'Content-Type': 'application/json',
      'charset': 'utf-8',
    };

    try {
      final url = Uri.parse(baseUrl + schemeSetupDataUrl);
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        SchemeSetupData model = SchemeSetupData.fromJson(data);

        if (model.code == 200) {
          return model;
        } else {
          Fluttertoast.showToast(
              msg: "code: ${model.code}. message: ${model.message}");
          return null;
        }
      } else {
        Fluttertoast.showToast(msg: "code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Exception:$e", toastLength: Toast.LENGTH_LONG);
      return null;
    }
  }

  static Future<SchemeListModel?> getSchemeList({
    required String token,
    required int organogramId,
    required int pageNumber,
    required int divisionId,
    required int districtId,
    required String schemeId,
    required String packageId,
    required String schemeCategoryId,
    required String schemeSubCategoryId,
  }) async {
    final queryParameters = {
      'divisionId': '$divisionId',
      'districtId': '$districtId',
      'organogramId': '$organogramId',
      'paginate': "true",
      'items_per_page': "4",
      'page': '$pageNumber',
      'schemeId': schemeId,
      'packageId': packageId,
      'schemeCategoryId': schemeCategoryId,
      'schemeSubCategoryId': schemeSubCategoryId,
    };
    final headers = {
      'Authorization': token,
      'Content-Type': 'application/json',
      'charset': 'utf-8',
    };

    try {
      final url = Uri.parse(baseUrl + schemeListUrl)
          .replace(queryParameters: queryParameters);
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        SchemeListModel model = SchemeListModel.fromJson(data);

        if (model.code == 200) {
          return model;
        } else {
          Fluttertoast.showToast(
              msg: "code: ${model.code}. message: ${model.message}");
          return null;
        }
      } else {
        Fluttertoast.showToast(msg: "code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Exception:$e", toastLength: Toast.LENGTH_LONG);
      return null;
    }
  }

  static Future<SchemeProgressModel?> getSchemeProgress(
      String token, String schemeId) async {
    final queryParameters = {
      'schemeId': schemeId,
    };
    final headers = {
      'Authorization': token,
      'Content-Type': 'application/json',
      'charset': 'utf-8',
    };

    try {
      final url = Uri.parse(baseUrl + schemeProgressListUrl)
          .replace(queryParameters: queryParameters);

      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        SchemeProgressModel model = SchemeProgressModel.fromJson(data);
        if (model.code == 200) {
          return model;
        } else {
          Fluttertoast.showToast(
              msg: "code: ${model.code}. message: ${model.message}");
          return null;
        }
      } else {
        Fluttertoast.showToast(msg: "code: ${response.statusCode}.");

        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Exception:$e", toastLength: Toast.LENGTH_LONG);
      return null;
    }
  }

  static Future<ProgressResponseModel?> postSchemeProgress(
      String token,
      SchemeProgress p,
      String mapString,
      int userId,
      String status,
      List<ImageInfoModel> images) async {
    EasyLoading.show();
    final url = Uri.parse(baseUrl + schemeProgressSaveUrl);
    final headers = {
      'Authorization': token,
      'Content-Type': 'multipart/form-data',
      'charset': 'utf-8',
    };

    var request = http.MultipartRequest('POST', url);

    request.fields.addAll({
      'division_id': p.division_id.toString(),
      'district_id': p.district_id.toString(),
      'organogram_id': p.organogram_id.toString(),
      'scheme_id': p.scheme_id.toString(),
      'reported_date': p.reported_date.toString(),
      'amount_spent_in_bdt': p.amount_spent_in_bdt.toString(),
      'scheme_status': p.scheme_status.toString(),
      'financial_progress': p.financial_progress.toString(),
      'physical_progress': p.physical_progress.toString(),
      'male_labor_number_reported': p.male_labor_number_reported.toString(),
      'female_labor_number_reported': p.female_labor_number_reported.toString(),
      'male_labor_days_reported': p.male_labor_days_reported.toString(),
      'female_labor_days_reported': p.female_labor_days_reported.toString(),
      'women_number_paid_employement':
          p.women_number_paid_employement.toString(),
      'total_labor_cost_paid': p.total_labor_cost_paid.toString(),
      'is_road_map': '1',
      'progress_geo_tags': mapString,
      'remarks': p.remarks.toString(),
      // '_token': token,
      'status': status,
      'id': '',
      'created_by': userId.toString()

      // 'is_active': '1'
    });

    if (images.isNotEmpty) {
      for (var image in images) {
        request.files.add(await http.MultipartFile.fromPath(
          'scheme_image[]',
          image.imagePath,
          //TODO: need to set dynamic 1. jpeg 2.png
          contentType: MediaType('image', 'jpeg'),
        ));
      }
    }

    request.headers.addAll(headers);

    ProgressResponseModel? newUserResponse;
    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseString = await response.stream.bytesToString();
        Map<String, dynamic> data = json.decode(responseString);

        newUserResponse = ProgressResponseModel.fromJson(data);
        EasyLoading.dismiss();
        if (newUserResponse.code.toString() == "200") {
          Fluttertoast.showToast(
              msg: newUserResponse.message,
              backgroundColor: Colors.green,
              toastLength: Toast.LENGTH_LONG);
        } else {
          Fluttertoast.showToast(
              msg:
                  "code: ${newUserResponse.code}. message: ${newUserResponse.message}",
              toastLength: Toast.LENGTH_LONG);
        }
      } else {
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(
          msg: "Exception:$e", toastLength: Toast.LENGTH_LONG);
    }

    return newUserResponse;
  }


  static Future<ProgressResponseModel?> updateSchemeProgress(
      String token,
      SchemeProgress p,
      String mapString,
      int userId,
      String status,
      List<ImageInfoModel> images,
      String progressId) async {
    EasyLoading.show();
    final url = Uri.parse(baseUrl + schemeProgressUpdateUrl);
    final headers = {
      'Authorization': token,
      'Content-Type': 'multipart/form-data',
      'charset': 'utf-8',
    };

    var request = http.MultipartRequest('POST', url);

    request.fields.addAll({
      'division_id': p.division_id.toString(),
      'district_id': p.district_id.toString(),
      'organogram_id': p.organogram_id.toString(),
      'scheme_id': p.scheme_id.toString(),
      'reported_date': p.reported_date.toString(),
      'amount_spent_in_bdt': p.amount_spent_in_bdt.toString(),
      'scheme_status': p.scheme_status.toString(),
      'financial_progress': p.financial_progress.toString(),
      'physical_progress': p.physical_progress.toString(),
      'male_labor_number_reported': p.male_labor_number_reported.toString(),
      'female_labor_number_reported': p.female_labor_number_reported.toString(),
      'male_labor_days_reported': p.male_labor_days_reported.toString(),
      'female_labor_days_reported': p.female_labor_days_reported.toString(),
      'women_number_paid_employement':
          p.women_number_paid_employement.toString(),
      'total_labor_cost_paid': p.total_labor_cost_paid.toString(),
      'is_road_map': '1',
      'progress_geo_tags': mapString,
      'remarks': p.remarks.toString(),
      // '_token': token,
      'status': status,
      'id': progressId,
      'created_by': userId.toString()

      // 'is_active': '1'
    });

    if (images.isNotEmpty) {
      for (var image in images) {
        request.files.add(await http.MultipartFile.fromPath(
          'scheme_image[]',
          image.imagePath,
          //TODO: need to set dynamic 1. jpeg 2.png
          contentType: MediaType('image', 'jpeg'),
        ));
      }
    }

    request.headers.addAll(headers);

    ProgressResponseModel? updateResponse;
    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseString = await response.stream.bytesToString();
        Map<String, dynamic> data = json.decode(responseString);

        updateResponse = ProgressResponseModel.fromJson(data);
        EasyLoading.dismiss();
        if (updateResponse.code.toString() == "200") {
          Fluttertoast.showToast(
              msg: updateResponse.message,
              backgroundColor: Colors.green,
              toastLength: Toast.LENGTH_LONG);
        } else {
          Fluttertoast.showToast(
              msg:
                  "code: ${updateResponse.code}. message: ${updateResponse.message}",
              toastLength: Toast.LENGTH_LONG);
        }
      } else {
        EasyLoading.dismiss();
      }
    } catch (e,st) {
      EasyLoading.dismiss();
      print(st);

      // Fluttertoast.showToast(
      //     msg: "Exception:$e", toastLength: Toast.LENGTH_LONG);
    }

    return updateResponse;
  }




  static Future<TrackingModel?> getComplaintStatus(
      String trackingNumber) async {
    EasyLoading.show();
    final queryParameters = {
      'trackingNumber': trackingNumber,
    };

    try {
      final url = Uri.parse(baseUrl + trackComplaintUrl)
          .replace(queryParameters: queryParameters);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        final TrackingModel model = TrackingModel.fromJson(data);
        if (model.code == 200) {
          return model;
        } else {
          Fluttertoast.showToast(
              msg: "Code:${model.code}. ${model.message}",
              toastLength: Toast.LENGTH_LONG);
          return null;
        }
      } else {
        Fluttertoast.showToast(msg: '${response.statusCode}');
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Exception:$e", toastLength: Toast.LENGTH_LONG);
      return null;
    }
  }

  static Future<int> postComplaint(ComplainModel model) async {
    final url = Uri.parse(baseUrl + postComplaintUrl);

    var request = http.MultipartRequest('POST', url);

    request.fields.addAll(model.toJson());
    ComplaintResponseModel? responseModel;
    int status = 0;
    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseString = await response.stream.bytesToString();
        Map<String, dynamic> data = json.decode(responseString);

        responseModel = ComplaintResponseModel.fromJson(data);

        if (responseModel.code == 200 && responseModel.id != null) {
          status = 1;
          Get.snackbar(
            'Tracking Number: ${responseModel.tracking_number}',
            responseModel.message,
            duration: const Duration(minutes: 10),
            colorText: Colors.white,
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.TOP,
            mainButton: TextButton(
              child: const Text(
                'Dismiss',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Get.closeAllSnackbars();
              },
            ),
          );
        } else {
          Fluttertoast.showToast(
              msg:
                  "code: ${responseModel.code}. message: ${responseModel.message}",
              toastLength: Toast.LENGTH_LONG);
        }
      } else {
        Fluttertoast.showToast(msg: '${response.statusCode}');
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Exception:$e", toastLength: Toast.LENGTH_LONG);
    }

    return status;
  }

  static Future<ComplaintListModel?> getComplaintList(
      {required String token,
      required int organogramId,
      required int pageNumber,
      required int divisionId,
      required int districtId,
      required String trackingNo}) async {
    final queryParameters = {
      'divisionId': '$divisionId',
      'districtId': '$districtId',
      'organogramId': '$organogramId',
      'paginate': "true",
      'items_per_page': "10",
      'page': '$pageNumber',
      'tracking_number': trackingNo,
    };
    final headers = {
      'Authorization': token,
      'Content-Type': 'application/json',
      'charset': 'utf-8',
    };

    try {
      final url = Uri.parse(baseUrl + complaintListUrl)
          .replace(queryParameters: queryParameters);
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        ComplaintListModel model = ComplaintListModel.fromJson(data);

        if (model.code == 200) {
          return model;
        } else {
          Fluttertoast.showToast(
              msg: "code: ${model.code}. message: ${model.message}");
          return null;
        }
      } else {
        Fluttertoast.showToast(msg: "code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Exception:$e", toastLength: Toast.LENGTH_LONG);
      return null;
    }
  }

  static Future<SetupModel?> getDashboardData() async {
    final url = Uri.parse(baseUrl + dashBoardDataUrl);
    final headers = {
      'Content-Type': 'application/json',
      'charset': 'utf-8',
    };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        SetupModel setupModel = SetupModel.fromJson(data);

        return setupModel;
      } else {
        Fluttertoast.showToast(
            msg: "Something went worng status code: ${response.statusCode} ");
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Exception:$e", toastLength: Toast.LENGTH_LONG);
    }
    return null;
  }
}
