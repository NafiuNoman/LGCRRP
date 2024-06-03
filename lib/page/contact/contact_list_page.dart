import 'package:com.lged.lgcrrp.misulgi/data/remote/model/contact_super_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:com.lged.lgcrrp.misulgi/controller/contact/contact_list_Controller.dart';
import '../../util/common_method.dart';
import '../../util/style.dart';
import '../../widget/simmer_loading.dart';

class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactListController>(
        init: ContactListController(),
        builder: (ctr) {
          return Scaffold(
            backgroundColor: MStyle.pageColor,
            appBar: AppBar(
              backgroundColor: Colors.blue.shade200,
              title: const Text(
                'Contacts',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.white,
                  )),
              actions: [
                PopupMenuButton(
                  color: Colors.white,
                  itemBuilder: (ctx) => [
                    const PopupMenuItem(
                      value: 1,
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Profile'),
                      ),
                    ),
                    const PopupMenuItem(
                      value: 2,
                      child: ListTile(
                        leading: Icon(Icons.logout_outlined),
                        title: Text('Logout'),
                      ),
                    ),
                  ],
                  onSelected: (selectedValue) async {
                    selectedValue == 1
                        ? await goToDetailsPageForProfile(context, ctr)
                        : logOutFromContactUser(context, ctr);
                  },
                )
              ],
            ),
            body: SafeArea(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        const Gap(15),
                        filterSection(ctr),
                        const Gap(10),
                        listSection(ctr),
                      ],
                    ))),
          );
        });
  }

  Future<void> goToDetailsPageForProfile(
      BuildContext context, ContactListController ctr) async {
    var userContactModel = await ctr.getLoggedInUserContactDetails();

    Navigator.pushNamed(context, "/contactDetails",
        arguments: userContactModel);
  }

  logOutFromContactUser(BuildContext context, ContactListController ctr) async {
    await ctr.clearIdOfUser();
    Navigator.pop(context, '/DashBoard');
  }

  Widget filterSection(ContactListController ctr) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ExpansionTile(
        initiallyExpanded: true,
        collapsedBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        title: const Text(
          'Contact Filter',
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
        ),
        leading: const Icon(Icons.filter_alt_outlined),
        children: [
          Builder(builder: (buildCtx) {
            return Column(
              children: [
                const Gap(10),
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
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            enabledBorder: MStyle.filterEnabledInputBorder,
                            focusedBorder: MStyle.filterEnabledInputBorder),
                        items: ctr.divisionDropDownItems,
                        onChanged: (value) {
                          if (value != null) {
                            ctr.setDistricts(value);
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
                          onChanged: (value) {
                            if (value != null) {
                              ctr.setCityCorporation(value);
                            }
                          }),
                      const Gap(18),
                      DropdownButtonFormField(
                          isExpanded: true,
                          value: ctr.cityCropId == 0 ? null : ctr.cityCropId,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 8),
                              label: const Text('City Corporation/Pourashava'),
                              hintText: 'Choose a city corporation/pourashava',
                              hintStyle: MStyle.filterDropDownHintStyle,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              enabledBorder: MStyle.filterEnabledInputBorder,
                              focusedBorder: MStyle.filterEnabledInputBorder),
                          items: ctr.cityCropDropDownItems,
                          onChanged: (value) {
                            if (value != null) {
                              ctr.setCityCropsValue(value);
                            }
                          }),
                      const Gap(18),
                      TextField(
                        controller: ctr.searchCtr,
                        maxLines: 1,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 8),
                            label: const Text('Search'),
                            hintText: 'Search by name/mobile/email',
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
                            ctr.pageNumber = 1;
                            ctr.lastPageNumber = 1;
                            ExpansionTileController.of(buildCtx).collapse();
                            ctr.list.clear();
                            ctr.getUserContactList();
                          },
                          icon: SvgPicture.asset('assets/icon/search_svg.svg'),
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
          })
        ],
      ),
    );

    // return SizedBox(height: 150,width: 150,);
  }

  Widget listSection(ContactListController ctr) {
    List<ContactModel> contactList = ctr.list;
    int count = contactList.length;

    if (count == 0) {
      return ctr.isLoading == true
          ? const Expanded(child: SimmerLoading())
          : const Text("Filter for Contacts", style: TextStyle(fontSize: 20));
    } else {
      return Expanded(
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            if (index < count) {
              ContactModel item = contactList.elementAt(index);

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: Ink(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.blue,
                        width: 1.5,
                      )),
                  width: MediaQuery.of(ctx).size.width,
                  height: 120,
                  child: InkWell(
                    splashColor: Colors.blue.shade100,
                    onTap: () {
                      Navigator.pushNamed(ctx, "/contactDetails",
                          arguments: item);
                    },
                    child: Row(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: item.profile_image_url != null
                                  ? Image.network(item.profile_image_url!)
                                  : const Icon(Icons.person),
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 4,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //user name
                                Text(
                                  item.name_en,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff263238)),
                                ),
                                //designation
                                FutureBuilder(
                                  future: ctr
                                      .getDesignationById(item.designation_id),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Text(
                                          "...."); // Placeholder for loading state
                                    } else if (snapshot.hasError) {
                                      return const Text(
                                          'Designation not found');
                                    } else if (snapshot.hasData &&
                                        snapshot.data != null) {
                                      return Text(snapshot.data!,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff263238),
                                          )); // Display data
                                    } else {
                                      return const Text(
                                        'Designation not found',
                                      ); // Handle null or empty data
                                    }
                                  },
                                ),
                                const Gap(4),
                                //mobile no
                                Text(item.mobile_number,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff007AFF),
                                    )),
                                const Gap(4),
                                item.division_name_en != null
                                    ? Text(
                                        item.division_name_en!,
                                        style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    : const SizedBox(),
                                item.district_name_en != null
                                    ? Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            item.district_name_en!,
                                            style: const TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          item.organogram_name_en != null
                                              ? Text(
                                                  ', ${item.district_name_en!}',
                                                  style: const TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )
                                              : const SizedBox(),
                                        ],
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: IconButton.outlined(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<CircleBorder>(
                                  const CircleBorder(),
                                ),
                                side: MaterialStateProperty.all<BorderSide>(
                                  const BorderSide(
                                      color: Colors.blue,
                                      width: 2), // Border color and width
                                ),
                              ),
                              color: Colors.blue,
                              onPressed: () async {
                                await intentApp(
                                    ctx,
                                    Uri(
                                        scheme: 'tel',
                                        path: item.mobile_number.toString()));
                              },
                              icon: const Icon(
                                Icons.phone_outlined,
                                color: Colors.blue,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
          itemCount: ctr.hasMoreData ? count + 1 : count,
          controller: ctr.scrollController,
        ),
      );
    }
  }
}
