import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:com.lged.lgcrrp.misulgi/page/scheme/scheme_details_page.dart';
import 'package:com.lged.lgcrrp.misulgi/util/style.dart';
import '../../controller/scheme/scheme_progress_ctr.dart';
import '../../util/common_method.dart';
import '../../util/constant.dart';

class ProgressFormPage extends StatelessWidget {
  const ProgressFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    int edit = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      backgroundColor: MStyle.pageColor,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (ctx) => SchemeDetailsPage(initialTabIndex: 2)));
          },
          icon: const Icon(
            Icons.cancel_outlined,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Scheme Progress',
          style: MStyle.appBarTitleStyle,
        ),
      ),
      body: SafeArea(
        child: GetBuilder<SchemeProgressCtr>(
            init: SchemeProgressCtr(),
            builder: (ctr) => ctr.isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Form(
                      key: ctr.formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 14),
                        child: Column(
                          children: [
                            buildSchemeCard(ctr),
                            const Gap(15),
                            Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14.0, vertical: 8),
                                child: Column(
                                  children: [
                                    const Align(
                                        alignment:
                                            AlignmentDirectional.topStart,
                                        child: Text(
                                          'Add Progress',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15),
                                        )),
                                    const Gap(16),
                                    TextFormField(
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1990),
                                                lastDate: DateTime.now());

                                        if (pickedDate != null) {
                                          String readableFormat =
                                              makeDateForFormView(pickedDate);
                                          ctr.reportingDateCtr.text =
                                              readableFormat;
                                        }
                                      },
                                      controller: ctr.reportingDateCtr,
                                      maxLines: 1,
                                      readOnly: true,
                                      //no keyboard open //no cursor shown
                                      decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 12),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          suffixIcon: const Icon(
                                              Icons.calendar_today_outlined),
                                          label: myLabel("Reporting Date"),
                                          hintText: 'DD-MMM-YYYY',
                                          hintStyle: MStyle.hintStyle,
                                          focusedBorder: MStyle.formFocusBorder,
                                          enabledBorder:
                                              MStyle.formEnableBorder,
                                          errorBorder: MStyle.formErrorBorder),
                                      validator: (value) {
                                        if (value == null) {
                                          return 'date is required';
                                        } else if (value == '') {
                                          return 'Date can not empty';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const Gap(16),
                                    DropdownButtonFormField(
                                      isExpanded: true,
                                      value: ctr.schemeStatusId == 0
                                          ? null
                                          : ctr.schemeStatusId,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 12),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        hintText: 'Choose a Status',
                                        hintStyle: MStyle.hintStyle,
                                        label: myLabel("Scheme Status"),
                                        enabledBorder: MStyle.formEnableBorder,
                                        focusedBorder: MStyle.formFocusBorder,
                                        errorBorder: MStyle.formErrorBorder,
                                        focusedErrorBorder:
                                            MStyle.formErrorBorder,
                                      ),
                                      items: ctr.schemeStatusList.isNotEmpty
                                          ? ctr.schemeStatusList
                                              .map((e) => DropdownMenuItem(
                                                    value: e.id,
                                                    child:
                                                        Text(e.name_en ?? ""),
                                                  ))
                                              .toList()
                                          : null,
                                      onChanged: (value) {
                                        if (value != null) {
                                          ctr.schemeStatusId = value;
                                        }
                                      },
                                      validator: (id) {
                                        if (id == null) {
                                          return "Scheme status is required";
                                        } else if (id == 0) {
                                          return "Scheme status is required";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const Gap(16),
                                    TextFormField(
                                      maxLines: 1,
                                      controller: ctr.amountSpentCtr,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 12),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        fillColor: Colors.white,
                                        errorBorder: MStyle.formErrorBorder,
                                        label: myLabel("Amount Spent"),
                                        hintText: 'Digits only',
                                        prefixIcon: SvgPicture.asset(
                                          'assets/icon/taka_svg.svg',
                                        ),
                                        prefixIconConstraints:
                                            const BoxConstraints(
                                                minHeight: 22, minWidth: 24),
                                        hintStyle: MStyle.hintStyle,
                                        focusedBorder: MStyle.formFocusBorder,
                                        enabledBorder: MStyle.formEnableBorder,
                                        focusedErrorBorder:
                                            MStyle.formErrorBorder,
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
                                    Row(
                                      children: [
                                        const Text('Progress '),
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
                                    TextFormField(
                                      controller: ctr.financialProgressCtr,
                                      maxLines: 1,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 12),
                                        errorBorder: MStyle.formErrorBorder,
                                        label: myLabel("Financial"),
                                        hintText: 'In Percentage',
                                        suffixIcon: const Icon(
                                          Icons.percent_outlined,
                                          size: 16,
                                          color: Color(0xffC2C1C1),
                                        ),
                                        hintStyle: MStyle.hintStyle,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        focusedBorder: MStyle.formFocusBorder,
                                        enabledBorder: MStyle.formEnableBorder,
                                        focusedErrorBorder:
                                            MStyle.formErrorBorder,
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "This field is required";
                                        }

                                        final double? parsedValue =
                                            double.tryParse(value);
                                        if (parsedValue == null) {
                                          return 'Please enter a valid number';
                                        }

                                        if (parsedValue > 100.0) {
                                          return 'Value cannot be greater than 100';
                                        }

                                        // Check for valid format (up to two decimal places)
                                        final RegExp regExp =
                                            RegExp(r'^\d{1,3}(\.\d{1,2})?$');
                                        if (!regExp.hasMatch(value)) {
                                          return 'Please enter a valid number (up to two decimal places)';
                                        }

                                        return null;
                                      },
                                    ),
                                    const Gap(16),
                                    TextFormField(
                                      // controller: nameEnCtr,
                                      maxLines: 1,
                                      controller: ctr.physicalProgressCtr,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 12),
                                        hintText: 'In Percentage',
                                        hintStyle: MStyle.hintStyle,
                                        errorBorder: MStyle.formErrorBorder,
                                        label: myLabel("Physical"),
                                        suffixIcon: const Icon(
                                          Icons.percent_outlined,
                                          size: 16,
                                          color: Color(0xffC2C1C1),
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        focusedBorder: MStyle.formFocusBorder,
                                        enabledBorder: MStyle.formEnableBorder,
                                        focusedErrorBorder:
                                            MStyle.formErrorBorder,
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "This field is required";
                                        }

                                        final double? parsedValue =
                                            double.tryParse(value);
                                        if (parsedValue == null) {
                                          return 'Please enter a valid number';
                                        }

                                        if (parsedValue > 100.0) {
                                          return 'Value cannot be greater than 100';
                                        }

                                        // Check for valid format (up to two decimal places)
                                        final RegExp regExp =
                                            RegExp(r'^\d{1,3}(\.\d{1,2})?$');
                                        if (!regExp.hasMatch(value)) {
                                          return 'Please enter a valid number (up to two decimal places)';
                                        }

                                        return null;
                                      },
                                    ),
                                    const Gap(16),
                                    Row(
                                      children: [
                                        const Text('No of Labor'),
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
                                    TextFormField(
                                      controller: ctr.noOfLaborMaleCtr,
                                      maxLines: 1,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 12),
                                        errorBorder: MStyle.formErrorBorder,
                                        label: myLabel("Male"),
                                        hintText: 'Number of Male',
                                        hintStyle: MStyle.hintStyle,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        suffixIcon: const Icon(
                                          Icons.man,
                                          size: 16,
                                          color: Color(0xffC2C1C1),
                                        ),
                                        focusedBorder: MStyle.formFocusBorder,
                                        enabledBorder: MStyle.formEnableBorder,
                                        focusedErrorBorder:
                                            MStyle.formErrorBorder,
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
                                      controller: ctr.noOfLaborFemaleCtr,
                                      maxLines: 1,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 12),
                                        errorBorder: MStyle.formErrorBorder,
                                        label: myLabel("Female"),
                                        hintText: 'Number of Female',
                                        hintStyle: MStyle.hintStyle,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        focusedBorder: MStyle.formFocusBorder,
                                        suffixIcon: const Icon(
                                          Icons.woman,
                                          size: 16,
                                          color: Color(0xffC2C1C1),
                                        ),
                                        enabledBorder: MStyle.formEnableBorder,
                                        focusedErrorBorder:
                                            MStyle.formErrorBorder,
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
                                    Row(
                                      children: [
                                        const Text('No of Days Labor'),
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
                                    TextFormField(
                                      controller: ctr.noOfDaysLaborMaleCtr,
                                      maxLines: 1,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 12),
                                        errorBorder: MStyle.formErrorBorder,
                                        label: myLabel("Male"),
                                        hintText: 'Number of Male',
                                        hintStyle: MStyle.hintStyle,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        suffixIcon: const Icon(
                                          Icons.man,
                                          size: 16,
                                          color: Color(0xffC2C1C1),
                                        ),
                                        focusedBorder: MStyle.formFocusBorder,
                                        enabledBorder: MStyle.formEnableBorder,
                                        focusedErrorBorder:
                                            MStyle.formErrorBorder,
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
                                      controller: ctr.noOfDaysLaborFemaleCtr,
                                      maxLines: 1,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 12),
                                        hintText: 'Number of Female',
                                        hintStyle: MStyle.hintStyle,
                                        errorBorder: MStyle.formErrorBorder,
                                        label: myLabel("Female"),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        suffixIcon: const Icon(
                                          Icons.woman,
                                          size: 16,
                                          color: Color(0xffC2C1C1),
                                        ),
                                        focusedBorder: MStyle.formFocusBorder,
                                        enabledBorder: MStyle.formEnableBorder,
                                        focusedErrorBorder:
                                            MStyle.formErrorBorder,
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
                                      controller: ctr.noOfWomenWithPaidCtr,
                                      maxLines: 1,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 12),
                                        errorBorder: MStyle.formErrorBorder,
                                        label: myLabel("No of Women with paid"),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        focusedBorder: MStyle.formFocusBorder,
                                        enabledBorder: MStyle.formEnableBorder,
                                        focusedErrorBorder:
                                            MStyle.formErrorBorder,
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
                                      controller: ctr.totalLaborCostPaidCtr,
                                      maxLines: 1,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 12),
                                        errorBorder: MStyle.formErrorBorder,
                                        label:
                                            myLabel("Total Labor Cost Paid "),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        prefixIcon: SvgPicture.asset(
                                          'assets/icon/taka_svg.svg',
                                        ),
                                        prefixIconConstraints:
                                            const BoxConstraints(
                                                minHeight: 22, minWidth: 24),
                                        focusedBorder: MStyle.formFocusBorder,
                                        enabledBorder: MStyle.formEnableBorder,
                                        focusedErrorBorder:
                                            MStyle.formErrorBorder,
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
                                    InkWell(
                                      onTap: () {
                                        ctr.pickImageWithGPSMetaData();
                                      },
                                      child: Container(
                                        height: 45,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            border: Border.all(
                                                color: const Color(0xff84A4EB),
                                                width: 1.5)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icon/image_svg.svg',
                                              height: 18,
                                              width: 20,
                                            ),
                                            const Text(
                                              'Attach Image(s)',
                                              style: TextStyle(
                                                  color: Color(0xff407BFF),
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            const Text(
                                              '(with GPS Coordinates)',
                                              style: TextStyle(
                                                  color: Color(0xff6C727F),
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Gap(20),
                                    Visibility(
                                      visible: ctr.selectedImages.isNotEmpty
                                          ? true
                                          : false,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20.0),
                                        child: SizedBox(
                                          height: 150,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  ctr.selectedImages.length,
                                              itemBuilder: (ctx, i) {
                                                var image = ctr.selectedImages
                                                    .elementAt(i);
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 5),
                                                  child: Stack(children: [
                                                    FullScreenWidget(
                                                      disposeLevel:
                                                          DisposeLevel.Medium,
                                                      child: Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: image.hasGeotag
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .red,
                                                                  width: 1.5)),
                                                          // height: 150,
                                                          // width: 130,
                                                          child: Image.file(
                                                            File(image
                                                                .imagePath),
                                                            fit: BoxFit.contain,
                                                          )),
                                                    ),
                                                    Positioned(
                                                      right: 1,
                                                      top: 1,
                                                      child: InkWell(
                                                        child: Icon(
                                                          Icons.cancel,
                                                          color: Colors
                                                              .blue.shade100,
                                                        ),
                                                        onTap: () {
                                                          ctr.removeImage(i);
                                                        },
                                                      ),
                                                    ),
                                                    Positioned(
                                                      bottom: 5,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: image
                                                                    .hasGeotag
                                                                ? Colors.green
                                                                : Colors.red),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                          child: Text(
                                                            image.hasGeotag
                                                                ? 'Geo tag found'
                                                                : 'No Geo tag found',
                                                            style: TextStyle(
                                                                color: image
                                                                        .hasGeotag
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .white,
                                                                fontSize: 8),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ]),
                                                );
                                              }),
                                        ),
                                      ),
                                    ),
                                    const Align(
                                      alignment: AlignmentDirectional.topStart,
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          'Progress Geo Tags',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 10),
                                        ),
                                      ),
                                    ),
                                    buildMapCard(ctr, context),
                                    const Gap(16),
                                    TextFormField(
                                      minLines: 5,
                                      maxLines: 10,
                                      controller: ctr.remarksCtr,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 12),
                                        fillColor: Colors.white,
                                        errorBorder: MStyle.formErrorBorder,
                                        label: const Text("Remarks"),
                                        hintText: 'Write your remarks here',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        hintStyle: MStyle.hintStyle,
                                        focusedBorder: MStyle.formFocusBorder,
                                        enabledBorder: MStyle.formEnableBorder,
                                        focusedErrorBorder:
                                            MStyle.formErrorBorder,
                                      ),
                                    ),
                                    const Gap(16),
                                    Align(
                                      alignment: AlignmentDirectional.topEnd,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                              height: 50,
                                              child: ElevatedButton.icon(
                                                icon: const Icon(
                                                  Icons.save_as_outlined,
                                                  color: Colors.blue,
                                                  size: 18,
                                                ),
                                                label: const Text(
                                                  'Draft',
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      const WidgetStatePropertyAll(
                                                          Colors.white),
                                                  shape: WidgetStatePropertyAll(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4.0))),
                                                  side: WidgetStateProperty.all(
                                                    const BorderSide(
                                                      color: Colors.blue,
                                                      // Set your desired border color here
                                                      width:
                                                          1, // Set the width of the border
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  //1 = update
                                                  if (edit == 1) {
                                                    bool? isDone = await ctr
                                                        .validateAndUpdate(
                                                        status: 1);
                                                    if (isDone != null &&
                                                        isDone == true) {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (ctx) =>
                                                                  SchemeDetailsPage(
                                                                      initialTabIndex:
                                                                      2)));
                                                    }
                                                  } else {
                                                    bool? isDone = await ctr
                                                        .validateAndDraft();

                                                    if (isDone != null &&
                                                        isDone == true) {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (ctx) =>
                                                                  SchemeDetailsPage(
                                                                      initialTabIndex:
                                                                      2)));
                                                    }
                                                  }
                                                },
                                              )),
                                          const Gap(10),
                                          SizedBox(
                                              height: 50,
                                              child: ElevatedButton.icon(
                                                icon: const Icon(
                                                  Icons.save,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                                label: const Text(
                                                  'Submit',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        const WidgetStatePropertyAll(
                                                            Color(0xff407BFF)),
                                                    shape: WidgetStatePropertyAll(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4.0)))),
                                                onPressed: () async {
                                                  if (edit == 1) {
                                                    bool? isDone = await ctr
                                                        .validateAndUpdate(
                                                            status: 2);
                                                    if (isDone != null &&
                                                        isDone == true) {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (ctx) =>
                                                                  SchemeDetailsPage(
                                                                      initialTabIndex:
                                                                          2)));
                                                    }
                                                  } else {
                                                    bool? isDone = await ctr
                                                        .validateAndSave();

                                                    if (isDone != null &&
                                                        isDone == true) {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (ctx) =>
                                                                  SchemeDetailsPage(
                                                                      initialTabIndex:
                                                                          2)));
                                                    }
                                                  }
                                                },
                                              )),
                                        ],
                                      ),
                                    ),
                                    const Gap(20),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
      ),
    );
  }

  Widget buildMapCard(SchemeProgressCtr ctr, BuildContext context) {
    return ctr.latLngList.isEmpty
        ? Container(
            decoration: BoxDecoration(
                color: MStyle.pageColor,
                borderRadius: BorderRadius.circular(3)),
            child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/gpsPage');
                    },
                    icon: const Icon(
                      Icons.my_location_outlined,
                      color: Color(0xffDC3545),
                    ),
                    label: const Text(
                      'Record a Path',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: Color(0xffDC3545),
                      ),
                    ),
                    style: ButtonStyle(
                        side: const WidgetStatePropertyAll(
                            BorderSide(color: Color(0xffDC3545), width: 1.5)),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)))),
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 9.0),
                      child: Text(
                        'Record a path in GPS. Hit the button and move to record',
                        maxLines: 2,
                        style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: 9,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        : Slidable(
            endActionPane: ActionPane(motion: const ScrollMotion(), children: [
              SlidableAction(
                onPressed: (ctx) {
                  ctr.deleteRecordedMap();
                },
                icon: Icons.delete_forever_rounded,
                backgroundColor: const Color(0xffEE4454),
              )
            ]),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: MStyle.pageColor, width: 3),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3)),
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset('assets/icon/save_map_svg.svg'),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 9.0),
                        child: Text(
                          'Map is Recorded ',
                          maxLines: 2,
                          style: TextStyle(
                              color: Color(0xff666666),
                              fontSize: 9,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }

  Widget buildSchemeCard(SchemeProgressCtr ctr) {
    return ExpansionTile(
      collapsedBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      title: const Text('Scheme'),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              Text(
                '${ctr.scheme!.scheme_work_type_en ?? ''}: ',
                style: TextStyle(
                    color: headerTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 11),
              ),
              Text(ctr.scheme!.scheme_type_name_en ?? ' ',
                  style: TextStyle(
                      color: headerTextColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 11)),
            ],
          ),
        ),
        const Gap(18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            ctr.scheme!.scheme_name,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xff333333),
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
        const Gap(18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Package",
                      style: TextStyle(
                          color: headerTextColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(ctr.scheme!.package_name_en ?? 'N/A',
                        maxLines: 1,
                        style: const TextStyle(
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w400,
                            fontSize: 11)),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Status",
                    style: TextStyle(
                        color: headerTextColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: const Color(0xff407BFF)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 3),
                      child: Text(
                          SchemeStatusEnum.getName(ctr.scheme!.scheme_status),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 8)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Gap(18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Concurred Estimated Amount",
                      style: TextStyle(
                          color: headerTextColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(ctr.scheme!.concurred_estimated_amount,
                        maxLines: 1,
                        style: const TextStyle(
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w400,
                            fontSize: 11)),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Beneficiaries",
                    style: TextStyle(
                        color: headerTextColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.man,
                        size: 14,
                      ),
                      Text(
                        ctr.scheme!.number_of_male_beficiary.toString(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      ),
                      const Icon(
                        Icons.woman,
                        size: 14,
                      ),
                      Text(
                        ctr.scheme!.number_of_female_beficiary.toString(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const Gap(18),
      ],
    );
  }
}
