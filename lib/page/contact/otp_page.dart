import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:com.lged.lgcrrp.misulgi/controller/contact/reg_log_vm.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/otp_model.dart';
import '../../controller/contact/profile_form_controller.dart';
import '../../widget/common_style.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  late OtpModel otpModel;
  TextEditingController otpCtr = TextEditingController();
  final regLogInController = Get.find<RegLogController>();

  String inputOTP = "";
  bool hasResendBtnEnabled= false;

  @override
  Widget build(BuildContext context) {
    otpModel = ModalRoute.of(context)!.settings.arguments as OtpModel;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.deepPurple.shade50),
                child: Image.asset("assets/image/login/illustration-3.png"),
              ),
              const Text(
                'Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Enter your OTP code number",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 28,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: otpCtr,
                  maxLength: 4,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.key_outlined),
                    labelText: "Your OTP",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),

                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () async {
                      EasyLoading.show();

                      if (otpCtr.text.isNotEmpty) {
                        if (otpModel.otp_code ==
                            int.parse(otpCtr.text.trim())) {
                          final ctr = Get.find<ProfileFormController>();
                          if (otpModel.contact_id == 0) {

                            ctr.currentUser = null;
                            ctr.loadDataAsUser();
                            ctr.mode='save';

                            Navigator.pushReplacementNamed(context, "/profileFormPage");
                          } else {
                            ctr.currentUser = otpModel.contact_details;
                            ctr.loadDataAsUser();
                            ctr.mode='update';
                            Navigator.pushReplacementNamed(context, "/ContactList",);
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: "otp not correct ",
                              gravity: ToastGravity.CENTER,
                              backgroundColor: Colors.deepOrange,
                              textColor: Colors.white);
                        }
                      }



                      else {
                        Fluttertoast.showToast(msg: "OTP is required");
                      }

                      EasyLoading.dismiss();
                    },
                    style: CommonStyle.elevatedBtnStyle,
                    child: const Text(
                      "Verify",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                "Didn't you receive any code?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    autofocus: false,
                    onPressed: hasResendBtnEnabled==true?resendOTP:null,
                    child:  Text(
                      "Resend New Code",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                       color:  hasResendBtnEnabled==true? Colors.purple:Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Countdown(seconds: 20, build: (ctx,time){

                    return Text(time.toString());

                  },onFinished: ()
                    {
                      setState(() {
                        hasResendBtnEnabled = true;
                      });
                    },)
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }

  void resendOTP() async {

    EasyLoading.show();

    String phoneNo = regLogInController.contactUserPhoneNumber;
    //validating phone no

    OtpModel? model = await regLogInController.makeApiCallForOtp(phoneNo);

    if (model != null) {
      if (model.contact_id != null) {
        otpModel = model;
        await regLogInController.setUserIdToSP(model);
      }

      setState(() {
        hasResendBtnEnabled = false;

      });

      Fluttertoast.showToast(msg: "${model.otp_code}");
    }

    EasyLoading.dismiss();
  }
}
