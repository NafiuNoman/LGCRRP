import 'dart:io';

import 'package:com.lged.lgcrrp.misulgi/controller/contact/reg_log_vm.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/contact_super_model.dart';
import 'package:com.lged.lgcrrp.misulgi/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:com.lged.lgcrrp.misulgi/data/local/database.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/request_model/new_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/remote/api_service.dart';
import '../../data/remote/model/response_model/new_user_res_model.dart';
import '../../data/remote/model/setup/setup_model.dart';
import '../common_controller.dart';

class ProfileFormController extends GetxController {
  final cmnCtr = Get.find<CommonController>();
  final regLogInController = Get.find<RegLogController>();
  late SharedPreferences _prefs;
  late AppDatabase _database;

  bool isLoading = true;
  String mode = '';

  ContactModel? currentUser;

  int divisionId = 0;
  int districtId = 0;
  int cityCropId = 0;
  int? designationId = 0;
  String genderId = '';
  String bloodId = '';
  String removePreviousImage = "";

  List<DivisionEntity> _divisions = [];
  List<DistrictEntity> _districts = [];
  List<CityCorporationEntity> _cityCrops = [];
  List<DesignationEntity> _designations = [];
  List<GenderEntity> _genders = [];
  List<BloodGroupEntity> _bloods = [];

  List<DropdownMenuItem> divisionItems = [];
  List<DropdownMenuItem> districtItems = [];
  List<DropdownMenuItem> cityCropsItems = [];
  List<DropdownMenuItem> designationItems = [];
  List<DropdownMenuItem> genderItems = [];
  List<DropdownMenuItem> bloodItems = [];

  Rx<File?> imageFile = Rx<File?>(null);

  final nameEnCtr = TextEditingController();
  final nameBnCtr = TextEditingController();
  final emailCtr = TextEditingController();

  final phoneCtr = TextEditingController();
  final whatAppCtr = TextEditingController();
  final nidCtr = TextEditingController();
  final presentAddressCtr = TextEditingController();
  final permanentAddressCtr = TextEditingController();
  final birthdayController = TextEditingController();

  @override
  void onInit() {
    _initDB();
    super.onInit();
  }

  loadDataAsUser() async {
    _database = await AppDatabase.getInstance();

    if (currentUser != null) {
      await _fillDataInForm();
    } else {
      await _fillDataInFormForNewUser();
    }
    isLoading = false;

    update();
  }

  //fill user data for edit
  _fillDataInForm() async {
    _divisions = await _database.setupDao.getDivisions();

    divisionItems = _divisions.map((DivisionEntity division) {
      return DropdownMenuItem(
        value: division.id,
        child: Text(division.name_en),
      );
    }).toList();

    divisionId = currentUser!.division_id;
    _districts = await _database.setupDao.getDistrictsByDivisionId(divisionId);
    districtItems = _districts.map((DistrictEntity district) {
      return DropdownMenuItem(
        value: district.id,
        child: Text(district.name_en),
      );
    }).toList();

    districtId = currentUser!.district_id;
    _cityCrops = await _database.setupDao.getCityCropsByDistrictId(districtId);
    cityCropsItems = _cityCrops.map((CityCorporationEntity city) {
      return DropdownMenuItem(
        value: city.id,
        child: Text(city.name_en),
      );
    }).toList();
    cityCropId = currentUser!.organogram_id;
    _designations = await _database.setupDao.getDesignations();
    _bloods = await _database.setupDao.getBloodGroups();
    _genders = await _database.setupDao.getGenders();
    designationItems = _designations.map((DesignationEntity designation) {
      return DropdownMenuItem(
        value: designation.id,
        child: Text(designation.name_en),
      );
    }).toList();
    genderItems = _genders.map((GenderEntity gender) {
      return DropdownMenuItem(
        value: gender.id,
        child: Text(gender.name_en),
      );
    }).toList();
    bloodItems = _bloods.map((BloodGroupEntity blood) {
      return DropdownMenuItem(
        value: blood.id,
        child: Text(blood.name_en),
      );
    }).toList();

    designationId = currentUser!.designation_id;
    genderId = currentUser!.gender??'';
    bloodId = currentUser!.blood_group ?? "";

    nameEnCtr.text = currentUser!.name_en;
    nameBnCtr.text = currentUser!.name_bn??'';
    phoneCtr.text = currentUser!.mobile_number;

    emailCtr.text = currentUser!.email;
    whatAppCtr.text = currentUser!.whats_app_number ?? "";
    birthdayController.text = currentUser!.date_of_birth ?? "";

    nidCtr.text = currentUser!.nid_number ?? "";
    permanentAddressCtr.text = currentUser!.permanent_address ?? "";
    presentAddressCtr.text = currentUser!.present_address ?? "";
  }

  void _initDB() async {
    _prefs = await SharedPreferences.getInstance();
    _database = await AppDatabase.getInstance();
  }

  pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        imageFile.value = null;
      } else {
        final imageTemporary = File(image.path);
        imageFile.value = imageTemporary;
      }
    } on PlatformException catch (e) {
      print("Error: $e");
    }
  }

  Future<void> cleanContactsTable() async {
    try {
      return await _database.contactDao.clearContactTable();
    } catch (e) {
      Fluttertoast.showToast(msg: " $e");
    }
  }

  bool isUserInfoEdited() {
    bool isEdited = false;

    if (currentUser != null) {
      if (divisionId != currentUser!.division_id) {
        isEdited = true;
      } else if (districtId != currentUser!.district_id) {
        isEdited = true;
      } else if (cityCropId != currentUser!.organogram_id) {
        isEdited = true;
      }
    }

    return isEdited;
  }

  resetUserInfo() {
    if (currentUser != null) {
      divisionId = currentUser!.division_id;
      districtId = currentUser!.district_id;
      cityCropId = currentUser!.organogram_id;
    }
  }

  NewUserModel getNewUserData() => NewUserModel(
      nid_number: nidCtr.text,
      id: currentUser?.id,
      name_en: nameEnCtr.text,
      name_bn: nameBnCtr.text,
      email: emailCtr.text,
      mobile_number: phoneCtr.text,
      division_id: divisionId,
      district_id: districtId,
      organogram_id: cityCropId,
      designation_id: designationId??0,
      whats_app_number: whatAppCtr.text,
      blood_group: bloodId,
      gender: genderId,
      date_of_birth: birthdayController.text,
      permanent_address: permanentAddressCtr.text,
      present_address: presentAddressCtr.text,
      existing_profile_image:
          currentUser != null ? currentUser!.profile_image : "",
      remove_existing_profile_image: removePreviousImage,
      profile_image: imageFile.value);

  Future<void> updateContactProfileData() async {
    if (!await cmnCtr.checkInternet()) {
      return;
    }

    EasyLoading.show(status: 'Processing...');

    removePreviousImage = "yes";
    var user = getNewUserData();

    OldUserUpdateResponseModel? model =
        await ApiService.postUpdateUserData(user);

    if (model != null && model.ulgiContactInfo != null) {
      try {
        await _database.contactDao.insertContact(model.ulgiContactInfo!);
        await _prefs.setInt(contactId, model.id!);
      } catch (e) {
        print('exception: ${e.toString()}');
      }
    }

    EasyLoading.dismiss();
  }

  Future<void> postNewUserContact() async {
    if (!await cmnCtr.checkInternet()) {
      return;
    }
    EasyLoading.show(status: 'Processing...');

    removePreviousImage = "no";
    var user = getNewUserData();

    NewUserSaveResponseModel? model = await ApiService.postNewUserData(user);

    if (model != null && model.contact_details != null) {
      try {
        await _database.contactDao.insertContact(model.contact_details!);
        await _prefs.setInt(contactId, model.id!);
      } catch (e) {
        print('exception: ${e.toString()}');
      }
    }

    EasyLoading.dismiss();
  }

  void setDistrictByDivisionId(int id) async {
    divisionId = id;
    districtId = 0;
    cityCropId = 0;
    _districts.clear();
    _cityCrops.clear();
    districtItems.clear();
    cityCropsItems.clear();

    _districts = await _database.setupDao.getDistrictsByDivisionId(divisionId);

    districtItems = _districts.map((DistrictEntity item) {
      return DropdownMenuItem(
        value: item.id,
        child: Text(item.name_en),
      );
    }).toList();

    update();
  }

  void setCityCorporationByDistrictId(int id) async {
    districtId = id;
    cityCropId = 0;
    _cityCrops.clear();
    cityCropsItems.clear();
    _cityCrops = await _database.setupDao.getCityCropsByDistrictId(districtId);
    cityCropsItems = _cityCrops.map((CityCorporationEntity item) {
      return DropdownMenuItem(
        value: item.id,
        child: Text(item.name_en),
      );
    }).toList();
    update();
  }

  void setCityCorporationId(int id) {
    cityCropId = id;
    update();
  }

  _fillDataInFormForNewUser() async {
    phoneCtr.text = regLogInController.contactUserPhoneNumber;
    _divisions = await _database.setupDao.getDivisions();
    _designations = await _database.setupDao.getDesignations();
    _bloods = await _database.setupDao.getBloodGroups();
    _genders = await _database.setupDao.getGenders();

    divisionItems = _divisions.map((DivisionEntity division) {
      return DropdownMenuItem(
        value: division.id,
        child: Text(division.name_en),
      );
    }).toList();

    designationItems = _designations.map((DesignationEntity designation) {
      return DropdownMenuItem(
        value: designation.id,
        child: Text(designation.name_en),
      );
    }).toList();
    genderItems = _genders.map((GenderEntity gender) {
      return DropdownMenuItem(
        value: gender.id,
        child: Text(gender.name_en),
      );
    }).toList();
    bloodItems = _bloods.map((BloodGroupEntity blood) {
      return DropdownMenuItem(
        value: blood.id,
        child: Text(blood.name_en),
      );
    }).toList();
  }

  refreshData() {
    currentUser = null;
    divisionId=0;
    districtId = 0;
    districtId = 0;
    cityCropId = 0;
    bloodId = '';
    genderId = '';
    designationId = 0;
    removePreviousImage = '';
  }
}
