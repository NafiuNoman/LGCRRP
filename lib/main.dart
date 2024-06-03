import 'package:com.lged.lgcrrp.misulgi/page/map/progress_map_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:com.lged.lgcrrp.misulgi/controller/init_ctr.dart' as di;
import 'package:com.lged.lgcrrp.misulgi/page/contact/contact_details_page.dart';
import 'package:com.lged.lgcrrp.misulgi/page/contact/contact_list_page.dart';
import 'package:com.lged.lgcrrp.misulgi/page/contact/profile_form_page.dart';
import 'package:com.lged.lgcrrp.misulgi/page/dash_board_page.dart';
import 'package:com.lged.lgcrrp.misulgi/page/grs/complaint_details_page.dart';
import 'package:com.lged.lgcrrp.misulgi/page/grs/complaint_form_page.dart';
import 'package:com.lged.lgcrrp.misulgi/page/contact/login_reg_page.dart';
import 'package:com.lged.lgcrrp.misulgi/page/contact/otp_page.dart';
import 'package:com.lged.lgcrrp.misulgi/page/grs/complaint_list_page.dart';
import 'package:com.lged.lgcrrp.misulgi/page/map/scheme_map_page.dart';
import 'package:com.lged.lgcrrp.misulgi/page/map/progress_map_record_page.dart';
import 'package:com.lged.lgcrrp.misulgi/page/scheme/progress_details_page.dart';
import 'package:com.lged.lgcrrp.misulgi/page/scheme/scheme_details_page.dart';
import 'package:com.lged.lgcrrp.misulgi/page/scheme/scheme_list_page.dart';
import 'package:com.lged.lgcrrp.misulgi/page/scheme/scheme_log_in.dart';
import 'package:com.lged.lgcrrp.misulgi/page/scheme/progress_form_page.dart';
import 'package:com.lged.lgcrrp.misulgi/page/splash_page.dart';
import 'package:com.lged.lgcrrp.misulgi/page/test/form_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Poppins',
        // textTheme:GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      //always put splashPage as lunch screen otherwise common controller will throw error
      home: SplashPage(),
      routes: {
        //Contact
        "/splashPage": (context) => SplashPage(),
        "/DashBoard": (context) => DashBoardPage(),
        "/ContactList": (context) => const ContactListPage(),
        "/contactDetails": (_) => ContactDetailsPage(),
        "/login_reg": (_) => LoginOrRegistrationPage(),
        "/otp_page": (_) => const OtpPage(),
        "/profileFormPage": (_) => ProfileFormPage(),
        //Scheme & Progress
        "/schemeLogIn": (_) => SchemeLogIn(),
        "/schemeListPage": (_) =>  const SchemeListPage(),
        "/schemeDetailsPage": (_) =>  const SchemeDetailsPage(initialTabIndex: 0,),
        "/schemeProgressAddPage": (_) => const ProgressFormPage(),//need to change the name to progress form page
        "/progressDetailsPage": (_) =>  const ProgressDetailsPage(),

        //Map
        "/proposedMapPage": (_) => const SchemeMapPage(),// initial map of scheme
        "/gpsPage": (_) =>  const ProgressMapRecordPage(), //progress map entry page
        "/progressMapViewPage": (_) =>  const ProgressMapViewPage(), //progress map entry page

        //GRS
        "/complaintFormPage":(_)=> ComplaintFormPage(),
        "/complaintListPage":(_)=> const ComplaintListPage(),
        "/complaintDetailsPage":(_)=> const ComplaintDetailsPage(),
        //TEST
        "/testFormPage": (_) => const TestFormPage(),
        "/placeholder": (_) => const Placeholder(),

      },
      builder: EasyLoading.init(),
    );
  }
}
