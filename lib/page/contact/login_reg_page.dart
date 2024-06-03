import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:com.lged.lgcrrp.misulgi/controller/contact/reg_log_vm.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/otp_model.dart';
import 'package:com.lged.lgcrrp.misulgi/widget/common_style.dart';

class LoginOrRegistrationPage extends StatelessWidget {
  LoginOrRegistrationPage({super.key});

  final TextEditingController phoneNoCtr = TextEditingController();
  final regLogInController = Get.find<RegLogController>();
  String? phoneErrorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff7f6fb),
        leading: IconButton(
          onPressed: () {
           Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      backgroundColor: const Color(0xfff7f6fb),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              headerSection(),
              const SizedBox(height: 50),
              phoneNoFiled(),
              const SizedBox(height: 10),
              //send btn
              sendBtn(context)
            ],
          ),
        ),
      )),
    );
  }

  SizedBox sendBtn(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () async {
          EasyLoading.show();

          //validated phone no & call for OTP
          await userValidateAndGetOTP(context);

          EasyLoading.dismiss();
        },
        style: CommonStyle.elevatedBtnStyle,
        child: const Text(
          "Send",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  SizedBox phoneNoFiled() {
    return SizedBox(
      width: double.infinity,
      child: Obx(
        () =>

            TextFormField(
          controller: phoneNoCtr,
          style: const TextStyle(fontSize: 22),
          keyboardType: TextInputType.phone,
          maxLines: 1,
          maxLength: 11,
          decoration: InputDecoration(
            errorText: regLogInController.errorText.value.toString() == ""
                ? null
                : regLogInController.errorText.value.toString(),
            prefixIcon: const Icon(Icons.phone_outlined),
            labelText: "Phone Number",
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.redAccent)),
          ),
        ),
      ),
    );
  }

  Column headerSection() {
    return Column(
      children: [
        //image
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
              color: Colors.deepPurple.shade50, shape: BoxShape.circle),
          child: Image.asset("assets/image/login/illustration-2.png"),
        ),
        const Text(
          'Registration/Login',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "Add your phone number. we'll send you a verification code so we know you're real",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black38,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Future<void> userValidateAndGetOTP(BuildContext context) async {
    String phoneNo = phoneNoCtr.text.toString();
    //validating phone no
    if (regLogInController.isValidatePhoneNo(phoneNo)) {
      regLogInController.contactUserPhoneNumber = phoneNo;
      OtpModel? model = await regLogInController.makeApiCallForOtp(phoneNo);

      if (model != null) {
        if (model.contact_id!=0) {
          await regLogInController.setUserIdToSP(model);
          await regLogInController.insertUserContactDetails(model.contact_details!);
        }
        Navigator.pushReplacementNamed(context, "/otp_page", arguments: model);
      }
    }
  }
}
