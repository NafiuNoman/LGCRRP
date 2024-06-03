import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:com.lged.lgcrrp.misulgi/controller/common_controller.dart';
import '../data/local/database.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});

  final commonCtr = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: FutureBuilder(
                  future: _initApp(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Animate(
                          effects: const [
                            FadeEffect(
                                duration: Duration(seconds: 3),
                                begin: 0.0,
                                end: 1.0),
                            // SlideEffect(duration: 1.seconds,)
                          ],
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  "assets/image/govt.png",
                                  height: 70,
                                  width: 70,
                                ),
                                const Text(
                                    "Management Information System  (MIS)"),
                                const Text(
                                    "Urban Local Governments Institutes (ULGI)"),
                              ],
                            ),
                          ));
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      Future.delayed(Duration.zero, () {
                        Navigator.pushReplacementNamed(context, "/DashBoard");
                      });
                      return Animate(
                          effects: const [
                            FadeEffect(
                                duration: Duration(seconds: 3),
                                begin: 0.0,
                                end: 1.0),
                            // SlideEffect(duration: 1.seconds,)
                          ],
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  "assets/image/govt.png",
                                  height: 70,
                                  width: 70,
                                ),
                                const Text(
                                    "Management Information System  (MIS)"),
                                const Text(
                                    "Urban Local Governments Institutes (ULGI)"),
                              ],
                            ),
                          ));
                    } else {
                      return const Text("Db initialization error occurred");
                    }
                  }))),
    );
  }

  Future<void> _initApp() async {
    // EasyLoading.show(status: "Please wait...");
    await AppDatabase.getInstance();
    await commonCtr.callSetupApiAndInsertToDb();

    // EasyLoading.dismiss();
  }
}
