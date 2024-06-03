import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:com.lged.lgcrrp.misulgi/controller/scheme/scheme_list_ctr.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/response_model/scheme/scheme_list_model.dart';

class SchemeMapPage extends StatefulWidget {
  const SchemeMapPage({super.key});

  @override
  State<SchemeMapPage> createState() => InitialMapViewState();
}

class InitialMapViewState extends State<SchemeMapPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final ctr = Get.find<SchemeListCtr>();
  CameraPosition? _kGooglePlex;

  Set<Polyline> polyLines = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getMarkingLine(),
            builder: (ctx, snap) {
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
    List<MyLatLng>? list = await ctr.getSchemeProposedLine();

    if (list != null && list.isNotEmpty) {
      final List<LatLng> points = [];

      MyLatLng firstLatLng = list.first;
      _kGooglePlex = CameraPosition(
        target: LatLng(
            double.parse(firstLatLng.lat), double.parse(firstLatLng.lng)),
        zoom: 13.5,
      );

      for (var myLatLng in list) {
        points.add(
            LatLng(double.parse(myLatLng.lat), double.parse(myLatLng.lng)));
      }

      return points;
    } else {
      return null;
    }
  }
}
