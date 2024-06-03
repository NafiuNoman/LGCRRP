import 'dart:async';

import 'package:floor/floor.dart';
import 'package:com.lged.lgcrrp.misulgi/data/local/dao/contact_dao.dart';
import 'package:com.lged.lgcrrp.misulgi/data/local/dao/grs_dao.dart';
import 'package:com.lged.lgcrrp.misulgi/data/local/dao/scheme_dao.dart';
import 'package:com.lged.lgcrrp.misulgi/data/local/dao/setup_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;// this is needed for floor databse
import 'package:com.lged.lgcrrp.misulgi/data/local/entity/join_entity/progress_and_status.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/response_model/scheme/scheme_list_model.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/response_model/scheme/scheme_setup_model.dart';

import '../model/scheme_progress_model.dart';
import '../remote/model/contact_super_model.dart';
import '../remote/model/response_model/grs/complaint_list_model.dart';
import '../remote/model/response_model/scheme/login_response_model.dart';
import '../remote/model/setup/setup_model.dart';

part 'database.g.dart';

@Database(version: 1, entities: [
  DivisionEntity,
  DistrictEntity,
  CityCorporationEntity,
  DesignationEntity,
  BloodGroupEntity,
  GenderEntity,
  ContactModel,
  ComplaintTypeModel,
  ComplaintDetailsModel,

  Scheme,
  SchemeProgress,
  ProgressLatLngModel,
  ProgressImageModel,
  ProgressStatusModel,
  SchemeStatusModel,
  SchemeSubCategoryModel,
  SchemeCategoryModel,
  PackageModel,
  SchemeLogInResModel,//details table of user who logged in by scheme login page

  MyLatLng
],views: [ProgressAndStatusJoinModel])
abstract class AppDatabase extends FloorDatabase {
  SetupDao get setupDao;
  ContactDao get contactDao;
  SchemeDao get schemeDao;
  GrsDao get grsDao;

  static AppDatabase? _instance;

  static Future<AppDatabase> getInstance() async {
    return _instance ??=
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }
}
