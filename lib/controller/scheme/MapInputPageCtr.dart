import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/local/database.dart';
import '../../data/model/scheme_progress_model.dart';

class MapInputCtr extends GetxController {
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

  void gatherCordsTask() {
    hasRunningTask = true;

    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .then((value) {
        lat = value.latitude;
        lng = value.longitude;
        print('lat-->$lat   lng--> $lng');

        latLngList.add(LatLng(lat, lng));

        update();
      });
    });
  }

  void saveMapInputToDB() async {
    EasyLoading.show(status: 'Please wait...');
    int schemeId = prefs.getInt("selectedSchemeId") ?? 0;

    List<ProgressLatLngModel> model = [];
   print(' here is yur lat lat list $latLngList');
    for (LatLng m in latLngList) {
      model.add(ProgressLatLngModel(
          lat: m.latitude,
          lng: m.longitude,
          schemeId: schemeId,
          //TODO: set selfId
          progressId: null, selfId: 00));
    }
    try {
      await _database.schemeDao.insertProgressLatLngList(model);
    } catch (e) {
      EasyLoading.showError('Error: ${e.toString()}');
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    await _initDB();
  }

  Future<void> _initDB() async {
    _database = await AppDatabase.getInstance();
    prefs = await SharedPreferences.getInstance();
  }
}
