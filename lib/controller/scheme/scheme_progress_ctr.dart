import 'dart:async';
import 'package:com.lged.lgcrrp.misulgi/util/common_method.dart';
import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:com.lged.lgcrrp.misulgi/controller/scheme/scheme_list_ctr.dart';
import 'package:com.lged.lgcrrp.misulgi/data/model/image_info_model.dart';
import 'dart:io';
import '../../data/local/database.dart';
import '../../data/model/scheme_progress_model.dart';
import '../../data/remote/api_service.dart';
import '../../data/remote/model/response_model/scheme/scheme_list_model.dart';
import '../../data/remote/model/response_model/scheme/scheme_setup_model.dart';
import '../../util/constant.dart';
import '../common_controller.dart';

class SchemeProgressCtr extends GetxController {
  late AppDatabase _database;
  late SharedPreferences prefs;

  double lat = 0.0;
  double lng = 0.0;
  bool hasPermission = false;
  bool hasRunningTask = false;
  late Timer timer;
  List<LatLng> latLngList = [];

  Set<Polyline> polyLines = {};
  late Polyline polyline;
  late AnimationController animationController;
  String mapStringList = '';

  int userId = 0;
  int divisionId = 0;
  int districtId = 0;
  int cityCropId = 0;
  int schemeStatusId = 0;
  int schemeId = 0;

  int progressId = 0;

  Scheme? scheme;
  List<SchemeStatusModel> schemeStatusList = [];
  List<ImageInfoModel> selectedImages = [];
  bool isLoading = true;

  final schemeListCtr = Get.find<SchemeListCtr>();
  final reportingDateCtr = TextEditingController();
  final amountSpentCtr = TextEditingController();
  final remarksCtr = TextEditingController();

  final financialProgressCtr = TextEditingController();
  final physicalProgressCtr = TextEditingController();

  final noOfLaborMaleCtr = TextEditingController();
  final noOfLaborFemaleCtr = TextEditingController();

  final noOfDaysLaborMaleCtr = TextEditingController();
  final noOfDaysLaborFemaleCtr = TextEditingController();

  final noOfWomenWithPaidCtr = TextEditingController();
  final totalLaborCostPaidCtr = TextEditingController();
  final cmnCtr = Get.find<CommonController>();

  final formKey = GlobalKey<FormState>();

  @override
  void onReady() async {
    super.onReady();
    await _initDB();
    await loadSchemeRelatedData();
    await loadSchemeStatus();
  }

  Future<void> _initDB() async {
    _database = await AppDatabase.getInstance();
    prefs = await SharedPreferences.getInstance();
  }

  //region load schemes and other ids from DB
  Future<void> loadSchemeRelatedData() async {
    schemeId = prefs.getInt(selectedSchemeId) ?? 0;
    scheme = await _database.schemeDao.getSchemeById(schemeId);

    userId = prefs.getInt(schemeUserId) ?? 1;

    divisionId =
        await _database.schemeDao.getDivisionIdBySchemeId(schemeId) ?? 0;
    districtId =
        await _database.schemeDao.getDistrictIdBySchemeId(schemeId) ?? 0;
    cityCropId =
        await _database.schemeDao.getCityCropsBySchemeId(schemeId) ?? 0;
  }

  //endregion
  //region load Scheme status from DB
  Future<void> loadSchemeStatus() async {
    schemeStatusList = await _database.setupDao.getSchemeStatus();
    isLoading = false;
    update();
  }

  //endregion

