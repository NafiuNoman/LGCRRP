import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:com.lged.lgcrrp.misulgi/controller/common_controller.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/response_model/scheme/scheme_setup_model.dart';
import 'package:com.lged.lgcrrp.misulgi/util/constant.dart';

import '../../data/local/database.dart';
import '../../data/remote/api_service.dart';
import '../../data/remote/model/response_model/scheme/login_response_model.dart';

class SchemeLogInCtr extends GetxController {
  late AppDatabase _database;
  late SharedPreferences prefs;
  RxBool isObscure = true.obs;
  final cmnCtr = Get.find<CommonController>();

  TextEditingController userNameCtr = TextEditingController();
  TextEditingController passCtr = TextEditingController();

  Future<void> processLogin(BuildContext context) async {
    EasyLoading.show(status: "Processing...");

    if (await cmnCtr.checkInternet()) {
      SchemeLogInResModel? model =
          await ApiService.schemeLogIn(userNameCtr.text, passCtr.text);

      if (model != null && model.code == 200) {
        if (model.code == 200) {
          await _database.schemeDao.insertSchemeLoggedInUserDetails(model);
          // cmnCtr.userName.value = model.user_name_en??'';
          // cmnCtr.userLevel.value = model.user_level??'';

          await _saveTokenToPref(
              model.api_token,
              model.user_id,
              model.user_division_id,
              model.user_district_id,
              model.user_organogram_id,
              model.user_level);
          await callForSchemeSetupData();

          cmnCtr.hasSession.value = true;

          userNameCtr.clear();
          passCtr.clear();

          Navigator.pushReplacementNamed(context, "/schemeListPage");
        } else {
          Fluttertoast.showToast(msg: model.message);
        }
      }
    }

    EasyLoading.dismiss();
  }

  Future<void> callForSchemeSetupData() async {
    SchemeSetupData? setupData =
        await ApiService.getSchemeSetUpData(prefs.getString('token') ?? "");

    if (setupData != null) {
      if (setupData.schemeApprovalStatus != null) {
        _database.setupDao
            .insertProgressStatus(setupData.schemeApprovalStatus!);
      }
      if (setupData.schemeStatus != null) {
        _database.setupDao.insertSchemeStatus(setupData.schemeStatus!);
      }
      if (setupData.commonLabels != null) {
        for (var model in setupData.commonLabels!) {
          if (model.data_type == "complaint-types") {
            _database.setupDao.insertComplaintType(ComplaintTypeModel(
                id: model.id,
                data_type: model.data_type,
                name_en: model.name_en));
          }
        }
      }
      if(setupData.packages.isNotEmpty) {
        await   _database.setupDao.insertSchemePackages(setupData.packages);

      }
      if(setupData.schemeSectors.isNotEmpty) {
        await   _database.setupDao.insertSchemeCategories(setupData.schemeSectors);

      }
      if(setupData.schemeSubSectors.isNotEmpty) {
       await   _database.setupDao.insertSchemeSubCategories(setupData.schemeSubSectors);

        }
    }
  }

  Future<void> _saveTokenToPref(String token, int userId, int divisionId,
      int districtId, int cityCropId, String? userLevel) async {
    await prefs.setString("token", "Bearer $token");
    await prefs.setInt(schemeUserId, userId);
    await prefs.setString(
        schemeUserLevel, userLevel ?? "pmu"); //userLevel null means pmu
    await prefs.setInt(schemeDivisionId, divisionId);
    await prefs.setInt(schemeDistrictId, districtId);
    await prefs.setInt(schemeOrganogramId, cityCropId);
  }

  @override
  void onInit() async {
    _database = await AppDatabase.getInstance();
    prefs = await SharedPreferences.getInstance();
    super.onInit();
  }
}
