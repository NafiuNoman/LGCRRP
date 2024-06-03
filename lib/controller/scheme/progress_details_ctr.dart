import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:com.lged.lgcrrp.misulgi/util/constant.dart';

import '../../data/local/database.dart';
import '../../data/model/scheme_progress_model.dart';
import '../../data/remote/model/response_model/scheme/scheme_list_model.dart';

class ProgressDetailsViewCtr extends GetxController {
  bool isLoading = true;
  late AppDatabase _database;
  late SharedPreferences prefs;
  int schemeId = 0;
  Scheme? scheme;
  SchemeProgress? progress;
  List<ProgressImageModel>? images;
  String status = '';
  bool isDraft = false;

  @override
  void onReady() async {
    super.onReady();
    await _initDB();
    await loadSchemeAndProgressRelatedData();
  }

  Future<void> _initDB() async {
    _database = await AppDatabase.getInstance();
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> loadSchemeAndProgressRelatedData() async {
    schemeId = prefs.getInt(selectedSchemeId) ?? 0;
    int progressId = prefs.getInt(selectedProgressId) ?? 0;
    scheme = await _database.schemeDao.getSchemeById(schemeId);
    progress = await _database.schemeDao.getProgressById(progressId);

    if (progress!.status != null) {
      status =
          await _database.setupDao.getProgressStatusById(progress!.status!) ??
              "N/A";
      progress!.status == 1 ? isDraft = true : isDraft = false;
      //1=draft
    }
    images = await _database.schemeDao.getProgressImagesById(progressId);

    isLoading = false;

    update();
  }
}
