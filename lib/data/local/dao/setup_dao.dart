import 'package:floor/floor.dart';
import 'package:com.lged.lgcrrp.misulgi/data/remote/model/response_model/scheme/scheme_list_model.dart';

import '../../remote/model/response_model/scheme/scheme_setup_model.dart';
import '../../remote/model/setup/setup_model.dart';

@dao
abstract class SetupDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertDivision(List<DivisionEntity> division);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertDesignation(List<DesignationEntity> designation);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertDistrict(List<DistrictEntity> district);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCityCorporation(
      List<CityCorporationEntity> cityCorporationEntity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertBloodGroup(List<BloodGroupEntity> bloodGroupEntity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertGender(List<GenderEntity> bloodGroupEntity);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertProgressStatus(List<ProgressStatusModel> progressStatus);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertSchemeStatus(List<SchemeStatusModel> schemeStatus);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertSchemeCategories(List<SchemeCategoryModel> schemeCategory);
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertSchemeSubCategories(List<SchemeSubCategoryModel> schemeSubCategory);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertSchemePackages(List<PackageModel> packages);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertComplaintType(ComplaintTypeModel model);

  @Query('SELECT * FROM package')
  Future<List<PackageModel>> getSchemePackages();

  @Query('SELECT * FROM scheme_category')
  Future<List<SchemeCategoryModel>> getSchemeCategories();

  @Query('SELECT name_en FROM scheme_category where id=:id')
  Future<String?> getSchemeCategoriesNameById(int id);

  @Query('SELECT * FROM scheme_sub_category')
  Future<List<SchemeSubCategoryModel>> getSchemeSubCategories();

  @Query('SELECT name_en FROM scheme_sub_category where id=:id')
  Future<String?> getSchemeSubCategoriesNameById(int id);

  @Query('SELECT * FROM scheme_status')
  Future<List<SchemeStatusModel>> getSchemeStatus();

  @Query('SELECT name_en from progress_status where id=:id')
  Future<String?> getProgressStatusById(int id);

  @Query('SELECT * FROM complaint_type')
  Future<List<ComplaintTypeModel>> getComplaintTypes();

  @Query('SELECT name_en FROM complaint_type where id=:id')
  Future<String?> getComplaintTypesNameById(int id);

  @Query('SELECT * FROM division')
  Future<List<DivisionEntity>> getDivisions();

  @Query('SELECT * FROM scheme')
  Future<List<Scheme>> getSchemes();

  @Query('SELECT * FROM district where division_id =:divisionId ')
  Future<List<DistrictEntity>> getDistrictsByDivisionId(int divisionId);

  @Query('SELECT * FROM district')
  Future<List<DistrictEntity>> getDistricts();

  @Query('SELECT * FROM city_corporation where district_id=:districtId')
  Future<List<CityCorporationEntity>> getCityCropsByDistrictId(int districtId);

  @Query('SELECT * FROM city_corporation')
  Future<List<CityCorporationEntity>> getCityCrops();

  @Query('SELECT * FROM blood')
  Future<List<BloodGroupEntity>> getBloodGroups();

  @Query('SELECT * FROM gender')
  Future<List<GenderEntity>> getGenders();

  @Query('SELECT * FROM designation')
  Future<List<DesignationEntity>> getDesignations();

  @Query('select name_en from designation where id=:id')
  Future<String?> getDesignationNameById(int id);

  @Query('select name_en from division where id=:id')
  Future<String?> getDivisionNameById(int id);

  @Query('select name_en from district where id=:id')
  Future<String?> getDistrictNameById(int id);

  @Query('select name_en from city_corporation where id=:id')
  Future<String?> getCityCorporationNameById(int id);

//DROP TABLE IF EXISTS student
  @Query('delete from contact')
  Future<void> dropContactTable();

  @Query('delete from division')
  Future<void> dropDivisionTable();

  @Query('delete from district')
  Future<void> dropDistrictTable();

  @Query('delete from city_corporation')
  Future<void> dropCityCorpsTable();

  @Query('delete from blood')
  Future<void> dropBloodTable();

  @Query('delete from gender')
  Future<void> dropGenderTable();

  @Query('delete from designation')
  Future<void> dropDesignationTable();
}
