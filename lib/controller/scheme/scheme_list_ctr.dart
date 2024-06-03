import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:com.lged.lgcrrp.misulgi/data/local/entity/join_entity/progress_and_status.dart';
import 'package:com.lged.lgcrrp.misulgi/data/model/scheme_progress_model.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/api_service.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/response_model/scheme/scheme_list_model.dart';
import '../../data/local/database.dart';
import '../../data/remote/model/setup/setup_model.dart';
import '../../util/constant.dart';
import '../common_controller.dart';

class SchemeListCtr extends GetxController {
  late AppDatabase _database;
  late SharedPreferences prefs;
  List<Scheme> list = [];
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
  List<DropdownMenuItem<int>> packageDropDownItems = [];
  List<DropdownMenuItem<int>> categoryDropDownItems = [];
  List<DropdownMenuItem<int>> subCategoryDropDownItems = [];

  final schemeIdCtr = TextEditingController();

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

  int packageId = 0;
  int categoryId = 0;
  int subCategoryId = 0;
  String schemeCategoryName = '';
  String schemeSubCategoryName = '';

  final cmnCtr = Get.find<CommonController>();

  @override
  void onReady() async {
    await _initDB();
    await loadSetupData();
    super.onReady();
    _setUserLevel();
    scrollController.addListener(scrollListener);
  }

  loadSetupData() async {
    try {
      var packages = await _database.setupDao.getSchemePackages();
      var categories = await _database.setupDao.getSchemeCategories();
      var subCategories = await _database.setupDao.getSchemeSubCategories();

      if (packages.isNotEmpty) {
        packageDropDownItems.addAll(packages.map((e) => DropdownMenuItem(
              value: e.id,
              child: Text(e.name_en),
            )));
      }
      if (categories.isNotEmpty) {
        categoryDropDownItems.addAll(categories.map((e) => DropdownMenuItem(
              value: e.id,
              child: Text(e.name_en),
            )));
      }
      if (subCategories.isNotEmpty) {
        subCategoryDropDownItems
            .addAll(subCategories.map((e) => DropdownMenuItem(
                  value: e.id,
                  child: Text(e.name_en),
                )));
      }
    } catch (e) {
      print('Error loading setup data: $e');
    }
    update();
  }

  scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (lastPageNumber > pageNumber) {
        getSchemeList();
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

  Future<void> getSchemeList() async {
    if (!await cmnCtr.checkInternet()) {
      return;
    }

    isLoading = true;
    expandFilter = false;

    update();

    _database = await AppDatabase.getInstance();

    //make api call and insert db
    String? token = prefs.getString("token");
    if (token != null) {
      SchemeListModel? model = await ApiService.getSchemeList(
          token: token,
          organogramId: cityCropId,
          pageNumber: pageNumber,
          districtId: districtId,
          divisionId: divisionId,
          schemeId: schemeIdCtr.text,
          packageId: packageId.toString(),
          schemeCategoryId: categoryId.toString(),
          schemeSubCategoryId: subCategoryId.toString());

      if (model != null && model.schemesList.data != null) {
        list.addAll(model.schemesList.data!);
        lastPageNumber = model.schemesList.last_page == null
            ? 1
            : model.schemesList.last_page! + 1;
        for (var scheme in model.schemesList.data!) {
          await _database.schemeDao.insertScheme(scheme);

          if (scheme.geo_tags_array!.isNotEmpty) {
            for (var myLatLng in scheme.geo_tags_array!) {
              await _database.schemeDao.insertProposedSchemeLine(myLatLng);
            }
          }
        }

        pageNumber++;
      }

      if (lastPageNumber > pageNumber) {
        hasMoreData = true;
      } else {
        hasMoreData = false;
      }
    }

    // if (divisionId != 0 && districtId != 0 && cityCropId != 0) {
    //   list = await _database.schemeDao
    //       .getSchemeListByDivIdDisIdCityId(divisionId, districtId, cityCropId);
    // } else if (divisionId != 0 && districtId != 0) {
    //   list = await _database.schemeDao
    //       .getSchemeListByDivIdDisId(divisionId, districtId);
    // } else if (divisionId != 0) {
    //   list = await _database.schemeDao.getSchemeListByDivId(divisionId);
    // } else {
    //   list = await _database.schemeDao.getSchemeList();
    // }

    isLoading = false;
    update();
  }

  Future<List<ProgressAndStatusJoinModel>?> getSchemeProgressList() async {
    await callApiForProgressAndInsertDb();
    return await getProgressListDataForView();
  }

  Future<void> callApiForProgressAndInsertDb() async {
    String? token = prefs.getString("token");

    if (token != null) {
      SchemeProgressModel? model = await ApiService.getSchemeProgress(
          token, selectedSchemeid.toString());

      if (model != null && model.schemesProgress != null) {
        _database.schemeDao.insertSchemeProgress(model.schemesProgress!);

        await _database.schemeDao.clearProgressImageTable();
        await _database.schemeDao.clearProgressLtLngTable();

        _propossedCordsInsertDB(model);
        _progressImagesInsertDB(model);
      }
    }
  }

  Future<List<ProgressAndStatusJoinModel>?> getProgressListDataForView() async {
    List<ProgressAndStatusJoinModel>? model =
        await _database.schemeDao.getListOfProgressWithStatus(selectedSchemeid);

    return model;
  }

  setSelectedScheme(int id) async {
    selectedSchemeid = id;
    await prefs.setInt(selectedSchemeId, id);
  }

  setSelectedProgress(int id) async {
    selectedProgressid = id;
    await prefs.setInt(selectedProgressId, id);
  }

  Future<Scheme?> getScheme() async {
    Scheme? scheme = await _database.schemeDao.getSchemeById(selectedSchemeid);
    if (scheme != null) {
      schemeCategoryName = await _database.setupDao
              .getSchemeCategoriesNameById(scheme.scheme_category_id ?? 0) ??
          "N/A";
      schemeSubCategoryName = await _database.setupDao
              .getSchemeSubCategoriesNameById(
                  scheme.scheme_sub_category_id ?? 0) ??
          "N/A";
      return scheme;
    } else {
      return null;
    }
  }

  Future<List<MyLatLng>?> getSchemeProposedLine() async {
    final latLngList =
        await _database.schemeDao.getSchemeProposedLineById(selectedSchemeid);

    return latLngList;
  }

  void _propossedCordsInsertDB(SchemeProgressModel model) async {
    for (SchemeProgress s in model.schemesProgress!) {
      if (s.progress_geo_tags_array!.isNotEmpty) {
        try {
          _database.schemeDao
              .insertProgressLatLngList(s.progress_geo_tags_array!);
        } catch (e) {
          Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
        }
      }
    }
  }

  void _progressImagesInsertDB(SchemeProgressModel model) async {
    for (SchemeProgress s in model.schemesProgress!) {
      if (s.schemeProgressImages!.isNotEmpty) {
        try {
          _database.schemeDao.insertProgressImageList(s.schemeProgressImages!);
        } catch (e) {
          Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
        }
      }
    }
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
}
