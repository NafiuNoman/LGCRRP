import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/response_model/grs/complaint_list_model.dart';

import '../../data/local/database.dart';
import '../../data/remote/api_service.dart';
import '../../data/remote/model/setup/setup_model.dart';
import '../../util/constant.dart';
import '../common_controller.dart';

class ComplaintCtr extends GetxController {
  late AppDatabase _database;
  late SharedPreferences prefs;
  List<ComplaintDetailsModel> list = [];
  bool isLoading = true;
  bool hasMoreData = false;
  bool expandFilter = true;
  ScrollController scrollController = ScrollController();
  List<DivisionEntity> divisionList = [];
  List<DistrictEntity> districtList = [];
  List<CityCorporationEntity> cityCropList = [];

  List<DropdownMenuItem<int>> divisionDropDownItems = [];
  List<DropdownMenuItem<int>> districtDropDownItems = [];
  List<DropdownMenuItem<int>> cityCropDropDownItems = [];

  final trackingNoCtr = TextEditingController();

  bool divisionDrpLock = false;
  bool districtictDrpLock = false;
  bool cityCropDrpLock = false;

  int selectedSchemeid = 0;
  int selectedProgressid = 0;
  int pageNumber = 1;
  int lastPageNumber = 1;
  int divisionId = 0;
  int districtId = 0;
  int cityCropId = 0;

  final cmnCtr = Get.find<CommonController>();

  @override
  void onReady() async {
    await _initDB();
    super.onReady();
    _setUserLevel();
    scrollController.addListener(scrollListener);
  }

  scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (lastPageNumber > pageNumber) {
        getComplaintList();
      }
      if (hasMoreData == false) {
        Fluttertoast.showToast(msg: 'All data fetched');
      }
    }
  }

  void _setUserLevel() {
    String userLevel;
    userLevel = prefs.getString(schemeUserLevel)!;

    if (userLevel == UserLevel.pmu.value) {
      divisionDrpLock = false;
      districtictDrpLock = false;
      cityCropDrpLock = false;
      setFilterForPmu();
    } else if (userLevel == UserLevel.dv.value) {
      divisionDrpLock = true;
      districtictDrpLock = false;
      cityCropDrpLock = false;
      setFilterForDvUser();
    } else if (userLevel == UserLevel.dc.value) {
      Fluttertoast.showToast(msg: 'User is DC ');
    } else if (userLevel == UserLevel.ulgi.value) {
      divisionDrpLock = true;
      districtictDrpLock = true;
      cityCropDrpLock = true;

      setFilterForUlgiUser();
    }
  }

  Future<void> getComplaintList() async {
    if (!await cmnCtr.checkInternet()) {
      return;
    }

    isLoading = true;
    expandFilter = false;

    update();

    _database = await AppDatabase.getInstance();

    String? token = prefs.getString("token");
    if (token != null) {
      ComplaintListModel? model = await ApiService.getComplaintList(
          token: token,
          organogramId: cityCropId,
          pageNumber: pageNumber,
          districtId: districtId,
          divisionId: divisionId,
          trackingNo: trackingNoCtr.text);

      if (model != null && model.complaintList.data != null) {
        lastPageNumber = model.complaintList.last_page ?? 1;

        list.addAll(model.complaintList.data!);
        pageNumber++;
      }

      if (lastPageNumber > pageNumber) {
        hasMoreData = true;
      } else {
        hasMoreData = false;
      }
    }

    isLoading = false;
    update();
  }

  Future<void> _initDB() async {
    _database = await AppDatabase.getInstance();
    prefs = await SharedPreferences.getInstance();
  }

  void setFilterForUlgiUser() async {
    await setDivisions();
    await setDistricts();
    await setCityCorporation();

    divisionId = prefs.getInt(schemeDivisionId) ?? 0;
    districtId = prefs.getInt(schemeDistrictId) ?? 0;
    cityCropId = prefs.getInt(schemeOrganogramId) ?? 0;

    if (divisionList.isNotEmpty) {
      divisionDropDownItems = divisionList
          .map((e) => DropdownMenuItem(
                value: e.id,
                child: Text(e.name_en),
              ))
          .toList();
    }
    if (districtList.isNotEmpty) {
      districtDropDownItems = districtList
          .map((e) => DropdownMenuItem(
                value: e.id,
                child: Text(e.name_en),
              ))
          .toList();
    }
    if (cityCropList.isNotEmpty) {
      cityCropDropDownItems = cityCropList
          .map((e) => DropdownMenuItem(
                value: e.id,
                child: Text(e.name_en),
              ))
          .toList();
    }
    isLoading = false;
    update();
  }

  void setFilterForDvUser() async {
    divisionId = prefs.getInt(schemeDivisionId) ?? 0;
    await setDivisions();
    await setDistricts(divId: divisionId);

    if (divisionList.isNotEmpty) {
      divisionDropDownItems = divisionList
          .map((e) => DropdownMenuItem(
                value: e.id,
                child: Text(e.name_en),
              ))
          .toList();
    }
    if (districtList.isNotEmpty) {
      districtDropDownItems = districtList
          .map((e) => DropdownMenuItem(
                value: e.id,
                child: Text(e.name_en),
              ))
          .toList();
    }

    isLoading = false;
    update();
  }

  void setFilterForPmu() async {
    await setDivisions();

    if (divisionList.isNotEmpty) {
      divisionDropDownItems = divisionList
          .map((e) => DropdownMenuItem(
                value: e.id,
                child: Text(e.name_en),
              ))
          .toList();
    }

    isLoading = false;
    update();
  }

  setDivisions() async {
    divisionList = await _database.setupDao.getDivisions();
  }

  setDistricts({int? divId}) async {
    districtId = 0;
    cityCropId = 0;

    if (divId == null) {
      districtList = await _database.setupDao.getDistricts();
    } else {
      divisionId = divId;
      districtList = await _database.setupDao.getDistrictsByDivisionId(divId);
    }

    if (districtList.isNotEmpty) {
      districtDropDownItems = districtList
          .map((e) => DropdownMenuItem(
                value: e.id,
                child: Text(e.name_en),
              ))
          .toList();
    }

    update();
  }

  setCityCorporation({int? disId}) async {
    cityCropId = 0;

    if (disId == null) {
      cityCropList = await _database.setupDao.getCityCrops();
    } else {
      districtId = disId;
      cityCropList = await _database.setupDao.getCityCropsByDistrictId(disId);
      if (cityCropList.isNotEmpty) {
        cityCropDropDownItems = cityCropList
            .map((e) => DropdownMenuItem(
                  value: e.id,
                  child: Text(e.name_en),
                ))
            .toList();
      }
    }
    update();
  }

  setCityCropsValue(int id) {
    cityCropId = id;
    update();
  }

  Future<String> getComplaintTypeName(int id) async {
    String? name = await _database.setupDao.getComplaintTypesNameById(id);

    return name ?? "N/A";
  }
}
