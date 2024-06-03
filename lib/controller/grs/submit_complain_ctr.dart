import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:com.lged.lgcrrp.misulgi/data/local/database.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/api_service.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/request_model/complain_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/remote/model/response_model/scheme/scheme_setup_model.dart';
import '../../data/remote/model/setup/setup_model.dart';
import '../../util/constant.dart';
import '../common_controller.dart';

class SubmitComplainCtr extends GetxController {
  late AppDatabase _database;
  late SharedPreferences _prefs;
  int divisionId = 0;
  int districtId = 0;
  int cityCropId = 0;
  int complaintTypeId = 0;
  List<DivisionEntity> divisionList = [];
  List<DistrictEntity> districtList = [];
  List<CityCorporationEntity> cityCropList = [];
  List<ComplaintTypeModel> complaintTypeList = [];

  List<DropdownMenuItem> divisionItems = [];
  List<DropdownMenuItem> districtItems = [];
  List<DropdownMenuItem> cityCropsItems = [];
  List<DropdownMenuItem> complaintTypeItems = [];

  bool divisionDrpLock = false;
  bool districtDrpLock = false;
  bool cityCropDrpLock = false;

  bool isLoading = true;

  final siteOfficeName = TextEditingController();
  final complaintTitle = TextEditingController();
  final complaintExplanation = TextEditingController();
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();

  final cmnCtr = Get.find<CommonController>();

  @override
  void onReady() async {
    super.onReady();
    await _initDb();
    _getDivisions();
    // checkOfficialUserOrPublic();
  }

  void _getDivisions() async {
    divisionList = await _database.setupDao.getDivisions();
    //load the complaint type items
    complaintTypeList = await _database.setupDao.getComplaintTypes();

    for (var item in divisionList) {
      divisionItems.add(DropdownMenuItem(
        value: item.id,
        child: Text(item.name_en),
      ));
    }
    for (var item in complaintTypeList) {
      complaintTypeItems.add(DropdownMenuItem(
        value: item.id,
        child: Text(item.name_en),
      ));
    }

    isLoading = false;
    update();
  }

  setDistrictByDivisionId(int id) async {
    divisionId = id;
    districtId = 0;
    cityCropId = 0;
    districtItems.clear();
    cityCropsItems.clear();

    districtList = await _database.setupDao.getDistrictsByDivisionId(id);
    for (var item in districtList) {
      districtItems.add(DropdownMenuItem(
        value: item.id,
        child: Text(item.name_en),
      ));
    }

    update();
  }

  setCityCropsByDistrictId(int id) async {
    districtId = id;
    cityCropId = 0;
    cityCropsItems.clear();
    cityCropList = await _database.setupDao.getCityCropsByDistrictId(id);
    for (var item in cityCropList) {
      cityCropsItems.add(DropdownMenuItem(
        value: item.id,
        child: Text(item.name_en),
      ));
    }
    update();
  }

  setCityCropsId(int id) {
    cityCropId = id;
    update();
  }

  Future<int> submitComplaint() async {
    int status;
    EasyLoading.show(status: 'Please wait...');

    if (await cmnCtr.checkInternet()) {
      final model = ComplainModel(
          division_id: divisionId.toString(),
          district_id: districtId.toString(),
          organogram_id: cityCropId.toString(),
          site_office: siteOfficeName.text,
          complaint_type_id: complaintTypeId.toString(),
          complaint_title: complaintTitle.text,
          complaint_explanation: complaintExplanation.text,
          complainant_name: name.text,
          complainant_email: email.text,
          complainant_phone: phone.text,
          complainant_address: address.text);

      status = await ApiService.postComplaint(model);
    } else {
      status = 0;
    }

    EasyLoading.dismiss();
    return status;
  }

  Future<void> _initDb() async {
    _database = await AppDatabase.getInstance();
    _prefs = await SharedPreferences.getInstance();
  }

  void checkOfficialUserOrPublic() {
    int? userId = _prefs.getInt(schemeUserId);
    if (userId != null && userId != 0) {
      _setUserLevel();
    } else {
      _getDivisions();
    }
  }

  void _setUserLevel() {
    String userLevel;
    userLevel = _prefs.getString(schemeUserLevel)!;

    if (userLevel == UserLevel.pmu.value) {
      divisionDrpLock = false;
      districtDrpLock = false;
      cityCropDrpLock = false;
      // setFilterForPmu();
    } else if (userLevel == UserLevel.dv.value) {
      divisionDrpLock = true;
      districtDrpLock = false;
      cityCropDrpLock = false;
      // setFilterForDvUser();
    } else if (userLevel == UserLevel.dc.value) {
      Fluttertoast.showToast(msg: 'User is DC ');
    } else if (userLevel == UserLevel.ulgi.value) {
      divisionDrpLock = true;
      districtDrpLock = true;
      cityCropDrpLock = true;

      // setFilterForUlgiUser();
    }
    isLoading = false;

    update();
  }
}
