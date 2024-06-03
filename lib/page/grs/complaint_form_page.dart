import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:com.lged.lgcrrp.misulgi/controller/grs/submit_complain_ctr.dart';
import '../../util/common_method.dart';
import '../../util/style.dart';

class ComplaintFormPage extends StatelessWidget {
   ComplaintFormPage({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MStyle.pageColor,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: Text(
          'Submit Complaint (GRS)',
          style: MStyle.appBarTitleStyle,
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
      body: SafeArea(
        child: GetBuilder<SubmitComplainCtr>(
            init: SubmitComplainCtr(),
            builder: (ctr) {
              if (ctr.isLoading == true) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    const Gap(10),

                                    DropdownButtonFormField(
                                      value:
                                          ctr.divisionId == 0 ? null : ctr.divisionId,
                                      isExpanded: true,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 12),
                                        label: myLabel("Division"),
                                        hintText: 'Select division',
                                        hintStyle: MStyle.hintStyle,
                                        floatingLabelBehavior: FloatingLabelBehavior.always,

                                        enabledBorder: MStyle.formEnableBorder,
                                        focusedBorder: MStyle.formFocusBorder,
                                        errorBorder: MStyle.formErrorBorder,
                                        focusedErrorBorder: MStyle.formErrorBorder,
                                      ),
                                      items: ctr.divisionItems,
                                      onChanged:ctr.divisionDrpLock?null: <int>(id) {
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
                                    const Gap(16),
                                    DropdownButtonFormField(
                                      value:
                                          ctr.districtId == 0 ? null : ctr.districtId,
                                      isExpanded: true,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 12),
                                        label: myLabel("District"),
                                        hintText: 'Select district',
                                        hintStyle: MStyle.hintStyle,
                                        floatingLabelBehavior: FloatingLabelBehavior.always,

                                        enabledBorder: MStyle.formEnableBorder,
                                        focusedBorder: MStyle.formFocusBorder,
                                        errorBorder: MStyle.formErrorBorder,
                                        focusedErrorBorder: MStyle.formErrorBorder,
                                      ),
                                      items: ctr.districtItems,
                                      onChanged:ctr.districtDrpLock?null:<int>(id) {
                                        if (id != null) {
                                          ctr.setCityCropsByDistrictId(id);
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
                                    const Gap(16),
                                    DropdownButtonFormField(
                                      value:
                                          ctr.cityCropId == 0 ? null : ctr.cityCropId,
                                      isExpanded: true,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 12),
                                        label: myLabel("Paurashava/City Corporation"),
                                        hintText: 'Select Paurashava/City Corporation',
                                        hintStyle: MStyle.hintStyle,
                                        floatingLabelBehavior: FloatingLabelBehavior.always,

                                        enabledBorder: MStyle.formEnableBorder,
                                        focusedBorder: MStyle.formFocusBorder,
                                        errorBorder: MStyle.formErrorBorder,
                                        focusedErrorBorder: MStyle.formErrorBorder,
                                      ),
                                      items: ctr.cityCropsItems,
                                      onChanged:ctr.cityCropDrpLock?null:<int>(id) {
                                        if (id != null) {
                                          ctr.setCityCropsId(id);
                                        }
                                      },
                                      validator: (value) {
                                        if (value == 0) {
                                          return "Paurashava/City Corporation is required";
                                        } else if (value == null) {
                                          return "Paurashava/City Corporation is required";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const Gap(16),
                                    TextFormField(
                                      maxLines: 1,
                                      controller: ctr.siteOfficeName,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 12),
                                        fillColor: Colors.white,
                                        errorBorder: MStyle.formErrorBorder,
                                        label: myLabel("Scheme/Site Office name"),
                                        hintText: 'Scheme or Site office name',
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        hintStyle: MStyle.hintStyle,

                                        focusedBorder: MStyle.formFocusBorder,
                                        enabledBorder: MStyle.formEnableBorder,
                                        focusedErrorBorder: MStyle.formErrorBorder,
                                      ),
                                      validator: (value) {
                                        if (value == null) {
                                          return "This field is required";
                                        } else if (value == "") {
                                          return "This field is required";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const Gap(20),
                                    Row(
                                      children: [
                                        const Text('Complaint Information'),
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Container(
                                            color: Colors.grey,
                                            height: 1.5,
                                          ),
                                        ))
                                      ],
                                    ),
                                    const Gap(16),
                                    DropdownButtonFormField(
                                      value: ctr.complaintTypeId==0?null:ctr.complaintTypeId,
                                      isExpanded: true,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 12),
                                        label: myLabel("Type"),
                                        hintText: 'Select type',
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        hintStyle: MStyle.hintStyle,
                                        enabledBorder: MStyle.formEnableBorder,
                                        focusedBorder: MStyle.formFocusBorder,
                                        errorBorder: MStyle.formErrorBorder,
                                        focusedErrorBorder: MStyle.formErrorBorder,
                                      ),
                                      items: ctr.complaintTypeItems,
                                      onChanged: (id) {

                                        if(id!=null)
                                          {
                                            ctr.complaintTypeId=id;
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
                                    const Gap(16),

                                    TextFormField(
                                      maxLines: 1,
                                      controller: ctr.complaintTitle,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 12),
                                        fillColor: Colors.white,
                                        errorBorder: MStyle.formErrorBorder,
                                        label: myLabel("Title"),
                                        hintStyle: MStyle.hintStyle,
                                        hintText: 'Title here',
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        focusedBorder: MStyle.formFocusBorder,
                                        enabledBorder: MStyle.formEnableBorder,
                                        focusedErrorBorder: MStyle.formErrorBorder,
                                      ),
                                      validator: (value) {
                                        if (value == null) {
                                          return "This field is required";
                                        } else if (value == "") {
                                          return "This field is required";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const Gap(16),
                                    TextFormField(
                                      minLines: 5,
                                      maxLines: 10,
                                      controller: ctr.complaintExplanation,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 12),
                                        fillColor: Colors.white,
                                        errorBorder: MStyle.formErrorBorder,
                                        label: myLabel("Explanation"),
                                        hintText: 'Write your explanation here',
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        hintStyle: MStyle.hintStyle,
                                        focusedBorder: MStyle.formFocusBorder,
                                        enabledBorder: MStyle.formEnableBorder,
                                        focusedErrorBorder: MStyle.formErrorBorder,
                                      ),
                                      validator: (value) {
                                        if (value == null) {
                                          return "This field is required";
                                        } else if (value == "") {
                                          return "This field is required";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const Gap(20),
                                    Row(
                                      children: [
                                        const Text('Complainer Information'),
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Container(
                                            color: Colors.grey,
                                            height: 1.5,
                                          ),
                                        ))
                                      ],
                                    ),

                                    ////////
                                    const Gap(16),

                                    TextFormField(
                                      controller: ctr.name,
                                      maxLines: 1,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 12),
                                        fillColor: Colors.white,
                                        errorBorder: MStyle.formErrorBorder,
                                        label: const Text("Name"),
                                        hintStyle: MStyle.hintStyle,
                                        hintText: 'Your name',
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        focusedBorder: MStyle.formFocusBorder,
                                        enabledBorder: MStyle.formEnableBorder,
                                        focusedErrorBorder: MStyle.formErrorBorder,
                                      ),
                                    ),
                                    const Gap(16),
                                    TextFormField(
                                      controller: ctr.email,
                                      maxLines: 1,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 12),
                                        fillColor: Colors.white,
                                        errorBorder: MStyle.formErrorBorder,
                                        label: const Text("Email"),
                                        hintText: 'Your email',
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        hintStyle: MStyle.hintStyle,
                                        focusedBorder: MStyle.formFocusBorder,
                                        enabledBorder: MStyle.formEnableBorder,
                                        focusedErrorBorder: MStyle.formErrorBorder,
                                      ),
                                    ),
                                    const Gap(16),
                                    TextFormField(
                                      controller: ctr.phone,

                                      maxLines: 1,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 12),
                                        fillColor: Colors.white,
                                        errorBorder: MStyle.formErrorBorder,
                                        label: const Text("Phone"),
                                        hintText: 'Your phone number',
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        hintStyle: MStyle.hintStyle,
                                        focusedBorder: MStyle.formFocusBorder,
                                        enabledBorder: MStyle.formEnableBorder,
                                        focusedErrorBorder: MStyle.formErrorBorder,
                                      ),
                                    ),
                                    const Gap(16),
                                    TextFormField(
                                        controller: ctr.address,

                                        minLines: 3,
                                        maxLines: 5,
                                        keyboardType: TextInputType.streetAddress,
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 12),
                                          fillColor: Colors.white,
                                          errorBorder: MStyle.formErrorBorder,
                                          label: const Text('Address '),
                                          hintText: 'Your address',
                                          floatingLabelBehavior: FloatingLabelBehavior.always,
                                          hintStyle: MStyle.hintStyle,
                                          focusedBorder: MStyle.formFocusBorder,
                                          enabledBorder: MStyle.formEnableBorder,
                                          focusedErrorBorder: MStyle.formErrorBorder,
                                        )),
                                    const Gap(16),
                                    Align(
                                      alignment: AlignmentDirectional.topEnd,
                                      child: SizedBox(
                                          height: 50,
                                          child: ElevatedButton.icon(
                                            icon: const Icon(
                                              Icons.upload_file_outlined,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                            label: const Text(
                                              'Submit Complaint',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    const MaterialStatePropertyAll(
                                                        Color(0xff407BFF)),
                                                shape: MaterialStatePropertyAll(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                4.0)))),
                                            onPressed: () async {

                                              if(formKey.currentState!.validate())
                                                {
                                                  if( await ctr.submitComplaint()==1)
                                                    {
                                                      Navigator.pop(context);
                                                    }




                                                }


                                            },
                                          )),
                                    ),
                                    const Gap(10),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
              }
            }),
      ),
    );
  }
}
