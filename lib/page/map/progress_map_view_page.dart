import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:com.lged.lgcrrp.misulgi/data/model/scheme_progress_model.dart';
import '../../data/local/database.dart';
import '../../util/constant.dart';

class ProgressMapViewPage extends StatefulWidget {
  const ProgressMapViewPage({super.key});

  @override
  State<ProgressMapViewPage> createState() => _ProgressMapViewPageState();
}

class _ProgressMapViewPageState extends State<ProgressMapViewPage> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  CameraPosition? _kGooglePlex;

  Set<Polyline> polyLines = {};

  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: FutureBuilder(future: getMarkingLine(), builder: (ctx, snap) {
      if (snap.hasError) {
        return const Text("Erorr");
      } else if (snap.hasData) {
        return GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex!,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          polylines: snap.data!,
        );
      } else if (snap.connectionState == ConnectionState.waiting) {
        return const Center(
            child: Text(
              'Please wait...',
              style: TextStyle(fontSize: 22),
            ));
      } else {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_off,
                size: 80,
                color: Colors.red.shade200,
              ),
              const Text('No location found for this scheme'),
            ],
          ),
        );
      }
    }));
  }

  Future<Set<Polyline>?> getMarkingLine() async {
    final points = await getPointsOfLine();
    if (points != null) {
      Set<Polyline> polyLines = {};

      Polyline polyline = Polyline(
        polylineId: const PolylineId("poly"),
        color: Colors.red,
        points: points,
      );

      polyLines.add(polyline);

      return polyLines;
    } else {
      return null;
    }
  }

  Future<List<LatLng>?> getPointsOfLine() async {
    List<ProgressLatLngModel>? list = await getProgressLine();

    if (list != null && list.isNotEmpty) {
      final List<LatLng> points = [];

      ProgressLatLngModel firstLatLng = list.first;
      _kGooglePlex = CameraPosition(
        target: LatLng(
            firstLatLng.lat, firstLatLng.lng),
        zoom: 25.5,
      );

      for (var myLatLng in list) {
        points.add(
            LatLng(myLatLng.lat, myLatLng.lng));
      }

      return points;
    } else {
      return null;
    }
  }


  Future<List<ProgressLatLngModel>?> getProgressLine() async {

    AppDatabase _database  =   await AppDatabase.getInstance();
    SharedPreferences   prefs = await SharedPreferences.getInstance();
    int   schemeId = prefs.getInt(selectedSchemeId) ?? 0;
    int progressId = prefs.getInt(selectedProgressId) ?? 0;
    final latLngList = await _database.schemeDao.getProgressLatLong(schemeId, progressId);

    return latLngList;
  }

}
