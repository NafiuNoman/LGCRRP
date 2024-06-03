import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.lged.lgcrrp.misulgi/widget/my_circle_avatear.dart';

import '../../controller/contact/contact_list_Controller.dart';
import '../../controller/contact/profile_form_controller.dart';
import '../../data/remote/model/contact_super_model.dart';
import '../../util/common_method.dart';
import '../../widget/my_contact_btn.dart';

class ContactDetailsPage extends StatelessWidget {
  ContactDetailsPage({super.key});

  final ctr = Get.find<ContactListController>();

  final infoStyle = const TextStyle(fontSize: 16);
  late ContactModel user;

  bool isSameUser() {
    if (user.id == ctr.getUserIdFromPref()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    user = ModalRoute.of(context)!.settings.arguments as ContactModel;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F7F7),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        actions: [
          Visibility(
              visible: isSameUser(),
              child: IconButton.outlined(
                  onPressed: () {
                    final ctr = Get.find<ProfileFormController>();
                    ctr.currentUser = user;
                    ctr.loadDataAsUser();
                    ctr.mode='update';
                    Navigator.pushReplacementNamed(
                      context,
                      "/profileFormPage",
                    );
                  },
                  icon: const Icon(Icons.edit)))
        ],
      ),
      backgroundColor: const Color(0xFFF9F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MyCircleAvatar(
                imageUrl: user.profile_image_url,
              ),
              Text(
                user.name_en,
                style: const TextStyle(fontSize: 22),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MyContactBtn(
                      label: "Call",
                      icon: const Icon(
                        Icons.local_phone_outlined,
                        size: 25,
                        color: Colors.white,
                      ),
                      pressedFunction: () {
                        intentApp(
                            context,
                            Uri(
                                scheme: 'tel',
                                path: user.mobile_number.toString()));
                      }),
                  MyContactBtn(
                      label: "Email",
                      icon: const Icon(
                        Icons.email_outlined,
                        size: 25,
                        color: Colors.white,
                      ),
                      pressedFunction: () {
                        intentApp(context,
                            Uri(scheme: 'mailto', path: user.email.toString()));
                      }),
                  MyContactBtn(
                      label: "WhatsApp",
                      icon: Image.asset('assets/icon/whatsapp-24.png'),
                      pressedFunction: () {
                        intentApp(
                            context,
                            Uri(
                                scheme: 'https',
                                host: 'wa.me',
                                queryParameters: {'text': ''},
                                path: user.mobile_number.toString()));
                      }),
                  MyContactBtn(
                      label: "Text",
                      icon: const Icon(
                        Icons.message_outlined,
                        size: 25,
                        color: Colors.white,
                      ),
                      pressedFunction: () {
                        intentApp(
                            context,
                            Uri(
                                scheme: 'sms',
                                path: user.mobile_number.toString()));
                      }),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Color(0xFFDBE2EF)),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Contact info",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      ListTile(
                        leading: IconButton(
                            onPressed: () async {
                              await intentApp(
                                  context,
                                  Uri(
                                      scheme: 'tel',
                                      path: user.mobile_number.toString()));
                            },
                            icon: const Icon(Icons.local_phone_outlined)),
                        title: Text(user.mobile_number),
                        subtitle: const Text("Work"),
                        trailing: IconButton(
                          onPressed: () {
                            intentApp(
                                context,
                                Uri(
                                    scheme: 'sms',
                                    path: user.mobile_number.toString()));
                          },
                          icon: const Icon(Icons.message_outlined),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          intentApp(
                              context,
                              Uri(
                                  scheme: 'mailto',
                                  path: user.email.toString()));
                        },
                        child: ListTile(
                          leading: const Icon(Icons.email_outlined),
                          title: Text(
                            user.email.toString(),
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Color(0xFFDBE2EF)),
                  width: double.infinity,
                  // height: MediaQuery.of(context).size.height / 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Information Details",
                          style: TextStyle(fontSize: 20),
                        ),
                        Row(
                          children: [
                            const Expanded(
                                flex: 2,
                                child: Text(
                                  "Division:",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                )),
                            Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: FutureBuilder(
                                    future: ctr
                                        .getDivisionNameById(user.division_id),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child:
                                                CircularProgressIndicator()); // Placeholder for loading state
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else if (snapshot.hasData &&
                                          snapshot.data != null) {
                                        return Text(snapshot.data!,
                                            style: infoStyle); // Display data
                                      } else {
                                        return Text('N/A',
                                            style:
                                                infoStyle); // Handle null or empty data
                                      }
                                    },
                                  ),
                                )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              const Expanded(flex: 2, child: Text("District:")),
                              Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: FutureBuilder(
                                      future: ctr.getDistrictNameById(
                                          user.district_id),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator()); // Placeholder for loading state
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else if (snapshot.hasData &&
                                            snapshot.data != null) {
                                          return Text(snapshot.data!,
                                              style: infoStyle); // Display data
                                        } else {
                                          return Text('N/A',
                                              style:
                                                  infoStyle); // Handle null or empty data
                                        }
                                      },
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              const Expanded(
                                  flex: 2, child: Text("City Corporation:")),
                              Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: FutureBuilder(
                                      future: ctr.getCityCropNameById(
                                          user.organogram_id),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator()); // Placeholder for loading state
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else if (snapshot.hasData &&
                                            snapshot.data != null) {
                                          return Text(snapshot.data!,
                                              style: infoStyle); // Display data
                                        } else {
                                          return Text('N/A',
                                              style:
                                                  infoStyle); // Handle null or empty data
                                        }
                                      },
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              const Expanded(
                                  flex: 2, child: Text("Designation:")),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: FutureBuilder(
                                      future: ctr.getDesignationById(
                                          user.designation_id),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator()); // Placeholder for loading state
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else if (snapshot.hasData &&
                                            snapshot.data != null) {
                                          return Text(snapshot.data!,
                                              style: infoStyle); // Display data
                                        } else {
                                          return Text('N/A',
                                              style:
                                                  infoStyle); // Handle null or empty data
                                        }
                                      },
                                    )),
                              ),
                            ],
                          ),
                        ),

                        //nid
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              const Expanded(flex: 2, child: Text("NID:")),
                              Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text(
                                      user.nid_number ?? "NA",
                                      style: infoStyle,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              const Expanded(
                                  flex: 2, child: Text("Blood Group:")),
                              Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text(
                                      user.blood_group ?? "NA",
                                      style: infoStyle,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: [
                              const Expanded(
                                  flex: 2, child: Text("Date of Birth:")),
                              Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text(
                                      user.date_of_birth ?? "NA",
                                      style: infoStyle,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        //address
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: const Text("Present Address:")),
                              Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text(
                                      user.present_address ?? "NA",
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: infoStyle,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: const Text("Permanent Address:")),
                              Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text(
                                      user.permanent_address ?? "NA",
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: infoStyle,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
