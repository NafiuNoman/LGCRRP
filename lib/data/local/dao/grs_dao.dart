import 'package:floor/floor.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/response_model/grs/complaint_list_model.dart';

@dao
abstract class GrsDao {

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertComplaints(List<ComplaintDetailsModel> complaints);

  @Query('select * from complaint where division_id=:divId and district_id=:disId and organogram_id=:cityId ')
  Future<List<ComplaintDetailsModel>> getComplaintListByDivIdDisIdCityId(int divId,  int disId,  int cityId);

  @Query('select * from complaint where division_id=:divId and district_id=:disId ')
  Future<List<ComplaintDetailsModel>> getComplaintListByDivIdDisId(int divId,  int disId);

  @Query('select * from complaint where division_id=:divId ')
  Future<List<ComplaintDetailsModel>> getComplaintListByDivId(int divId);

  @Query('select * from complaint')
  Future<List<ComplaintDetailsModel>> getComplaintList();

}
