import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:com.lged.lgcrrp.misulgi/controller/grs/complaint_ctr.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/response_model/grs/complaint_list_model.dart';
import 'package:com.lged.lgcrrp.misulgi/util/style.dart';
import 'package:com.lged.lgcrrp.misulgi/widget/simmer_loading.dart';

import '../scheme/scheme_details_page.dart';

class ComplaintListPage extends StatelessWidget {
  const ComplaintListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MStyle.pageColor,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: const Text(
          'Complaints',
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
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GetBuilder<ComplaintCtr>(
            init: ComplaintCtr(),
            builder: (ctr) {
              return Column(
                children: [
                  const Gap(15),
                  filterSection(ctr),
                  const Gap(10),
                  listSection(ctr.list, context, ctr),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget filterSection(ComplaintCtr ctr) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ExpansionTile(
        initiallyExpanded: ctr.expandFilter,
        collapsedBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        title: const Text(
          'Filter',
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
        ),
        leading: const Icon(Icons.filter_alt_outlined),
        children: [
          Builder(
            builder: (ctx) {
              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 15, right: 14, left: 14),
                    child: Column(
                      children: [
                        const Gap(18),
                        DropdownButtonFormField(
                          isExpanded: true,
                          value: ctr.divisionId == 0 ? null : ctr.divisionId,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 8),
                              label: const Text('Division'),
                              hintText: 'Choose a Division',
                              hintStyle: MStyle.filterDropDownHintStyle,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              enabledBorder: MStyle.filterEnabledInputBorder,
                              focusedBorder: MStyle.filterEnabledInputBorder),
                          items: ctr.divisionDropDownItems,
                          onChanged: ctr.divisionDrpLock == true
                              ? null
                              : (value) {
                                  if (value != null) {
                                    ctr.setDistricts(divId: value as int);
                                  }
                                },
                        ),
                        const Gap(18),
                        DropdownButtonFormField(
                            isExpanded: true,
                            value: ctr.districtId == 0 ? null : ctr.districtId,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left: 8),
                                label: const Text('District'),
                                hintText: 'Choose a District',
                                hintStyle: MStyle.filterDropDownHintStyle,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                enabledBorder: MStyle.filterEnabledInputBorder,
                                focusedBorder: MStyle.filterEnabledInputBorder),
                            items: ctr.districtDropDownItems,
                            onChanged: ctr.districtictDrpLock == true
                                ? null
                                : (value) {
                                    if (value != null) {
                                      ctr.setCityCorporation(
                                          disId: value as int);
                                    }
                                  }),
                        const Gap(18),
                        DropdownButtonFormField(
                            isExpanded: true,
                            value: ctr.cityCropId == 0 ? null : ctr.cityCropId,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left: 8),
                                label:
                                    const Text('City Corporation/Pourashava'),
                                hintText:
                                    'Choose a city corporation/pourashava',
                                hintStyle: MStyle.filterDropDownHintStyle,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                enabledBorder: MStyle.filterEnabledInputBorder,
                                focusedBorder: MStyle.filterEnabledInputBorder),
                            items: ctr.cityCropDropDownItems,
                            onChanged: ctr.cityCropDrpLock == true
                                ? null
                                : (value) {
                                    if (value != null) {
                                      ctr.setCityCropsValue(value as int);
                                    }
                                  }),
                        const Gap(18),
                        TextField(
                          controller: ctr.trackingNoCtr,
                          maxLines: 1,
                          keyboardType: const TextInputType.numberWithOptions(),
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 8),
                              label: const Text('Tracking No.'),
                              hintText: 'Search by tracking number',
                              hintStyle: MStyle.filterDropDownHintStyle,
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              enabledBorder: MStyle.filterEnabledInputBorder,
                              focusedBorder: MStyle.filterEnabledInputBorder),
                        ),
                        const Gap(18),
                        Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              ExpansionTileController.of(ctx).collapse();
                              ctr.pageNumber = 1;
                              ctr.lastPageNumber = 1;
                              ctr.list.clear();
                              ctr.getComplaintList();
                            },
                            icon:
                                SvgPicture.asset('assets/icon/search_svg.svg'),
                            label: const Text(
                              'Search',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 9.97),
                            ),
                            style: ButtonStyle(
                                backgroundColor: const MaterialStatePropertyAll(
                                    Color(0xff407BFF)),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0)))),
                          ),
                        ),
                        const Gap(5),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget listSection(List<ComplaintDetailsModel> list, BuildContext context,
      ComplaintCtr ctr) {
    int count = list.length;

    if (count == 0) {
      return ctr.isLoading == true
          ? const Expanded(child: SimmerLoading())
          : const Text("Filter for Complaints", style: TextStyle(fontSize: 20));
    } else {
      return Expanded(
        child: ListView.builder(
          controller: ctr.scrollController,
          itemCount: ctr.hasMoreData ? count + 1 : count,
          itemBuilder: (ctx, index) {
            if (index < count) {
              var complaint = list[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 10.0),
                child: InkWell(
                  splashColor: Colors.blue.shade100,
                  onTap: () {

                    Navigator.pushNamed(context, "/complaintDetailsPage",arguments: complaint);
                  },
                  child: Stack(clipBehavior: Clip.none, children: [
                    Column(
                      children: [
                        //scheme card
                        Ink(
                          height: 180,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              border: BorderDirectional(
                                  top: BorderSide(
                                      width: 4, color: Color(0xff84A4EB)))
                              // borderRadius: BorderRadius.circular(10)
                              ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 22),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Site office/Scheme name',
                                      style: TextStyle(
                                          color: headerTextColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10),
                                    ),
                                    Text(complaint.site_office,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12)),
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Complaint Title',
                                      style: TextStyle(
                                          color: headerTextColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10),
                                    ),
                                    Text(
                                      complaint.complaint_title,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Color(0xff84A4EB),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),

                                // Html(
                                //   data: complaint.complaint_explanation,
                                //   style: {
                                //     '#': Style(
                                //       fontSize: FontSize(14),
                                //       maxLines: 2,
                                //       textOverflow: TextOverflow.ellipsis,
                                //     ),
                                //   },
                                // ),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Submitted Date",
                                            style: TextStyle(
                                                color: headerTextColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(complaint.complaint_submit_date,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12)),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Tracking Number",
                                          style: TextStyle(
                                              color: headerTextColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6.0, vertical: 3),
                                          child: Center(
                                            child: Text(
                                                complaint.tracking_number,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      right: 10,
                      top: -10,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: MStyle.pageColor,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: const Color(0xff407BFF)),
                          child:  Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6.0, vertical: 3),
                            child: Text(complaint.complaint_status,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 8)),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              );
            } else {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
      );
    }
  }
}
