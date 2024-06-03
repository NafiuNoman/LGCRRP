import 'package:com.lged.lgcrrp.misulgi/controller/scheme/scheme_progress_ctr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:com.lged.lgcrrp.misulgi/controller/scheme/progress_details_ctr.dart';
import 'package:com.lged.lgcrrp.misulgi/widget/scheme_cmn_card.dart';
import '../../util/style.dart';

class ProgressDetailsPage extends StatelessWidget {
  const ProgressDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
            )),
        title: Text(
          'Progress',
          style: MStyle.appBarTitleStyle,
        ),
      ),
      backgroundColor: MStyle.pageColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
          child: GetBuilder<ProgressDetailsViewCtr>(
            init: ProgressDetailsViewCtr(),
            builder: (ctr) => ctr.isLoading
                ? const LinearProgressIndicator()
                : Column(
                    children: [
                      const Gap(15),
                      SchemeCmnCard(
                        schemeName: ctr.scheme!.scheme_name,
                        schemeStatus: ctr.scheme!.scheme_status,
                        numberOfMaleBeficiary:
                            ctr.scheme!.number_of_male_beficiary,
                        numberOfFemaleBeficiary:
                            ctr.scheme!.number_of_female_beficiary,
                        concurredEstimatedAmount:
                            ctr.scheme!.concurred_estimated_amount,
                        workTypeEn: ctr.scheme!.scheme_work_type_en,
                        schemeTypeEn: ctr.scheme!.scheme_type_name_en,
                        packageNameEn: ctr.scheme!.package_name_en,
                      ),
                      const Gap(20),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          SizedBox(
                            child: Container(
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        color: Colors.blue.shade200,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 3),
                                          child: RichText(
                                              text: TextSpan(
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                  children: [
                                                TextSpan(
                                                    text:
                                                        ctr.progress!.monthName,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.white)),
                                                TextSpan(
                                                    text:
                                                        ' ${ctr.progress!.year}',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.white))
                                              ])),
                                        ),
                                      ),
                                      Container(
                                          color: Colors.blue,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 3),
                                            child: Text(
                                                "${double.parse(ctr.progress!.physical_progress ?? "00.0").toInt()}%",
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white)),
                                          )),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Financial Progress',
                                                        style:
                                                            MStyle.headerStyle),
                                                    Text(
                                                      // '50% (৳ 500k)',
                                                      '${ctr.progress!.financial_progress ?? "0.0"}%',
                                                      style: MStyle.value1Style,
                                                    ),
                                                    const Gap(
                                                      12,
                                                    ),
                                                    Text(
                                                      'Physical Progress',
                                                      style: MStyle.headerStyle,
                                                    ),
                                                    Text(
                                                      '${ctr.progress!.physical_progress}%',
                                                      // item.physical_progress ?? "",
                                                      style: MStyle.value1Style,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Labor',
                                                        style:
                                                            MStyle.headerStyle),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          // '90',

                                                          "${(ctr.progress!.male_labor_number_reported ?? 0) + (ctr.progress!.female_labor_number_reported ?? 0)} (",

                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 11),
                                                        ),
                                                        const Icon(
                                                          Icons.man,
                                                          size: 14,
                                                          color:
                                                              Color(0xff6C757D),
                                                        ),
                                                        Text(
                                                          // '40',
                                                          ' ${ctr.progress!.male_labor_number_reported ?? 0}',
                                                          style: MStyle
                                                              .headerStyle,
                                                        ),
                                                        const Icon(Icons.woman,
                                                            size: 14,
                                                            color: Color(
                                                                0xff6C757D)),
                                                        Text(
                                                          // '50',
                                                          '${ctr.progress!.female_labor_number_reported ?? 0}',
                                                          style: MStyle
                                                              .headerStyle,
                                                        ),
                                                        const Text(' )',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 11)),
                                                      ],
                                                    ),
                                                    const Gap(
                                                      12,
                                                    ),
                                                    Text(
                                                      'Labor Cost',
                                                      style: MStyle.headerStyle,
                                                    ),
                                                    Text(
                                                      // '৳ 4500',
                                                      '৳ ${ctr.progress!.total_labor_cost_paid ?? "00"}',
                                                      style: MStyle.value1Style,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Gap(12),
                                        const Align(
                                          alignment:
                                              AlignmentDirectional.topStart,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 8.0),
                                            child: Text(
                                              'Progress Geo Tags',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 10),
                                            ),
                                          ),
                                        ),
                                        const Gap(12),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                "/progressMapViewPage");
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: MStyle.pageColor,
                                                    width: 3),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(3)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(9.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/icon/save_map_svg.svg'),
                                                  const Expanded(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 9.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'GPS Track Recorded ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 9,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                          Text(
                                                            'Click to view in map',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 9,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Gap(12),
                                        ctr.isDraft == true
                                            ? OutlinedButton(
                                                onPressed: () async {
                                                  await Get.find<
                                                          SchemeProgressCtr>()
                                                      .loadDraftDataForProgress();

                                                  Navigator.popAndPushNamed(
                                                      context,
                                                      "/schemeProgressAddPage",arguments: 1);// 1 = edit
                                                },
                                                child: const Text('Edit'))
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18.0),
                                    child: buildImageList(ctr),
                                  ),
                                  const Gap(15),
                                ],
                              ),
                            ),
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
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6.0, vertical: 3),
                                  child: Text(ctr.status,
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
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget buildImageList(ProgressDetailsViewCtr ctr) {
    if (ctr.images != null) {
      if (ctr.images!.isNotEmpty) {
        return SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, i) => Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Image.network(
                  ctr.images!.elementAt(i).scheme_progress_image_url),
            ),
            itemCount: ctr.images!.length,
          ),
        );
      } else {
        return const SizedBox();
      }
    } else {
      return const SizedBox();
    }
  }
}
