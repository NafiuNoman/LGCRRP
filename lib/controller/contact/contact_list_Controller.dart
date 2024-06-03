import 'package:com.lged.lgcrrp.misulgi/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/api_service.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/contact_super_model.dart';
import '../../data/local/database.dart';
import '../../data/remote/model/setup/setup_model.dart';
import '../common_controller.dart';

class ContactListController extends GetxController {
  late AppDatabase _database;
  late SharedPreferences prefs;

  List<ContactModel> list = [];

  final cmnCtr = Get.find<CommonController>();

  bool isLoading = false;
  bool hasMoreData = false;
  bool expandFilter = true;

  int selectedSchemeid = 0;
  int selectedProgressid = 0;
  int pageNumber = 1;
  int lastPageNumber = 1;
  int divisionId = 0;
  int districtId = 0;
  int cityCropId = 0;
  final searchCtr = TextEditingController();
  ScrollController scrollController = ScrollController();

  List<DivisionEntity> divisionList = [];
  List<DistrictEntity> districtList = [];
  List<CityCorporationEntity> cityCropList = [];
  List<DropdownMenuItem<int>> divisionDropDownItems = [];
  List<DropdownMenuItem<int>> districtDropDownItems = [];
  List<DropdownMenuItem<int>> cityCropDropDownItems = [];

  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();

    super.onInit();
  }

  @override
  void onReady() async {
    await _initDB();
    await setDivisions();
    scrollController.addListener(scrollListener);
  }

  scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (lastPageNumber > pageNumber) {
        getUserContactList();
      }
      if (hasMoreData == false) {
        Fluttertoast.showToast(msg: 'All data fetched');
      }
    }
  }

  Future<void> _initDB() async {
    _database = await AppDatabase.getInstance();
    prefs = await SharedPreferences.getInstance();
  }

  setDivisions() async {
    divisionList = await _database.setupDao.getDivisions();

    if (divisionList.isNotEmpty) {
      divisionDropDownItems = divisionList
          .map((e) => DropdownMenuItem(
                child: Text(e.name_en),
                value: e.id,
              ))
          .toList();
    }
    update();
  }

  setDistricts(int divId) async {
    districtId = 0;
    cityCropId = 0;

    cityCropDropDownItems.clear();

    divisionId = divId;
    districtList = await _database.setupDao.getDistrictsByDivisionId(divId);

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

  setCityCorporation(int disId) async {
    cityCropId = 0;

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

    update();
  }

  setCityCropsValue(int id) {
    cityCropId = id;
    update();
  }

  Future<void> getUserContactList() async {
    if (!await cmnCtr.checkInternet()) {
      return;
    }

    isLoading = true;
    expandFilter = false;

    update();

    ContactSuperModel? superModel = await ApiService.getUserContactList(
        divisionId: divisionId.toString(),
        districtId: districtId.toString(),
        organogramId: cityCropId.toString(),
        search: searchCtr.text,
        pageNumber: pageNumber.toString());

    if (superModel != null && superModel.ulgiContacts != null) {
      UlgiContactsModel? ulgiModel = superModel.ulgiContacts;

      if (ulgiModel!.data != null && ulgiModel.data!.isNotEmpty) {
        lastPageNumber = ulgiModel.last_page + 1;

        List<ContactModel> contactList = ulgiModel.data!;

        list.addAll(contactList);

        pageNumber++;
      }
    }

    if (lastPageNumber > pageNumber) {
      hasMoreData = true;
    } else {
      hasMoreData = false;
    }

    isLoading = false;

    update();
  }

  int? getUserIdFromPref() {
    final int? userId = prefs.getInt(contactId);

    return userId;
  }

  clearIdOfUser() async {
    await prefs.setInt(contactId, 0);
    _database.contactDao.clearContactTable();
    list.clear();
  }

  Future<String?> getDesignationById(int? id) async {
    String? name =
        id != null ? await _database.setupDao.getDesignationNameById(id) : null;

    return name;
  }

  Future<String?> getDivisionNameById(int? id) async {
    String? name =
        id != null ? await _database.setupDao.getDivisionNameById(id) : null;

    return name;
  }  Future<String?> getDistrictNameById(int? id) async {
    String? name =
        id != null ? await _database.setupDao.getDistrictNameById(id) : null;

    return name;
  } Future<String?> getCityCropNameById(int? id) async {
    String? name =
        id != null ? await _database.setupDao.getCityCorporationNameById(id) : null;

    return name;
  }

  Future<ContactModel?> getLoggedInUserContactDetails() async {
    var contact = await _database.contactDao.getAllContacts();
    return contact;
  }
}
