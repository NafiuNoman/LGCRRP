import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/local/database.dart';
import '../../data/remote/model/setup/setup_model.dart';


class TestController extends GetxController {
  late AppDatabase _database;
  late SharedPreferences prefs;
  int divisionId = 0;
  int districtId = 0;
  int cityCropId = 0;

  List<DivisionEntity> divisionList = [];
  List<DistrictEntity> districtList = [];
  List<CityCorporationEntity> cityCropList = [];

  List<DropdownMenuItem<int>> divisionDropDownItems = [];
  List<DropdownMenuItem<int>> districtDropDownItems = [];
  List<DropdownMenuItem<int>> cityCropDropDownItems = [];

  @override
  void onReady() async {
    await _initDB();
    super.onReady();
    setDivions();
  }

  Future<void> _initDB() async {
    _database = await AppDatabase.getInstance();
    prefs = await SharedPreferences.getInstance();
  }

  void setDivions() async {
    divisionList = await _database.setupDao.getDivisions();
    if (divisionList.isNotEmpty) {
      divisionDropDownItems = divisionList
          .map((e) => DropdownMenuItem(
                value: e.id,
                child: Text(e.name_en),
              ))
          .toList();
    }
    update();
  }

  void setDistrictbyId(int id) async {
    districtId=0;
    cityCropId=0;


    districtList = await _database.setupDao.getDistrictsByDivisionId(id);
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

  setCityCrop(int id) async {
    cityCropId=0;

    cityCropList = await _database.setupDao.getCityCropsByDistrictId(id);
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

  setCityValue(int value) {
    cityCropId = value;
    update();
  }
}
