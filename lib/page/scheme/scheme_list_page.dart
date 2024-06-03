import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:com.lged.lgcrrp.misulgi/util/constant.dart';
import 'package:com.lged.lgcrrp.misulgi/util/style.dart';
import 'package:com.lged.lgcrrp.misulgi/widget/simmer_loading.dart';
import '../../controller/scheme/scheme_list_ctr.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/response_model/scheme/scheme_list_model.dart';

Color headerTextColor = const Color(0xff6C727F);

class SchemeListPage extends StatelessWidget {
  const SchemeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MStyle.pageColor,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: const Text(
          'Schemes',
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
          child: GetBuilder<SchemeListCtr>(
            init: SchemeListCtr(),
            builder: (ctr) {
              return Column(
                children: [
                  const Gap(15),
                  filterSection(ctr),
                  const Gap(10),
                  listSection(ctr.list, ctr),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget filterSection(SchemeListCtr ctr) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ExpansionTile(
        initiallyExpanded: ctr.expandFilter,
        collapsedBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        title: const Text(
          'Scheme Filter',
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
        ),
        leading: const Icon(Icons.filter_alt_outlined),
        children: [
          Builder(
            builder: (ctx) {
              return Column(
                children: [
                  const Gap(10),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 15, right: 14, left: 14),
                    child: Column(
                      children: [
                        const Gap(18),
                        TextField(
                          controller: ctr.schemeIdCtr,
                          maxLines: 1,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 8),
                              label: const Text('Scheme ID'),
                              hintText: 'Search by scheme Id',
                              hintStyle: MStyle.filterDropDownHintStyle,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              enabledBorder: MStyle.filterEnabledInputBorder,
                              focusedBorder: MStyle.filterEnabledInputBorder),
                        ),
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
                        DropdownButtonFormField(
                          isExpanded: true,
                          value: ctr.packageId == 0 ? null : ctr.packageId,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 8),
                              label: const Text('Package Name & No.'),
                              hintText: 'Choose Package Name & No',
                              hintStyle: MStyle.filterDropDownHintStyle,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              enabledBorder: MStyle.filterEnabledInputBorder,
                              focusedBorder: MStyle.filterEnabledInputBorder),
                          items: ctr.packageDropDownItems,
                          onChanged: (value) {
                            if (value != null) {
                              ctr.packageId = value;
                            }
                          },
                        ),
                        const Gap(18),
                        DropdownButtonFormField(
                          isExpanded: true,
                          value: ctr.categoryId == 0 ? null : ctr.categoryId,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 8),
                              label: const Text('Scheme Category'),
                              hintText: 'Choose a scheme category',
                              hintStyle: MStyle.filterDropDownHintStyle,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              enabledBorder: MStyle.filterEnabledInputBorder,
                              focusedBorder: MStyle.filterEnabledInputBorder),
                          items: ctr.categoryDropDownItems,
                          onChanged: (value) {
                            if (value != null) {
                              ctr.categoryId = value;
                            }
                          },
                        ),
                        const Gap(18),
                        DropdownButtonFormField(
                          isExpanded: true,
                          value:
                              ctr.subCategoryId == 0 ? null : ctr.subCategoryId,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 8),
                              label: const Text('Scheme Sub Category'),
                              hintText: 'Choose a scheme sub category',
                              hintStyle: MStyle.filterDropDownHintStyle,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              enabledBorder: MStyle.filterEnabledInputBorder,
                              focusedBorder: MStyle.filterEnabledInputBorder),
                          items: ctr.subCategoryDropDownItems,
                          onChanged: (value) {
                            if (value != null) {
                              ctr.subCategoryId = value;
                            }
                          },
                        ),
                        const Gap(18),
                        Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: ElevatedButton.icon(
                            onPressed: () {

                              ctr.pageNumber = 1;
                              ctr.lastPageNumber = 1;
                              ctr.list.clear();
                              ExpansionTileController.of(ctx).collapse();
                              ctr.getSchemeList();
                            },
                            icon:
                                SvgPicture.asset('assets/icon/search_svg.svg'),
                            label: const Text(
                              'Filter',
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

  Widget listSection(List<Scheme> list, SchemeListCtr ctr) {
    int count = list.length;

    if (count == 0) {
      return ctr.isLoading == true
          ? const Expanded(child: SimmerLoading())
          : const Text("Filter for Schmes", style: TextStyle(fontSize: 20));
    } else {
      return Expanded(
        child: ListView.builder(
          controller: ctr.scrollController,
          itemCount: ctr.hasMoreData ? count + 1 : count,
          itemBuilder: (ctx, index) {
            if (index < count) {
              var scheme = list[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 10.0),
                child: Column(
                  children: [
                    //scheme card
                    Ink(
                      height: 238,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          border: BorderDirectional(
                              top: BorderSide(
                                  width: 4, color: Color(0xff84A4EB)))
                          // borderRadius: BorderRadius.circular(10)
                          ),
                      child: InkWell(
                        splashColor: Colors.blue.shade100,
                        onTap: () {
                          ctr.setSelectedScheme(scheme.id);

                          Navigator.pushNamed(ctx, "/schemeDetailsPage");
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 22),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${scheme.scheme_work_type_en ?? ''}: ',
                                    style: TextStyle(
                                        color: headerTextColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11),
                                  ),
                                  Text(scheme.scheme_type_name_en ?? '',
                                      style: TextStyle(
                                          color: headerTextColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 11)),
                                ],
                              ),
                              Text(
                                scheme.scheme_name,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xff84A4EB),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
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
                                          "Package",
                                          style: TextStyle(
                                              color: headerTextColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(scheme.package_name_en ?? 'N/A',
                                            maxLines: 1,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11)),
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
                                        "Status",
                                        style: TextStyle(
                                            color: headerTextColor,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            color: const Color(0xff407BFF)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6.0, vertical: 3),
                                          child: Center(
                                            child: Text(
                                                SchemeStatusEnum.getName(
                                                    scheme.scheme_status),
                                                maxLines: 1,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w400,
                                                    fontSize: 7)),
                                          ),
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
                    ),
                  ],
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