  //region picking images
  Future<void> pickImageWithGPSMetaData() async {
    try {
      List<XFile> pickedImages = await ImagePicker()
          .pickMultiImage(imageQuality: 100, maxHeight: 1000, maxWidth: 1000);

      if (pickedImages.isNotEmpty) {
        for (var image in pickedImages) {
          final tags = await getExifFile(image.path);

          if (tags.isNotEmpty) {
            if (tags.containsKey('GPS GPSLatitude') &&
                tags.containsKey('GPS GPSLongitude')) {
              double lat = getDoubleValueFromIDFTag(tags['GPS GPSLatitude']!);
              double lng = getDoubleValueFromIDFTag(tags['GPS GPSLongitude']!);

              selectedImages.add(ImageInfoModel(
                  hasGeotag: true,
                  imagePath: image.path,
                  latitude: lat,
                  longitude: lng));
            } else {
              selectedImages.add(ImageInfoModel(
                hasGeotag: false,
                imagePath: image.path,
              ));
            }
          }
        }
      } else {
        Fluttertoast.showToast(msg: 'No image selected');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error :$e');
    }
    update();
  }

  //endregion

  double getDoubleValueFromIDFTag(IfdTag latitude) {
    if (latitude.values.length > 0) {
      List<Ratio> gpsArray = latitude.values.toList() as List<Ratio>;

      double val = gpsArray[0].toDouble() +
          gpsArray[1].toDouble() / 60 +
          gpsArray[2].toDouble() / 3600;

      return val;
    } else {
      return 0;
    }
  }

  Future<Map<String, IfdTag>> getExifFile(String path) async {
    final fileBytes = File(path).readAsBytesSync();
    final tags = await readExifFromBytes(fileBytes);

    return tags;
    // print("tags: $tags");
  }

  //region validate progress form and save/draft to DB
  Future<bool?> validateAndSave() async {
    if (formKey.currentState!.validate()) {
      SchemeProgress progress = _makeProgressModel();

      if (await cmnCtr.checkInternet()) {
        try {
          int rowId = await _database.schemeDao.saveSchemeProgress(progress);
          String? token = prefs.getString("token");

          if (token != null) {
            ProgressResponseModel? model = await ApiService.postSchemeProgress(
                token, progress, mapStringList, userId, "2", selectedImages);

            if (model != null && model.code == 200) {
              if (model.id != null) {
                int? updateId = await _database.schemeDao
                    .updateProgressWithServerId(model.id!, rowId);

                print('$updateId');
              }
              // progress = model.schemesProgress!;
              // Fluttertoast.showToast(msg: 'Successfully saved',backgroundColor: Colors.green);

              // return progress;
            }
          }

          return true;
        } catch (e) {
          print('erorr catched...${e.toString()}');
          Fluttertoast.showToast(msg: 'erorr catched...${e.toString()}');
          return false;
        }
      }
    }
    return null;
  }

  Future<bool?> validateAndDraft() async {
    if (formKey.currentState!.validate()) {
      SchemeProgress progress = _makeProgressModel();

      if (await cmnCtr.checkInternet()) {
        try {
          int rowId = await _database.schemeDao.saveSchemeProgress(progress);
          String? token = prefs.getString("token");

          if (token != null) {
            ProgressResponseModel? model = await ApiService.postSchemeProgress(
                token, progress, mapStringList, userId, "1", selectedImages);

            if (model != null && model.code == 200) {
              if (model.id != null) {
                int? updateId = await _database.schemeDao
                    .updateProgressWithServerId(model.id!, rowId);

                print('$updateId');
              }
              // progress = model.schemesProgress!;
              // Fluttertoast.showToast(msg: 'Successfully saved',backgroundColor: Colors.green);

              // return progress;
            }
          }

          return true;
        } catch (e) {
          print('erorr catched...${e.toString()}');
          Fluttertoast.showToast(msg: 'erorr catched...${e.toString()}');
          return false;
        }
      }
    }
    return null;
  }

  //endregion
  //region validate progress form and save/draft to DB

  Future<bool?> validateAndUpdate({required int status}) async {
    if (formKey.currentState!.validate()) {
      SchemeProgress progress = _makeProgressModel(pId: progressId);

      if (await cmnCtr.checkInternet()) {
        try {
          // ///TODO:
          // await _database.schemeDao.saveSchemeProgress(progress);
          String? token = prefs.getString("token");

          if (token != null) {
            ProgressResponseModel? model =
                await ApiService.updateSchemeProgress(
                    token,
                    progress,
                    mapStringList,
                    userId,
                    status.toString(),
                    selectedImages,
                    progressId.toString());

            if (model != null && model.code == 200) {
              Fluttertoast.showToast(
                  msg: 'Your information has been Updated successfully.',
                  backgroundColor: Colors.green);
            }
          }

          return true;
        } catch (e) {
          print('erorr catched...${e.toString()}');
          Fluttertoast.showToast(msg: 'erorr catched...${e.toString()}');
          return false;
        }
      }
    }
    return null;
  }

  //endregion

  //region population of progress model
  SchemeProgress _makeProgressModel({int? pId}) {
    DateFormat format = DateFormat("dd-MMM-yyyy");
    DateTime dateTime = format.parse(reportingDateCtr.text.trim());
    String reportedDate = DateFormat('dd-MM-yyyy').format(dateTime);

    return SchemeProgress(
      id: pId,
      scheme_id: schemeId,
      // scheme_name: 'scheme_name',
      division_id: divisionId,
      district_id: districtId,
      upazila_id: null,
      organogram_id: cityCropId,
      reported_date: reportedDate,
      financial_progress: financialProgressCtr.text,
      physical_progress: physicalProgressCtr.text,
      amount_spent_in_bdt: amountSpentCtr.text,
      scheme_status: schemeStatusId,

      male_labor_days_reported: int.parse(noOfDaysLaborMaleCtr.text.trim()),
      female_labor_days_reported: int.parse(noOfDaysLaborFemaleCtr.text.trim()),

      male_labor_number_reported: int.parse(noOfLaborMaleCtr.text.trim()),
      female_labor_number_reported: int.parse(noOfLaborFemaleCtr.text.trim()),

      women_number_paid_employement:
          int.parse(noOfWomenWithPaidCtr.text.trim()),
      total_labor_cost_paid: totalLaborCostPaidCtr.text,

      dayOfMonth: dateTime.day.toString(),
      monthName: DateFormat('MMM').format(dateTime),
      remarks: remarksCtr.text.toString(),
      year: dateTime.year.toString(),
    );
  }

  //endregion

  removeImage(int index) {
    selectedImages.removeAt(index);
    update();
  }

  //region initiate GPS for taking data or stop and save GPS data
  Future<void> starTakingMapInput() async {
    if (hasRunningTask) {
      timer.cancel();
      hasRunningTask = false;

      polyline = Polyline(
          polylineId: const PolylineId('previewLine'),
          points: latLngList,
          color: Colors.redAccent);
      polyLines.add(polyline);

      update();
    } else {
      if (await handelLocationPermission()) {
        gatherCordsTask();
      }
    }
  }

  //endregion

  //region check GPS and request for permission
  Future<bool> handelLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Location service is not enabled');
    } else {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          Fluttertoast.showToast(msg: 'Location permission is denied');
        } else if (permission == LocationPermission.deniedForever) {
          Fluttertoast.showToast(msg: 'Location permission is denied forever');
        } else {
          hasPermission = true;
        }
      } else {
        hasPermission = true;
      }
    }

    return hasPermission;
  }

  //endregion

  CameraPosition cameraPosition = const CameraPosition(
      target: LatLng(23.932820609793254, 90.1021253277863));

  void gatherCordsTask() {
    hasRunningTask = true;
    update();

    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .then((value) {
        lat = value.latitude;
        lng = value.longitude;

        latLngList.add(LatLng(lat, lng));

        update();
      });
    });
  }

  void saveMapInputToDB() async {
    EasyLoading.show(status: 'Please wait...');
    int schemeId = prefs.getInt("selectedSchemeId") ?? 0;

    List<ProgressLatLngModel> model = [];

    for (LatLng m in latLngList) {
      model.add(ProgressLatLngModel(
          lat: m.latitude,
          lng: m.longitude,
          schemeId: schemeId,
          //TODO: set selfId
          progressId: null,
          selfId: 00));
    }
    mapStringList = mapListToJson(model);
    EasyLoading.dismiss();

    // try {
    //   await _database.schemeDao.insertProgressLatLngList(model);
    // } catch (e) {
    //   EasyLoading.showError('Error: ${e.toString()}');
    // } finally {
    //   EasyLoading.dismiss();
    // }
  }

  //region deletion of recorded map
  deleteRecordedMap() {
    latLngList.clear();
    Fluttertoast.showToast(msg: "Map is deleted!");
    update();
  }

  //endregion

