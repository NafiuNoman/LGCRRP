import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/response_model/scheme/scheme_list_model.dart';
import 'package:com.lged.lgcrrp.misulgi/page/map/scheme_map_page.dart';
import 'package:com.lged.lgcrrp.misulgi/util/style.dart';
import 'package:com.lged.lgcrrp.misulgi/widget/simmer_loading.dart';
import '../../controller/scheme/scheme_list_ctr.dart';
import '../../data/local/entity/join_entity/progress_and_status.dart';
import '../../util/common_method.dart';
import '../../util/constant.dart';

Color headerTextColor = const Color(0xff6C727F);
FontWeight headerFontWeight = FontWeight.w400;
double headerFontSize = 10.0;

class SchemeDetailsPage extends StatefulWidget {
  final int initialTabIndex;

  const SchemeDetailsPage({super.key, required this.initialTabIndex});

  @override
  State<SchemeDetailsPage> createState() => _SchemeDetailsPageState();
}

class _SchemeDetailsPageState extends State<SchemeDetailsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final ctr = Get.find<SchemeListCtr>();

  Scheme? scheme;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.index = widget.initialTabIndex; //set initial index

    getSelectedScheme();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(
          context,
         ModalRoute.withName('/schemeListPage'),
        );

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade200,
          leading: IconButton(
              onPressed: () {
                Navigator.popUntil(
                  context,
                  ModalRoute.withName('/schemeListPage'),
                );              },
              icon: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.white,
              )),
          title: Text(
            'Scheme',
            style: MStyle.appBarTitleStyle,
          ),
        ),
        backgroundColor: MStyle.pageColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
            child: Column(
              children: [
                //tab view
                Expanded(flex: 4, child: buildTabPages(_tabController)),
                buildTabBar(_tabController),

                //short view
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTabBar(TabController tabController) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Container(
        height: 39,
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff407BFF)),
            borderRadius: BorderRadius.circular(5)),
        child: TabBar(
            labelStyle:
                const TextStyle(fontSize: 9, fontWeight: FontWeight.w400),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            indicator: BoxDecoration(
                color: const Color(0xff407BFF),
                borderRadius: BorderRadius.circular(5)),
            controller: tabController,
            tabs: const [
              Tab(
                iconMargin: EdgeInsets.only(bottom: 4),
                icon: Icon(
                  Icons.dehaze,
                  size: 19,
                ),
                text: 'Details',
              ),
              Tab(
                iconMargin: EdgeInsets.only(bottom: 4),
                icon: Icon(
                  Icons.map_outlined,
                  size: 19,
                ),
                text: 'Map',
              ),
              Tab(
                iconMargin: EdgeInsets.only(bottom: 4),
                icon: Icon(
                  Icons.account_tree_outlined,
                  size: 19,
                ),
                text: 'Progress',
              ),
            ]),
      ),
    );
  }

  Widget buildTabPages(TabController tabController) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: SizedBox(
        child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: [
              //scheme details
              buildDetailsCard(),
              //map
              const SchemeMapPage(),
              //progress card
              buildProgressList(),
            ]),
      ),
    );
  }

  Widget buildDetailsCard() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,

              // borderRadius: BorderRadius.circular(10)
            ),
            child: scheme == null
                ? const Column(
                    children: [
                      Center(
                          child: SizedBox(
                              height: 100,
                              width: 100,
                              child: CircularProgressIndicator())),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 22),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${scheme!.scheme_work_type_en ?? ''}: ',
                              style: TextStyle(
                                  color: headerTextColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11),
                            ),
                            Text(scheme!.scheme_type_name_en ?? ' ',
                                style: TextStyle(
                                    color: headerTextColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11)),
                          ],
                        ),
                        const Gap(16),
                        Text(
                          scheme!.scheme_name,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xff333333),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        const Gap(16),
                        Row(
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
                                  Text(scheme!.package_name_en ?? 'N/A',
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
                                        SchemeStatusEnum.getName(
                                            scheme!.scheme_status),
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
                        const Gap(16),
                        Row(
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
                                  Text(scheme!.concurred_estimated_amount,
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
                                      scheme!.number_of_male_beficiary
                                          .toString(),
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
                                      scheme!.number_of_female_beficiary
                                          .toString(),
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
                        const Gap(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Scheme Category",
                                    style: TextStyle(
                                        color: headerTextColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(ctr.schemeCategoryName,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11)),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Scheme Sub Category",
                                    style: TextStyle(
                                        color: headerTextColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(ctr.schemeSubCategoryName,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Gap(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Scheme ID",
                                    style: TextStyle(
                                        color: headerTextColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(scheme!.id.toString(),
                                      maxLines: 2,
                                      style: const TextStyle(
                                          color: Colors.blue,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 2.5,
                                          fontSize: 11)),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Pillar",
                                    style: TextStyle(
                                        color: headerTextColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(scheme!.piller_name_en,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Gap(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Contractor Name",
                                    style: TextStyle(
                                        color: headerTextColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(scheme!.contractor_name,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11)),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Approval Date",
                                    style: TextStyle(
                                        color: headerTextColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                      dateFormatForView(scheme!.reporting_date),
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Gap(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Contracted Amount",
                                    style: TextStyle(
                                        color: headerTextColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(scheme!.contracted_amount,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11)),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Date of Agreement",
                                    style: TextStyle(
                                        color: headerTextColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                      dateFormatForView(
                                          scheme!.date_of_agreement),
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Gap(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Commencement Date",
                                    style: TextStyle(
                                        color: headerTextColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                      dateFormatForView(
                                          scheme!.date_of_commencement),
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11)),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Completion Planed Date (As per Contract)",
                                    style: TextStyle(
                                        color: headerTextColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                      dateFormatForView(scheme!
                                          .date_of_planned_completion_date),
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Gap(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Actual Completion Date",
                                    style: TextStyle(
                                        color: headerTextColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                      dateFormatForView(scheme!
                                          .date_of_actual_completion_date),
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11)),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "IS LIPW?",
                                    style: TextStyle(
                                        color: headerTextColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(scheme!.is_lipw == 1 ? "YES" : "NO",
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11)),
                                ],
                              ),
                            ),
                          ],
                        ),
//newly added
                        const Gap(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Date of commencement of work (planned)",
                                    style: TextStyle(
                                        color: headerTextColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                      dateFormatForView(scheme!
                                          .date_commencement_of_work_planned),
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11)),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Date of Conceptual proposal submitted to PMU",
                                    style: TextStyle(
                                        color: headerTextColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                      dateFormatForView(scheme!
                                          .date_conceptual_proposal_submitted_to_pmu),
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Gap(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Date of Final proposal submitted to PMU",
                                    style: TextStyle(
                                        color: headerTextColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                      dateFormatForView(scheme!
                                          .date_final_proposal_submitted_to_pmu),
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11)),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Date of Proposal approved for preparation of Tender",
                                    style: TextStyle(
                                        color: headerTextColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                      dateFormatForView(scheme!
                                          .date_proposal_approved_for_preparation_of_bid),
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Gap(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Date of Invitation to Tender",
                                    style: TextStyle(
                                        color: headerTextColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                      dateFormatForView(
                                          scheme!.date_invitation_of_bid),
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11)),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Date of Award of contract",
                                    style: TextStyle(
                                        color: headerTextColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                      dateFormatForView(
                                          scheme!.date_award_of_contract),
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Gap(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Is Climate Risk Incorporated?",
                                    style: TextStyle(
                                        color: headerTextColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                      scheme!.is_climate_risk_incorporated == 1
                                          ? "YES"
                                          : "NO",
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11)),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Has safeguards related issues?",
                                    style: TextStyle(
                                        color: headerTextColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                      scheme!.has_safeguard_related_issues == 1
                                          ? "YES"
                                          : "NO",
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Gap(16),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Remarks",
                              style: TextStyle(
                                  color: headerTextColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(scheme!.remarks,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11)),
                          ],
                        ),
                        const Gap(16),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Explain what the issues and mitigation measures of safeguards related issues",
                              style: TextStyle(
                                  color: headerTextColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              scheme!.safeguard_related_issues,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget buildProgressList() {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
            future: ctr.getSchemeProgressList(),
            builder: (ctx, snp) {
              if (snp.hasError) {
                return Text("Error ${snp.error}");
              } else if (snp.connectionState == ConnectionState.waiting) {
                return const SimmerLoading();
              } else if (snp.hasData) {
                if (snp.data!.isNotEmpty) {
                  return buildList(snp);
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/image/empty_list.png',
                        height: 70,
                        width: 70,
                      ),
                      const Text('No progress found for this scheme'),
                    ],
                  );
                }
              } else {
                return const Text("Something  went wrong");
              }
            },
          ),
        ),
        const Gap(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(
                'ADD',
                style: TextStyle(
                    color: Color(0xff407BFF),
                    fontWeight: FontWeight.w700,
                    fontSize: 9),
              ),
              Text(
                'PROGRESS',
                style: TextStyle(
                    color: Color(0xff407BFF),
                    fontWeight: FontWeight.w700,
                    fontSize: 9),
              )
            ]),
            const SizedBox(
              width: 5,
            ),
            IconButton.outlined(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Color(0xff407BFF)),
                    side: MaterialStatePropertyAll(
                        BorderSide(color: Colors.white, width: 3))),
                color: Colors.blue,
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, "/schemeProgressAddPage",
                      arguments: 0);
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                )),
          ],
        )
      ],
    );
  }

  Column buildList(AsyncSnapshot<List<ProgressAndStatusJoinModel>?> snp) {
    List<ProgressAndStatusJoinModel> list = snp.data!;
    int serialNo = list.length + 1;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (ctx, index) {
                serialNo--;
                ProgressAndStatusJoinModel item = list.elementAt(index);
                return InkWell(
                  onTap: () {
                    ctr.setSelectedProgress(item.id!);

                    Navigator.pushNamed(context, "/progressDetailsPage");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12.0, top: 10),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 117,
                          color: Colors.white,
                          child: Row(
                            children: [
                              //date and percentage
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        width: double.infinity,
                                        color: const Color(0xff84A4EB),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              item.dayOfMonth ?? "",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              item.monthName ?? "",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              item.year ?? "",
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                          height: 20,
                                          color: const Color(0xff6785C6),
                                          child: Center(
                                            child: Text(
                                              "${double.parse(item.physical_progress ?? "00.0").toInt()}%",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 17.0, horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Financial Progress',
                                          style: MStyle.headerStyle),
                                      Text(
                                        // '50% (৳ 500k)'
                                        '${item.financial_progress ?? "0.0"}%',
                                        style: MStyle.value1Style,
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        'Physical Progress',
                                        style: MStyle.headerStyle,
                                      ),
                                      Text(
                                        '${item.physical_progress ?? "0.0"}%',
                                        style: MStyle.value1Style,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 17.0, horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Labor', style: MStyle.headerStyle),
                                      Row(
                                        children: [
                                          Text(
                                            "${(item.male_labor_number_reported ?? 0) + (item.female_labor_number_reported ?? 0)} (",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11),
                                          ),
                                          const Icon(
                                            Icons.man,
                                            size: 14,
                                            color: Color(0xff6C757D),
                                          ),
                                          Text(
                                            ' ${item.male_labor_number_reported ?? 0}',
                                            style: MStyle.headerStyle,
                                          ),
                                          const Icon(Icons.woman,
                                              size: 14,
                                              color: Color(0xff6C757D)),
                                          Text(
                                            '${item.female_labor_number_reported ?? 0}',
                                            style: MStyle.headerStyle,
                                          ),
                                          const Text(' )',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
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
                                        '৳ ${item.total_labor_cost_paid ?? "00"}',
                                        style: MStyle.value1Style,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
                                  color: item.name_en == 'Draft'
                                      ? const Color(0xff6c757d)
                                      : const Color(0xff407BFF)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6.0, vertical: 3),
                                child: Text(item.name_en ?? "N/A",
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
                        Positioned(
                          left: 5,
                          top: -10,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: MStyle.pageColor,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: const Color(0xff407BFF)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6.0, vertical: 3),
                                child: Text('$serialNo',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }

  void getSelectedScheme() async {
    EasyLoading.show();
    scheme = await ctr.getScheme();
    EasyLoading.dismiss();
    setState(() {});
  }
}
