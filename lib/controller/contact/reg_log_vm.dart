import 'package:com.lged.lgcrrp.misulgi/data/remote/model/contact_super_model.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/response_model/new_user_res_model.dart';
import 'package:com.lged.lgcrrp.misulgi/util/constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/api_service.dart';
import '../../data/local/database.dart';
import '../../data/remote/model/otp_model.dart';
import '../../data/remote/model/request_model/new_user_model.dart';
import '../common_controller.dart';

class RegLogController extends GetxController {
  late AppDatabase _database;
  String contactUserPhoneNumber = "";
  final cmnCtr = Get.find<CommonController>();

  late SharedPreferences prefs;

  @override
  void onInit() {
    super.onInit();
    _initializeDatabase();
  }

  RxString errorText = "".obs;

  //api call for OTP
  Future<OtpModel?> makeApiCallForOtp(String phoneNo) async {

    if (!await cmnCtr.checkInternet()) {
      return null;
    }
       try {
      OtpModel? model = await ApiService.getUserOtpDetails(phoneNo);
      if (model != null) {
        await prefs.setInt(contactId, model.contact_id);

      }
      return model;
    } catch (ex) {
      print("Exception caugth $ex");
      return null;
    }
  }

  // validating phone no
  bool isValidatePhoneNo(String phoneNo) {
    RegExp regExp = RegExp(r'^01[3-9]\d{8}$');
    if (regExp.hasMatch(phoneNo)) {
      errorText.value = "";
      return true;
    } else {
      errorText.value = 'Invalid phone number format';
      return false;
    }
  }

  Future<void> setUserIdToSP(OtpModel model) async {
    await prefs.setInt("id", model.contact_id);
  }

  Future<void> insertUserContactDetails(ContactModel e) async {
    try {
      await _database.contactDao.insertContact(e);
    } catch (e) {
      print("exception:${e.toString()}");
    }
  }

  void _initializeDatabase() async {
    // Obtain shared preferences.
    prefs = await SharedPreferences.getInstance();
    _database = await AppDatabase.getInstance();
  }


}
