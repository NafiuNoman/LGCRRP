import 'package:floor/floor.dart';

import '../../model/scheme_progress_model.dart';
import '../../remote/model/response_model/scheme/login_response_model.dart';
import '../../remote/model/response_model/scheme/scheme_list_model.dart';
import '../entity/join_entity/progress_and_status.dart';

@dao
abstract class SchemeDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertScheme(Scheme scheme);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertSchemeLoggedInUserDetails(SchemeLogInResModel userModel);

  @Query('select * from scheme_user_login')
  Future<SchemeLogInResModel?> getSchemeUserInfo();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertSchemeProgress(List<SchemeProgress> progress);

  @insert
  Future<int> saveSchemeProgress(SchemeProgress progress);

  @Query('Update scheme_progress SET id=:serverId WHERE selfId=:selfId')
  Future<int?> updateProgressWithServerId(int serverId, int selfId);

  @Query('select * from ProgressAndStatusJoinModel where scheme_id=:id order by id desc')
  Future<List<ProgressAndStatusJoinModel>?> getListOfProgressWithStatus(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertProposedSchemeLine(MyLatLng myLatLng);

  @Query('select count(*) from scheme')
  Future<int?> countSchemeList();

  @Query('select division_id from scheme where id=:id')
  Future<int?> getDivisionIdBySchemeId(int id);

  @Query('select district_id from scheme where id=:id')
  Future<int?> getDistrictIdBySchemeId(int id);

  @Query('select organogram_id from scheme where id=:id')
  Future<int?> getCityCropsBySchemeId(int id);

  @Query('select * from scheme order by id desc ')
  Future<List<Scheme>> getSchemeList();

  @Query('select * from scheme where division_id=:divId order by id desc ')
  Future<List<Scheme>> getSchemeListByDivId(int divId);

  @Query('select * from scheme where division_id=:divId and district_id=:disId order by id desc ')
  Future<List<Scheme>> getSchemeListByDivIdDisId(int divId,  int disId);

  @Query('select * from scheme where division_id=:divId and district_id=:disId and organogram_id=:cityId order by id desc ')
  Future<List<Scheme>> getSchemeListByDivIdDisIdCityId(int divId,  int disId,  int cityId);

  @Query('select * from proposed_poly_line where schemeId=:id')
  Future<List<MyLatLng>?> getSchemeProposedLineById(int id);

  @Query('select * from scheme where id=:id')
  Future<Scheme?> getSchemeById(int id);

  @Query('select * from scheme_progress where id=:id')
  Future<SchemeProgress?> getProgressById(int id);

  @Query('select * from progress_image where scheme_progress_id=:id')
  Future<List<ProgressImageModel>?> getProgressImagesById(int id);

  @Query('select * from progress_lat_lng where schemeId=:schemeId and progressId=:progressId')
  Future<List<ProgressLatLngModel>?> getProgressLatLong(int schemeId,int progressId);

  @Query('delete from scheme')
  Future<void> dropSchemeTable();

  @Query('delete from scheme_progress')
  Future<void> dropSchemeProgressTable();

  @Query('delete from progress_lat_lng')
  Future<void> clearProgressLtLngTable();

  @Query('delete from progress_image')
  Future<void> clearProgressImageTable();

  @insert
  Future<void> insertProgressLatLngList(List<ProgressLatLngModel> model);

  @insert
  Future<void> insertProgressImageList(List<ProgressImageModel> model);

  @insert
  Future<void> insertProgressLatLng(ProgressLatLngModel model);
}
