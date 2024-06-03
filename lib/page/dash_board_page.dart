import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:com.lged.lgcrrp.misulgi/controller/common_controller.dart';
import 'package:com.lged.lgcrrp.misulgi/util/style.dart';
import 'package:com.lged.lgcrrp.misulgi/widget/GrsBtn.dart';
import 'package:com.lged.lgcrrp.misulgi/widget/main_btn.dart';
import 'package:com.lged.lgcrrp.misulgi/widget/my_appbar.dart';

class DashBoardPage extends StatelessWidget {
  DashBoardPage({super.key});

  final commonCtr = Get.find<CommonController>();

  @override
  Widget build(BuildContext context) {
    // setUserCreds();
    return Scaffold(
      backgroundColor: MStyle.pageColor,
      appBar: const MyAppbar(),
      drawer: Drawer(
        backgroundColor: MStyle.pageColor,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                ),
                currentAccountPicture: Image.asset(
                  "assets/image/govt.png",
                  height: 70,
                  width: 70,
                ),
                accountName: const Text(
                  "MIS LGCRRP",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
                accountEmail: const Text(
                  "LGED",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w500),
                )),
            ListTile(
              leading: Icon(Icons.home_outlined),
              title: Text("Home"),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  "/DashBoard",
                  (route) => false,
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.schema_outlined),
              title: Text("Scheme"),
              onTap: () {
                navigateToSchemePage(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.sync),
              title: Text("Sync Setup Data"),
              onTap: () async {
                Navigator.pop(context);
                if (await commonCtr.callSetupApiAndInsertToDb()) {
                  Fluttertoast.showToast(
                      msg: 'Setup data synced successfully',
                      backgroundColor: Colors.green,toastLength: Toast.LENGTH_LONG);


                }
              },
            ),
            ListTile(
              leading: Icon(Icons.comment_bank_outlined),
              title: Text("GRS"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/complaintFormPage");
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.dashboard_outlined),
            //   title: const Text("Test"),
            //   onTap: () {
            //     Navigator.pushNamed(context, '/testFormPage');
            //   },
            // ),
            Obx(
              () => Visibility(
                visible: !commonCtr.hasSession.value,
                child: ListTile(
                  leading: const Icon(Icons.login),
                  title: const Text("Login"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/schemeLogIn");
                  },
                ),
              ),
            ),
            Obx(
              () => Visibility(
                visible: commonCtr.hasSession.value,
                child: ListTile(
                  leading: const Icon(Icons.logout_outlined),
                  title: const Text("Logout"),
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => AlertDialog(
                              title: const Text("Logout!"),
                              content: const Text(
                                  "Are you sure you want to Logout?"),
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      EasyLoading.show(
                                          status: "Please wait...");

                                      await commonCtr.clearSharedPref();
                                      commonCtr.userName.value = '';
                                      commonCtr.userLevel.value = '';
                                      commonCtr.hasSession.value = false;

                                      await commonCtr.clearDB();
                                      EasyLoading.dismiss();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Yes")),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("No")),
                              ],
                            ));
                  },
                ),
              ),
            ),
            Obx(() => ListTile(
                  subtitle: Text(
                    commonCtr.versionName.value,
                    style: TextStyle(color: Colors.grey),
                  ),
                  title: Text(commonCtr.serverName.value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 10)),
                ))
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            child: Column(
              children: [
                Text(
                  'Local Government COVID-19',
                  style: TextStyle(
                      color: Color(0xff141414), fontWeight: FontWeight.w700),
                ),
                Text('Response and Recovery Project (LGCRRP)',
                    style: TextStyle(
                        color: Color(0xff141414), fontWeight: FontWeight.w700)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('Local Government Engineering Department',
                      maxLines: 2,
                      style: TextStyle(
                          color: Color(0xff666666),
                          fontWeight: FontWeight.w400)),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MainBtn(
                title: "Schemes",
                subtitle: 'Check all the schemes by the city corporation',
                svgPath: 'assets/icon/scheme_svg.svg',
                onTap: () {
                  navigateToSchemePage(context);
                },
              ),
              MainBtn(
                title: 'Contacts',
                subtitle: 'Find all the officials associated with this project',
                svgPath: 'assets/icon/contacts_svg.svg',
                onTap: () {
                  if (commonCtr.hasSessionForContacts()) {
                    Navigator.pushNamed(context, "/ContactList",);
                  } else {
                    Navigator.pushNamed(context, "/login_reg");
                  }
                },
              ),
            ],
          ),
          Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xffCCCCCC), width: 1.5),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 20.0),
                    child: Column(
                      children: [
                        const Text(
                          'If you have any complain, we feel sorry for that.',
                          style: TextStyle(
                              color: Color(0xff666666),
                              fontWeight: FontWeight.w500,
                              fontSize: 11),
                        ),
                        const Text(
                          'But you are welcome.',
                          style: TextStyle(
                              color: Color(0xff666666),
                              fontWeight: FontWeight.w500,
                              fontSize: 11),
                        ),
                        const Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Obx(() {
                              if (!commonCtr.hasSession.value) {
                                return GrsBtn(
                                    onTap: () {
                                      buildDialogeForTracking(context);
                                    },
                                    // pageName:  "/grsTrackingPage",
                                    title: 'Check Status',
                                    subtitle:
                                        'Check status for submitted complaint');
                              } else {
                                return GrsBtn(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/complaintListPage');
                                    },
                                    // pageName:  "/grsTrackingPage",
                                    title: 'Complaints',
                                    subtitle: 'Check all complaints here');
                              }
                            }),
                            const GrsBtn(
                              title: 'Submit',
                              subtitle: 'Submit a new Complaint',
                              pageName: "/complaintFormPage",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                color: const Color(0xFFE8EBF6),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset('assets/icon/grs_svg.svg'),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text('Grievance Redress'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void navigateToSchemePage(BuildContext context) {
    if (commonCtr.hasSessionForScheme()) {
      Navigator.pushNamed(context, "/schemeListPage");
    } else {
      Navigator.pushNamed(context, "/schemeLogIn");
    }
  }

  void buildDialogeForTracking(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        insetPadding: const EdgeInsets.all(10),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Colors.blue.shade200,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    'Check Complaint Status',
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Form(
                  key: commonCtr.formKey,
                  child: TextFormField(
                    maxLines: 1,
                    controller: commonCtr.trackingNumberCtr,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      fillColor: Colors.white,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      errorBorder: MStyle.formErrorBorder,
                      label: const Text("Complaint(GRS) Tracking Number"),
                      hintText: 'Unique Tracking Number',
                      hintStyle: MStyle.hintStyle,
                      focusedBorder: MStyle.formFocusBorder,
                      enabledBorder: MStyle.formEnableBorder,
                      focusedErrorBorder: MStyle.formErrorBorder,
                    ),
                    validator: (value) {
                      if (value == null) {
                        return "You must provide a valid Tracking Number";
                      } else if (value == "") {
                        return "You must provide a valid Tracking Number";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              const Gap(16),
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: SizedBox(
                      height: 50,
                      child: ElevatedButton.icon(
                        icon: const Icon(
                          Icons.search_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                        label: const Text(
                          'Check',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        style: ButtonStyle(
                            backgroundColor: const MaterialStatePropertyAll(
                                Color(0xff407BFF)),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0)))),
                        onPressed: () async {
                          if (commonCtr.formKey.currentState!.validate()) {
                            String? statusMsg =
                                await commonCtr.callForTrackStatus();
                            Navigator.pop(context);

                            if (statusMsg != null) {
                              Get.snackbar(
                                "Complaint (GRS) Status",
                                '',
                                messageText: Html(
                                  data: statusMsg,
                                  style: {
                                    '#': Style(
                                      color: Colors.white,
                                    ),
                                  },
                                ),
                                duration: const Duration(minutes: 10),
                                colorText: Colors.white,
                                backgroundColor: Colors.green,
                                snackPosition: SnackPosition.TOP,
                                mainButton: TextButton(
                                  child: const Text(
                                    'Dismiss',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Get.closeAllSnackbars();
                                  },
                                ),
                              );
                            }
                          }
                        },
                      )),
                ),
              ),
              const Gap(16),
            ],
          ),
        ),
      ),
    );
  }

}