//region load previous draft progress data
  Future<void> loadDraftDataForProgress() async {
    _database = await AppDatabase.getInstance();
    prefs = await SharedPreferences.getInstance();

    progressId = prefs.getInt(selectedProgressId) ?? 0;
    schemeId = prefs.getInt(selectedSchemeId) ?? 0;
    var progress = await _database.schemeDao.getProgressById(progressId);
    if (progress != null) {
      DateFormat format = DateFormat('dd-MM-yyyy');
      DateTime dateTime = format.parse(progress.reported_date ?? '');

      reportingDateCtr.text = makeDateForFormView(dateTime);
      schemeStatusId = progress.scheme_status ?? 0;
      amountSpentCtr.text = progress.amount_spent_in_bdt ?? '';
      physicalProgressCtr.text = progress.physical_progress ?? '';
      financialProgressCtr.text = progress.financial_progress ?? '';
      noOfLaborMaleCtr.text = progress.male_labor_number_reported == null
          ? ''
          : progress.male_labor_number_reported.toString();
      noOfLaborFemaleCtr.text = progress.male_labor_number_reported == null
          ? ''
          : progress.male_labor_number_reported.toString();
      noOfDaysLaborMaleCtr.text = progress.male_labor_days_reported == null
          ? ''
          : progress.male_labor_days_reported.toString();
      noOfDaysLaborFemaleCtr.text = progress.female_labor_days_reported == null
          ? ''
          : progress.female_labor_days_reported.toString();
      noOfWomenWithPaidCtr.text = progress.women_number_paid_employement == null
          ? ""
          : progress.women_number_paid_employement.toString();
      totalLaborCostPaidCtr.text = progress.total_labor_cost_paid ?? '';
      remarksCtr.text = progress.remarks ?? "";

      var list =
          await _database.schemeDao.getProgressLatLong(schemeId, progressId);
      if (list != null && list.isNotEmpty) {
        latLngList.clear();
        for (var i in list) {
          latLngList.add(LatLng(i.lat, i.lng));
        }
      }
    }
    update();
  }

//endregion

  Future<void> moveToCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition();

    cameraPosition = CameraPosition(
        target: LatLng(
          position.latitude,
          position.longitude,
        ),
        zoom: 14);
  }
}
