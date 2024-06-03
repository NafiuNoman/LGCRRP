import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:com.lged.lgcrrp.misulgi/data/local/database.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/response_model/grs/tracking_model.dart';
import '../data/remote/api_service.dart';
import '../data/remote/model/contact_super_model.dart';
import '../data/remote/model/response_model/scheme/login_response_model.dart';
import '../data/remote/model/response_model/scheme/scheme_setup_model.dart';
import '../data/remote/model/setup/setup_model.dart';

class CommonController extends GetxController {
  late AppDatabase _database;
  late SharedPreferences prefs;
  final trackingNumberCtr = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxBool hasSession = false.obs;
  RxString userName = ''.obs;
  RxString userLevel = ''.obs;
  RxString serverName = ''.obs;
  RxString versionName = ''.obs;

  bool hasSessionForContacts() {
    if (prefs.getInt("id") == 0 || prefs.getInt("id") == null) {
      return false;
    } else {
      return true;
    }
  }

  bool hasSessionForScheme() {
    if (prefs.getString("token") == null) {
      hasSession.value = false;
    } else {
      hasSession.value = true;
    }

    return hasSession.value;
  }

  Future<bool> callSetupApiAndInsertToDb() async {
    bool success = false;
    if (await checkInternet()) {

      SetupModel? setupModel = await ApiService.getContactSetupData();

      if (setupModel != null) {
        final setupDao = _database.setupDao;

        if (setupModel.commonLabels != null) {
          for (var model in setupModel.commonLabels!) {
            if (model.data_type == "complaint-types") {

              try{
                await setupDao.insertComplaintType(ComplaintTypeModel(
                    id: model.id,
                    data_type: model.data_type,
                    name_en: model.name_en));

                success = true;

              }
              catch(e){

                Fluttertoast.showToast(
                    msg: "Complaint insertion error",
                    backgroundColor: const Color(0xffEC8F5E),
                    textColor: Colors.white);

                printError(info: "DB exception-> $e");
                success = false;
              }


            }
          }
        }

        try {
          await setupDao.insertGender(setupModel.genders);
          success = true;
        } catch (e) {
          Fluttertoast.showToast(
              msg: "Gender types insertion error",
              backgroundColor: const Color(0xffEC8F5E),
              textColor: Colors.white);

          printError(info: "DB exception-> $e");
          success = false;
        }

        try {
          await setupDao.insertBloodGroup(setupModel.bloodGroups);
          success = true;
        } catch (e) {
          Fluttertoast.showToast(
              msg: "Blood group insertion error",
              backgroundColor: const Color(0xffEC8F5E),
              textColor: Colors.white);

          printError(info: "DB exception-> $e");
          success = false;
        }

        try {
          await setupDao.insertCityCorporation(setupModel.cityCorpPaurashavas);
          success = true;
        } catch (e) {
          Fluttertoast.showToast(
              msg: "City corporation insertion error",
              backgroundColor: const Color(0xffEC8F5E),
              textColor: Colors.white);

          printError(info: "DB exception-> $e");
          success = false;
        }

        try {
          await setupDao.insertDistrict(setupModel.districts);
          success = true;
        } catch (e) {
          Fluttertoast.showToast(
              msg: "District insertion error",
              backgroundColor: const Color(0xffEC8F5E),
              textColor: Colors.white);

          printError(info: "DB exception-> $e");
          success = false;
        }

        try {
          await setupDao.insertDesignation(setupModel.designations);
          success = true;
        } catch (e) {
          Fluttertoast.showToast(
              msg: "Designation insertion error",
              backgroundColor: const Color(0xffEC8F5E),
              textColor: Colors.white);

          printError(info: "DB exception-> $e");
          success=false;
        }

        try {
          await setupDao.insertDivision(setupModel.divisions);
          success = true;
        } catch (e) {
          Fluttertoast.showToast(
              msg: "Division insertion error",
              backgroundColor: const Color(0xffEC8F5E),
              textColor: Colors.white);

          printError(info: "DB exception-> $e");
          success = false;
        }
      }

    }

    return success;

  }

  Future<bool> clearSharedPref() async {
    return await prefs.clear();
  }

  Future<void> clearDB() async {
    await _database.setupDao.dropDesignationTable();

    await _database.schemeDao.dropSchemeTable();

    await _database.setupDao.dropContactTable();
    await _database.setupDao.dropContactTable();

    await _database.schemeDao.clearProgressLtLngTable();
    await _database.schemeDao.dropSchemeProgressTable();

  }

  Future<bool> checkInternet() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else {
      Get.rawSnackbar(
          backgroundColor: Colors.redAccent,
          message: "Internet connection is not available",
          icon: const Icon(
            Icons.wifi_off,
            color: Colors.white,
          ),
          snackPosition: SnackPosition.TOP);
      return false;
    }
  }

  Future<String?> callForTrackStatus() async {
    EasyLoading.show();
    if (await checkInternet()) {
      TrackingModel? model =
          await ApiService.getComplaintStatus(trackingNumberCtr.text);

      if (model != null && model.complaintStatus != null) {
        EasyLoading.dismiss();

        return model.complaintStatus;
      } else {
        EasyLoading.dismiss();

        return null;
      }
    } else {
      EasyLoading.dismiss();

      return null;
    }


  }

  Future<void> getSchemeUserInfo() async {
    try {
      SchemeLogInResModel? data = await _database.schemeDao.getSchemeUserInfo();
      if (data != null) {
        userName.value = data.user_name_en ?? 'N/A';
        userLevel.value = data.user_level ?? 'N/A';
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  void onInit() async {
    super.onInit();
    _database = await AppDatabase.getInstance();
    prefs = await SharedPreferences.getInstance();
    if (ApiService.baseUrl == "https://lgcrrpmis.lged.gov.bd/api/android/") {
      serverName.value = 'Connected to Live Server';
    } else {
      serverName.value = 'Connected to Test Server';
    }
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionName.value = packageInfo.version;
    hasSessionForScheme();
  }
}
