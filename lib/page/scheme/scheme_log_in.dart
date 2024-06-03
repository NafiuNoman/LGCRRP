import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:com.lged.lgcrrp.misulgi/controller/scheme/scheme_login_ctr.dart';
import '../../util/style.dart';
import '../../widget/common_style.dart';

class SchemeLogIn extends StatelessWidget {
  SchemeLogIn({super.key});

  final ctr = Get.find<SchemeLogInCtr>();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: const Text(
          'LogIn',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
            )),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipPath(
                      clipper: WaveClipper(),
                      child: Container(
                        color: Colors.blue.shade200,
                        height: 120,
                      ),
                    ),
                    const Text(
                      "LOG IN",
                      style: TextStyle(fontSize: 22),
                    ),
                    const Gap(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        controller: ctr.userNameCtr,
                        style: const TextStyle(fontSize: 22),
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        decoration: InputDecoration(
                            // errorText: regLogInController.errorText.value.toString() == ""
                            //     ? null
                            //     : regLogInController.errorText.value.toString(),
                            prefixIcon: const Icon(Icons.person_2_outlined),
                            labelText: "Username",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: 'Your username here',
                            hintStyle: MStyle.hintStyle,
                            focusedBorder: MStyle.formFocusBorder,
                            enabledBorder: MStyle.formEnableBorder,
                            errorBorder: MStyle.formErrorBorder),
                        validator: (value) {
                          if (value == null || value == "") {
                            return "User name is required";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const Gap(20),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          obscureText: ctr.isObscure.value,
                          controller: ctr.passCtr,
                          style: const TextStyle(fontSize: 22),
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: InputDecoration(
                              // errorText: regLogInController.errorText.value.toString() == ""
                              //     ? null
                              //     : regLogInController.errorText.value.toString(),
                              prefixIcon: const Icon(Icons.phone_outlined),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    ctr.isObscure.value = !ctr.isObscure.value;
                                  },
                                  icon: ctr.isObscure.value
                                      ? const Icon(
                                          Icons.visibility_off,
                                        )
                                      : const Icon(Icons.visibility,
                                          color: Colors.blue)),
                              labelText: "Password",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: 'Your password here',
                              hintStyle: MStyle.hintStyle,
                              focusedBorder: MStyle.formFocusBorder,
                              enabledBorder: MStyle.formEnableBorder,
                              errorBorder: MStyle.formErrorBorder),
                          validator: (value) {
                            if (value == null) {
                              return "password is required";
                            }
                            if (value.length < 5) {
                              return "minimum 5 character needed";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                    const Gap(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 15,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await ctr.processLogin(context);
                            }
                          },
                          style: CommonStyle.elevatedBtnStyle,
                          child: const Text(
                            "LOGIN",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Positioned(
                  bottom: 20,
                  child: Image.asset(
                    'assets/image/login/login_bac.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                const Gap(20),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {

    double w = size.width;
    double h = size.height;

    var path = Path();

//(0,0)//1st point
    path.lineTo(0, h-20); // 2nd point
    path.quadraticBezierTo(w/4, h-5, w/1.5, h-50);
    path.quadraticBezierTo(w/0.5, h, w, h-20);
    path.lineTo(w, 0); // 5th point
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
