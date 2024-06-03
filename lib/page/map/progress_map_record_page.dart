import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import '../../controller/scheme/scheme_progress_ctr.dart';

class ProgressMapRecordPage extends StatefulWidget {
  const ProgressMapRecordPage({super.key});

  @override
  State<ProgressMapRecordPage> createState() => _ProgressMapRecordPageState();
}

class _ProgressMapRecordPageState extends State<ProgressMapRecordPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  GoogleMapController? _gcontroller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
            )),
        title: const Text(
          'Scheme Progress',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GetBuilder<SchemeProgressCtr>(
          init: SchemeProgressCtr(),
          builder: (ctr) => SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Scrollbar(
                    thickness: 10,
                    child: ListView.builder(
                        itemCount: ctr.latLngList.length,
                        itemBuilder: (ctx, i) {
                          var item = ctr.latLngList.elementAt(i);
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: Colors.redAccent,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                  ' lat/lng: ${item.latitude}, ${item.longitude}'),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                        }),
                  ),
                ),
                Lottie.asset('assets/anim/map_tracking.json',
                    width: 250,
                    controller: _controller, onLoaded: (composition) {
                  _controller.duration = composition.duration;
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                        icon: Icon(ctr.hasRunningTask
                            ? Icons.pause_circle_filled_outlined
                            : Icons.play_circle_fill_outlined),
                        onPressed: () async {
                          await ctr.starTakingMapInput();

                          if (!_controller.isAnimating && ctr.hasPermission) {
                            _controller.repeat();
                          } else {
                            _controller.stop();
                          }
                        },
                        label: Text(ctr.hasRunningTask ? 'Stop' : 'Start')),
                    (!ctr.hasRunningTask && ctr.latLngList.isNotEmpty)
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Gap(10),
                              OutlinedButton.icon(
                                  onPressed: () async {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              contentPadding:
                                                  const EdgeInsets.all(0),
                                              insetPadding:
                                                  const EdgeInsets.all(10),
                                              shape: Border.all(
                                                  width: 1.5,
                                                  color: Colors.green),
                                              content: SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: GoogleMap(
                                                    compassEnabled: true,
                                                    mapType: MapType.normal,
                                                    onMapCreated:
                                                        (GoogleMapController
                                                            controller) async {
                                                      _gcontroller = controller;
                                                      await _moveToCurrentLocation();
                                                    },
                                                    myLocationEnabled: true,
                                                    myLocationButtonEnabled:
                                                        true,
                                                    polylines: ctr.polyLines,
                                                    initialCameraPosition:
                                                        ctr.cameraPosition),
                                              ),
                                              actions: [
                                                OutlinedButton.icon(
                                                    label: const Text("Retry"),
                                                    onPressed: () {
                                                      ctr.latLngList.clear();

                                                      Navigator.of(context)
                                                          .pop();
                                                      setState(() {});
                                                    },
                                                    icon: const Icon(
                                                        Icons.cancel_outlined)),
                                                OutlinedButton.icon(
                                                  icon: const Icon(Icons.save),
                                                  label: const Text("Save"),
                                                  onPressed: () {
                                                    ctr.saveMapInputToDB();
                                                    Navigator.of(context).pop();
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            ));
                                  },
                                  icon: const Icon(Icons.map_outlined),
                                  label: const Text('preview')),
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<void> _moveToCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition();

    _gcontroller?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 15,
        ),
      ),
    );
  }
}
