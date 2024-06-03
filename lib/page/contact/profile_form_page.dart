import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:com.lged.lgcrrp.misulgi/controller/contact/profile_form_controller.dart';
import 'package:com.lged.lgcrrp.misulgi/util/style.dart';
import '../../util/common_method.dart';

class ProfileFormPage extends StatelessWidget {
  ProfileFormPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: GetBuilder<ProfileFormController>(
            init: ProfileFormController(),
            builder: (ctr) {
              if (ctr.isLoading) {
                return const CircularProgressIndicator();
              } else {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          InkWell(
                            child: Obx(() => CircleAvatar(
                                  radius: 90,
                                  backgroundImage: ctr.imageFile.value != null
                                      ? FileImage(ctr.imageFile.value!)
                                      : null,
                                  child: ctr.imageFile.value == null
                                      ? const Icon(
                                          Icons.person,
                                          size: 90,
                                        )
                                      : null,
                                )),
                            onTap: () {
                              ctr.pickImage();
                            },
                          ),
                          const Gap(18),
                          //name en
                          TextFormField(
                            // initialValue: "default name",
                            controller: ctr.nameEnCtr,
                            maxLines: 1,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              errorBorder: MStyle.formErrorBorder,
                              label: myLabel("Full Name (English)"),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.yellow)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 2, color: Color(0xff6C727F)),
                              ),
                              focusedErrorBorder: MStyle.formErrorBorder,
                            ),
                            validator: (value) {
                              if (value == null) {
                                return "Name is required";
                              } else if (value == "") {
                                return "Name is required";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const Gap(18),
                          //name bn
                          TextFormField(
                            controller: ctr.nameBnCtr,
                            maxLines: 1,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              errorBorder: MStyle.formErrorBorder,
                              label: myLabel("Full Name (Bang)"),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.yellow)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 2, color: Color(0xff6C727F)),
                              ),
                              focusedErrorBorder: MStyle.formErrorBorder,
                            ),
                            validator: (value) {
                              if (value == null) {
                                return "Name is required";
                              } else if (value == "") {
                                return "Name is required";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const Gap(18),
                          //email
                          SizedBox(
                            height: 80,
                            width: double.infinity,
                            child: TextFormField(
                              controller: ctr.emailCtr,
                              maxLines: 1,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                suffixIcon: const Icon(Icons.email_outlined),
                                label: myLabel("E-mail"),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 2, color: Colors.yellow)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 2, color: Color(0xff6C727F))),
                                errorBorder: MStyle.formErrorBorder,
                                focusedErrorBorder: MStyle.formErrorBorder,
                              ),
                              validator: (value) {
                                String pattern =
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                                RegExp regExp = RegExp(pattern);
                                if (value == null) {
                                  return 'Please enter an email';
                                }
                                if (value.isEmpty) {
                                  return 'Please enter an email';
                                } else if (!regExp.hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                          ),
                          const Gap(18),
                          //mobile number
                          SizedBox(
                            height: 80,
                            width: double.infinity,
                            child: TextFormField(
                              readOnly: true,
                              controller: ctr.phoneCtr,
                              // initialValue: regLogInController.contactUserPhoneNumber,
                              maxLines: 1,
                              maxLength: 11,
                              keyboardType: TextInputType.none,
                              decoration: InputDecoration(
                                label: myLabel("Mobile Number"),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 2, color: Color(0xff6C727F))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 2, color: Color(0xff6C727F))),
                              ),
                            ),
                          ),
                          const Gap(18),
                          //whatsapp number
                          SizedBox(
                            height: 80,
                            width: double.infinity,
                            child: TextFormField(
                              controller: ctr.whatAppCtr,
                              maxLines: 1,
                              maxLength: 11,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                label: const Text("Whatsapp Number"),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 2, color: Colors.yellow)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 2, color: Color(0xff6C727F))),
                              ),
                            ),
                          ),
                          const Gap(18),
                          //division
                          SizedBox(
                            height: 80,
                            width: double.infinity,
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              value:
                                  ctr.divisionId == 0 ? null : ctr.divisionId,
                              decoration: dropdownDec('Division'),
                              items: ctr.divisionItems,
                              onChanged: (id) {
                                if (id != null) {
                                  ctr.setDistrictByDivisionId(id);
                                }
                              },
                              validator: (value) {
                                if (value == 0) {
                                  return "Division is required";
                                } else if (value == null) {
                                  return "Division is required";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          const Gap(18),
                          //district
                          SizedBox(
                            height: 80,
                            width: double.infinity,
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              value:
                                  ctr.districtId == 0 ? null : ctr.districtId,
                              decoration: dropdownDec("District"),
                              items: ctr.districtItems,
                              onChanged: (selectedId) {
                                if (selectedId != null) {
                                  ctr.setCityCorporationByDistrictId(
                                      selectedId);
                                }
                              },
                              validator: (value) {
                                if (value == 0) {
                                  return "District is required";
                                } else if (value == null) {
                                  return "District is required";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          const Gap(18),
                          //city corporation
                          SizedBox(
                            height: 80,
                            width: double.infinity,
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              value:
                                  ctr.cityCropId == 0 ? null : ctr.cityCropId,
                              decoration: dropdownDec(
                                  "ULGI (City Corporation, Pourashava)"),
                              items: ctr.cityCropsItems,
                              onChanged: (selectedId) {
                                if (selectedId != null) {
                                  ctr.setCityCorporationId(selectedId);
                                }
                              },
                              validator: (value) {
                                if (value == 0) {
                                  return "City Corporation is required";
                                } else if (value == null) {
                                  return "City Corporation is required";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          const Gap(18),
                          //designation
                          SizedBox(
                            height: 80,
                            width: double.infinity,
                            child: DropdownButtonFormField(
                              value: ctr.designationId == 0
                                  ? null
                                  : ctr.designationId,
                              isExpanded: true,
                              decoration: InputDecoration(
                                label: myLabel("Designation"),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xff6C727F), width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xff6C727F), width: 2),
                                ),
                                errorBorder: MStyle.formErrorBorder,
                                focusedErrorBorder: MStyle.formErrorBorder,
                              ),
                              items: ctr.designationItems,
                              onChanged: (selectedId) {
                                ctr.designationId = selectedId ?? 0;
                              },
                              validator: (value) {
                                if (value == 0) {
                                  return "Designation is required";
                                } else if (value == null) {
                                  return "Designation is required";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          const Gap(18),
                          //birthday
                          SizedBox(
                            height: 80,
                            width: double.infinity,
                            child: TextFormField(
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now());

                                if (pickedDate != null) {
                                  ctr.birthdayController.text =
                                      DateFormat('dd MMM yyyy')
                                          .format(pickedDate);
                                }
                              },
                              controller: ctr.birthdayController,
                              maxLines: 1,
                              keyboardType: TextInputType.none,
                              validator: (value) {
                                if (value == null) {
                                  return 'date is required';
                                } else if (value == '') {
                                  return 'Date can not empty';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                suffixIcon:
                                    const Icon(Icons.calendar_today_outlined),
                                label: myLabel("Birthday"),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 2, color: Colors.yellow)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 2, color: Color(0xff6C727F))),
                              ),
                            ),
                          ),
                          const Gap(18),
                          //nid number
                          SizedBox(
                            height: 80,
                            width: double.infinity,
                            child: TextFormField(
                              controller: ctr.nidCtr,
                              maxLines: 1,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                label: const Text("NID Number"),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 2, color: Colors.yellow)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 2, color: Color(0xff6C727F))),
                              ),
                            ),
                          ),
                          const Gap(18),
                          //blood group
                          SizedBox(
                            height: 80,
                            width: double.infinity,
                            child: DropdownButtonFormField(
                                value: ctr.bloodId == "" ? null : ctr.bloodId,
                                decoration: InputDecoration(
                                  label: const Text("Blood Group"),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xff6C727F), width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xff6C727F), width: 2),
                                  ),
                                ),
                                items: ctr.bloodItems,
                                onChanged: (selectedValue) {
                                  ctr.bloodId = selectedValue ?? "";
                                }),
                          ),
                          const Gap(18),
                          //Gender
                          SizedBox(
                            height: 80,
                            width: double.infinity,
                            child: DropdownButtonFormField(
                                value: ctr.genderId == "" ? null : ctr.genderId,
                                validator: (value) {
                                  if (value == 0) {
                                    return "Gender is required";
                                  } else if (value == null) {
                                    return "Gender is required";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  label: myLabel("Gender"),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xff6C727F), width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Color(0xff6C727F), width: 2),
                                  ),
                                ),
                                items: ctr.genderItems,
                                onChanged: (selectedValue) {
                                  ctr.genderId = selectedValue ?? "";
                                }),
                          ),
                          const Gap(18),
                          //permanent address
                          SizedBox(
                            height: 80,
                            width: double.infinity,
                            child: TextFormField(
                              controller: ctr.permanentAddressCtr,
                              maxLines: 2,
                              keyboardType: TextInputType.streetAddress,
                              decoration: InputDecoration(
                                label: const Text("Permanent Address"),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 2, color: Colors.yellow)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 2, color: Color(0xff6C727F))),
                              ),
                            ),
                          ),
                          const Gap(18),
                          SizedBox(
                            height: 80,
                            width: double.infinity,
                            child: TextFormField(
                              controller: ctr.presentAddressCtr,
                              maxLines: 2,
                              keyboardType: TextInputType.streetAddress,
                              decoration: InputDecoration(
                                label: const Text("Present Address"),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 2, color: Colors.yellow)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 2, color: Color(0xff6C727F))),
                              ),
                            ),
                          ),
                          const Gap(18),
                          SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          const MaterialStatePropertyAll(
                                              Color(0xff0C356A)),
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0)))),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      if (ctr.mode == "update") {
                                        await ctr.updateContactProfileData();
                                        ctr.refreshData();

                                        Navigator.pushReplacementNamed(
                                            context, "/ContactList");
                                      } else {
                                       await ctr.postNewUserContact();
                                        ctr.refreshData();

                                        Navigator.pushReplacementNamed(
                                            context, "/ContactList");
                                      }
                                    }
                                  },
                                  child: const Text(
                                    "Save",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22),
                                  ))),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }

  InputDecoration dropdownDec(String label) {
    return InputDecoration(
      label: myLabel(label),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xff6C727F), width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xff6C727F), width: 2),
      ),
      errorBorder: MStyle.formErrorBorder,
      focusedErrorBorder: MStyle.formErrorBorder,
    );
  }
}
