import 'package:get/get.dart';
import 'package:com.lged.lgcrrp.misulgi/controller/common_controller.dart';
import 'package:com.lged.lgcrrp.misulgi/controller/contact/contact_list_Controller.dart';
import 'package:com.lged.lgcrrp.misulgi/controller/contact/profile_form_controller.dart';
import 'package:com.lged.lgcrrp.misulgi/controller/contact/reg_log_vm.dart';
import 'package:com.lged.lgcrrp.misulgi/controller/scheme/scheme_list_ctr.dart';
import 'package:com.lged.lgcrrp.misulgi/controller/scheme/scheme_login_ctr.dart';
import 'package:com.lged.lgcrrp.misulgi/controller/scheme/scheme_progress_ctr.dart';

Future<void> init() async {

  //Common Controller
  Get.lazyPut(() => CommonController());

  // Controllers for Contact
  Get.lazyPut(() => ContactListController());
  Get.lazyPut(() => ProfileFormController());
  Get.lazyPut(() => RegLogController());
  Get.lazyPut(() => RegLogController());

  // Controllers for Scheme
  Get.lazyPut(() => SchemeListCtr());
  Get.lazyPut(() => SchemeLogInCtr());
  Get.lazyPut(() => SchemeProgressCtr());




  // final ctr = Get.find<SchemeListCtr>();
  // final ctr = Get.put(SubmitComplainCtr());

}
