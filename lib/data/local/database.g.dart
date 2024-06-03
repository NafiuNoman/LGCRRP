// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  SetupDao? _setupDaoInstance;

  ContactDao? _contactDaoInstance;

  SchemeDao? _schemeDaoInstance;

  GrsDao? _grsDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `division` (`id` INTEGER NOT NULL, `name_en` TEXT NOT NULL, `name_bn` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `district` (`id` INTEGER NOT NULL, `division_id` INTEGER NOT NULL, `name_en` TEXT NOT NULL, `name_bn` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `city_corporation` (`id` INTEGER NOT NULL, `district_id` INTEGER NOT NULL, `name_en` TEXT NOT NULL, `name_bn` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `designation` (`id` INTEGER NOT NULL, `name_en` TEXT NOT NULL, `name_bn` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `blood` (`id` TEXT NOT NULL, `name_en` TEXT NOT NULL, `name_bn` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `gender` (`id` TEXT NOT NULL, `name_en` TEXT NOT NULL, `name_bn` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `contact` (`id` INTEGER NOT NULL, `division_id` INTEGER NOT NULL, `district_id` INTEGER NOT NULL, `organogram_id` INTEGER NOT NULL, `designation_id` INTEGER, `name_en` TEXT NOT NULL, `name_bn` TEXT, `email` TEXT NOT NULL, `mobile_number` TEXT NOT NULL, `whats_app_number` TEXT, `division_name_en` TEXT, `district_name_en` TEXT, `organogram_name_en` TEXT, `blood_group` TEXT, `gender` TEXT, `date_of_birth` TEXT, `present_address` TEXT, `permanent_address` TEXT, `nid_number` TEXT, `profile_image` TEXT, `profile_image_url` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `complaint_type` (`id` INTEGER NOT NULL, `data_type` TEXT NOT NULL, `name_en` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `complaint` (`id` INTEGER NOT NULL, `tracking_number` TEXT NOT NULL, `complaint_submit_date` TEXT NOT NULL, `division_id` INTEGER NOT NULL, `district_id` INTEGER NOT NULL, `organogram_id` INTEGER NOT NULL, `site_office` TEXT NOT NULL, `complaint_type_id` INTEGER NOT NULL, `complaint_title` TEXT NOT NULL, `complaint_explanation` TEXT NOT NULL, `complainant_name` TEXT, `complainant_email` TEXT, `complainant_phone` TEXT, `complainant_address` TEXT, `submission_media` TEXT NOT NULL, `complaint_status` TEXT NOT NULL, `division_name_en` TEXT NOT NULL, `districts_name_en` TEXT NOT NULL, `organogram_name_en` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `scheme` (`id` INTEGER NOT NULL, `division_id` INTEGER NOT NULL, `district_id` INTEGER NOT NULL, `upazila_id` INTEGER, `is_lipw` INTEGER NOT NULL, `organogram_id` INTEGER, `scheme_name` TEXT NOT NULL, `scheme_status` TEXT NOT NULL, `scheme_type_name_en` TEXT, `scheme_type_name_bn` TEXT, `scheme_work_type_en` TEXT, `scheme_work_type_bn` TEXT, `package_name_en` TEXT, `package_name_bn` TEXT, `concurred_estimated_amount` TEXT NOT NULL, `contractor_name` TEXT NOT NULL, `contracted_amount` TEXT NOT NULL, `reporting_date` TEXT NOT NULL, `date_of_agreement` TEXT NOT NULL, `date_of_commencement` TEXT NOT NULL, `date_commencement_of_work_planned` TEXT NOT NULL, `date_conceptual_proposal_submitted_to_pmu` TEXT NOT NULL, `date_final_proposal_submitted_to_pmu` TEXT NOT NULL, `date_proposal_approved_for_preparation_of_bid` TEXT NOT NULL, `date_invitation_of_bid` TEXT NOT NULL, `date_award_of_contract` TEXT NOT NULL, `safeguard_related_issues` TEXT NOT NULL, `remarks` TEXT NOT NULL, `piller_name_en` TEXT NOT NULL, `is_climate_risk_incorporated` INTEGER NOT NULL, `has_safeguard_related_issues` INTEGER NOT NULL, `scheme_category_id` INTEGER, `scheme_sub_category_id` INTEGER, `date_of_planned_completion_date` TEXT NOT NULL, `date_of_actual_completion_date` TEXT NOT NULL, `number_of_male_beficiary` INTEGER NOT NULL, `number_of_female_beficiary` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `scheme_progress` (`selfId` INTEGER PRIMARY KEY AUTOINCREMENT, `id` INTEGER, `scheme_id` INTEGER NOT NULL, `division_id` INTEGER, `district_id` INTEGER, `upazila_id` INTEGER, `organogram_id` INTEGER, `reported_date` TEXT, `male_labor_number_reported` INTEGER, `female_labor_number_reported` INTEGER, `male_labor_days_reported` INTEGER, `female_labor_days_reported` INTEGER, `women_number_paid_employement` INTEGER, `physical_progress` TEXT, `financial_progress` TEXT, `amount_spent_in_bdt` TEXT, `total_labor_cost_paid` TEXT, `scheme_status` INTEGER, `status` INTEGER, `is_road_map` INTEGER, `monthName` TEXT, `dayOfMonth` TEXT, `year` TEXT, `remarks` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `progress_lat_lng` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `selfId` INTEGER NOT NULL, `lat` REAL NOT NULL, `lng` REAL NOT NULL, `schemeId` INTEGER NOT NULL, `progressId` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `progress_image` (`selfId` INTEGER PRIMARY KEY AUTOINCREMENT, `scheme_id` INTEGER NOT NULL, `scheme_progress_id` INTEGER NOT NULL, `scheme_progress_image_url` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `progress_status` (`id` INTEGER NOT NULL, `name_en` TEXT, `name_bn` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `scheme_status` (`id` INTEGER NOT NULL, `name_en` TEXT, `name_bn` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `scheme_sub_category` (`id` INTEGER NOT NULL, `sector_id` INTEGER NOT NULL, `name_en` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `scheme_category` (`id` INTEGER NOT NULL, `name_en` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `package` (`id` INTEGER NOT NULL, `name_en` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `scheme_user_login` (`api_token` TEXT NOT NULL, `user_id` INTEGER NOT NULL, `user_division_id` INTEGER NOT NULL, `user_district_id` INTEGER NOT NULL, `user_organogram_id` INTEGER NOT NULL, `user_level` TEXT, `user_name_en` TEXT, `username` TEXT, `code` INTEGER NOT NULL, `message` TEXT NOT NULL, PRIMARY KEY (`user_id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `proposed_poly_line` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `lat` TEXT NOT NULL, `lng` TEXT NOT NULL, `schemeId` INTEGER NOT NULL)');
        await database.execute(
            'CREATE UNIQUE INDEX `index_scheme_progress_id` ON `scheme_progress` (`id`)');
        await database.execute(
            'CREATE VIEW IF NOT EXISTS `ProgressAndStatusJoinModel` AS select p.selfId, p.id, p.scheme_id, s.scheme_name,p.physical_progress,p.financial_progress,p.monthName,p.dayOfMonth, p.year , p.total_labor_cost_paid , p.male_labor_number_reported, p.female_labor_number_reported, ps.name_en from scheme_progress as p inner join progress_status as ps on p.status=ps.id inner join scheme as s on s.id=p.scheme_id ');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  SetupDao get setupDao {
    return _setupDaoInstance ??= _$SetupDao(database, changeListener);
  }

  @override
  ContactDao get contactDao {
    return _contactDaoInstance ??= _$ContactDao(database, changeListener);
  }

  @override
  SchemeDao get schemeDao {
    return _schemeDaoInstance ??= _$SchemeDao(database, changeListener);
  }

  @override
  GrsDao get grsDao {
    return _grsDaoInstance ??= _$GrsDao(database, changeListener);
  }
}

class _$SetupDao extends SetupDao {
  _$SetupDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _divisionEntityInsertionAdapter = InsertionAdapter(
            database,
            'division',
            (DivisionEntity item) => <String, Object?>{
                  'id': item.id,
                  'name_en': item.name_en,
                  'name_bn': item.name_bn
                }),
        _designationEntityInsertionAdapter = InsertionAdapter(
            database,
            'designation',
            (DesignationEntity item) => <String, Object?>{
                  'id': item.id,
                  'name_en': item.name_en,
                  'name_bn': item.name_bn
                }),
        _districtEntityInsertionAdapter = InsertionAdapter(
            database,
            'district',
            (DistrictEntity item) => <String, Object?>{
                  'id': item.id,
                  'division_id': item.division_id,
                  'name_en': item.name_en,
                  'name_bn': item.name_bn
                }),
        _cityCorporationEntityInsertionAdapter = InsertionAdapter(
            database,
            'city_corporation',
            (CityCorporationEntity item) => <String, Object?>{
                  'id': item.id,
                  'district_id': item.district_id,
                  'name_en': item.name_en,
                  'name_bn': item.name_bn
                }),
        _bloodGroupEntityInsertionAdapter = InsertionAdapter(
            database,
            'blood',
            (BloodGroupEntity item) => <String, Object?>{
                  'id': item.id,
                  'name_en': item.name_en,
                  'name_bn': item.name_bn
                }),
        _genderEntityInsertionAdapter = InsertionAdapter(
            database,
            'gender',
            (GenderEntity item) => <String, Object?>{
                  'id': item.id,
                  'name_en': item.name_en,
                  'name_bn': item.name_bn
                }),
        _progressStatusModelInsertionAdapter = InsertionAdapter(
            database,
            'progress_status',
            (ProgressStatusModel item) => <String, Object?>{
                  'id': item.id,
                  'name_en': item.name_en,
                  'name_bn': item.name_bn
                }),
        _schemeStatusModelInsertionAdapter = InsertionAdapter(
            database,
            'scheme_status',
            (SchemeStatusModel item) => <String, Object?>{
                  'id': item.id,
                  'name_en': item.name_en,
                  'name_bn': item.name_bn
                }),
        _schemeCategoryModelInsertionAdapter = InsertionAdapter(
            database,
            'scheme_category',
            (SchemeCategoryModel item) =>
                <String, Object?>{'id': item.id, 'name_en': item.name_en}),
        _schemeSubCategoryModelInsertionAdapter = InsertionAdapter(
            database,
            'scheme_sub_category',
            (SchemeSubCategoryModel item) => <String, Object?>{
                  'id': item.id,
                  'sector_id': item.sector_id,
                  'name_en': item.name_en
                }),
        _packageModelInsertionAdapter = InsertionAdapter(
            database,
            'package',
            (PackageModel item) =>
                <String, Object?>{'id': item.id, 'name_en': item.name_en}),
        _complaintTypeModelInsertionAdapter = InsertionAdapter(
            database,
            'complaint_type',
            (ComplaintTypeModel item) => <String, Object?>{
                  'id': item.id,
                  'data_type': item.data_type,
                  'name_en': item.name_en
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DivisionEntity> _divisionEntityInsertionAdapter;

  final InsertionAdapter<DesignationEntity> _designationEntityInsertionAdapter;

  final InsertionAdapter<DistrictEntity> _districtEntityInsertionAdapter;

  final InsertionAdapter<CityCorporationEntity>
      _cityCorporationEntityInsertionAdapter;

  final InsertionAdapter<BloodGroupEntity> _bloodGroupEntityInsertionAdapter;

  final InsertionAdapter<GenderEntity> _genderEntityInsertionAdapter;

  final InsertionAdapter<ProgressStatusModel>
      _progressStatusModelInsertionAdapter;

  final InsertionAdapter<SchemeStatusModel> _schemeStatusModelInsertionAdapter;

  final InsertionAdapter<SchemeCategoryModel>
      _schemeCategoryModelInsertionAdapter;

  final InsertionAdapter<SchemeSubCategoryModel>
      _schemeSubCategoryModelInsertionAdapter;

  final InsertionAdapter<PackageModel> _packageModelInsertionAdapter;

  final InsertionAdapter<ComplaintTypeModel>
      _complaintTypeModelInsertionAdapter;

  @override
  Future<List<PackageModel>> getSchemePackages() async {
    return _queryAdapter.queryList('SELECT * FROM package',
        mapper: (Map<String, Object?> row) => PackageModel(
            id: row['id'] as int, name_en: row['name_en'] as String));
  }

  @override
  Future<List<SchemeCategoryModel>> getSchemeCategories() async {
    return _queryAdapter.queryList('SELECT * FROM scheme_category',
        mapper: (Map<String, Object?> row) => SchemeCategoryModel(
            id: row['id'] as int, name_en: row['name_en'] as String));
  }

  @override
  Future<String?> getSchemeCategoriesNameById(int id) async {
    return _queryAdapter.query(
        'SELECT name_en FROM scheme_category where id=?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [id]);
  }

  @override
  Future<List<SchemeSubCategoryModel>> getSchemeSubCategories() async {
    return _queryAdapter.queryList('SELECT * FROM scheme_sub_category',
        mapper: (Map<String, Object?> row) => SchemeSubCategoryModel(
            id: row['id'] as int,
            name_en: row['name_en'] as String,
            sector_id: row['sector_id'] as int));
  }

  @override
  Future<String?> getSchemeSubCategoriesNameById(int id) async {
    return _queryAdapter.query(
        'SELECT name_en FROM scheme_sub_category where id=?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [id]);
  }

  @override
  Future<List<SchemeStatusModel>> getSchemeStatus() async {
    return _queryAdapter.queryList('SELECT * FROM scheme_status',
        mapper: (Map<String, Object?> row) => SchemeStatusModel(
            id: row['id'] as int,
            name_en: row['name_en'] as String?,
            name_bn: row['name_bn'] as String?));
  }

  @override
  Future<String?> getProgressStatusById(int id) async {
    return _queryAdapter.query(
        'SELECT name_en from progress_status where id=?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [id]);
  }

  @override
  Future<List<ComplaintTypeModel>> getComplaintTypes() async {
    return _queryAdapter.queryList('SELECT * FROM complaint_type',
        mapper: (Map<String, Object?> row) => ComplaintTypeModel(
            id: row['id'] as int,
            data_type: row['data_type'] as String,
            name_en: row['name_en'] as String));
  }

  @override
  Future<String?> getComplaintTypesNameById(int id) async {
    return _queryAdapter.query('SELECT name_en FROM complaint_type where id=?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [id]);
  }

  @override
  Future<List<DivisionEntity>> getDivisions() async {
    return _queryAdapter.queryList('SELECT * FROM division',
        mapper: (Map<String, Object?> row) => DivisionEntity(
            id: row['id'] as int,
            name_en: row['name_en'] as String,
            name_bn: row['name_bn'] as String?));
  }

  @override
  Future<List<Scheme>> getSchemes() async {
    return _queryAdapter.queryList('SELECT * FROM scheme',
        mapper: (Map<String, Object?> row) => Scheme(
            id: row['id'] as int,
            division_id: row['division_id'] as int,
            district_id: row['district_id'] as int,
            upazila_id: row['upazila_id'] as int?,
            organogram_id: row['organogram_id'] as int?,
            is_lipw: row['is_lipw'] as int,
            scheme_name: row['scheme_name'] as String,
            scheme_status: row['scheme_status'] as String,
            scheme_type_name_en: row['scheme_type_name_en'] as String?,
            scheme_type_name_bn: row['scheme_type_name_bn'] as String?,
            scheme_work_type_en: row['scheme_work_type_en'] as String?,
            scheme_work_type_bn: row['scheme_work_type_bn'] as String?,
            package_name_en: row['package_name_en'] as String?,
            package_name_bn: row['package_name_bn'] as String?,
            concurred_estimated_amount:
                row['concurred_estimated_amount'] as String,
            contracted_amount: row['contracted_amount'] as String,
            contractor_name: row['contractor_name'] as String,
            number_of_female_beficiary:
                row['number_of_female_beficiary'] as int,
            number_of_male_beficiary: row['number_of_male_beficiary'] as int,
            reporting_date: row['reporting_date'] as String,
            date_of_agreement: row['date_of_agreement'] as String,
            date_of_commencement: row['date_of_commencement'] as String,
            date_of_planned_completion_date:
                row['date_of_planned_completion_date'] as String,
            date_of_actual_completion_date:
                row['date_of_actual_completion_date'] as String,
            date_commencement_of_work_planned:
                row['date_commencement_of_work_planned'] as String,
            date_conceptual_proposal_submitted_to_pmu:
                row['date_conceptual_proposal_submitted_to_pmu'] as String,
            date_final_proposal_submitted_to_pmu:
                row['date_final_proposal_submitted_to_pmu'] as String,
            date_proposal_approved_for_preparation_of_bid:
                row['date_proposal_approved_for_preparation_of_bid'] as String,
            date_invitation_of_bid: row['date_invitation_of_bid'] as String,
            date_award_of_contract: row['date_award_of_contract'] as String,
            safeguard_related_issues: row['safeguard_related_issues'] as String,
            remarks: row['remarks'] as String,
            is_climate_risk_incorporated:
                row['is_climate_risk_incorporated'] as int,
            has_safeguard_related_issues:
                row['has_safeguard_related_issues'] as int,
            scheme_category_id: row['scheme_category_id'] as int?,
            scheme_sub_category_id: row['scheme_sub_category_id'] as int?,
            piller_name_en: row['piller_name_en'] as String));
  }

  @override
  Future<List<DistrictEntity>> getDistrictsByDivisionId(int divisionId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM district where division_id =?1',
        mapper: (Map<String, Object?> row) => DistrictEntity(
            id: row['id'] as int,
            division_id: row['division_id'] as int,
            name_bn: row['name_bn'] as String?,
            name_en: row['name_en'] as String),
        arguments: [divisionId]);
  }

  @override
  Future<List<DistrictEntity>> getDistricts() async {
    return _queryAdapter.queryList('SELECT * FROM district',
        mapper: (Map<String, Object?> row) => DistrictEntity(
            id: row['id'] as int,
            division_id: row['division_id'] as int,
            name_bn: row['name_bn'] as String?,
            name_en: row['name_en'] as String));
  }

  @override
  Future<List<CityCorporationEntity>> getCityCropsByDistrictId(
      int districtId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM city_corporation where district_id=?1',
        mapper: (Map<String, Object?> row) => CityCorporationEntity(
            id: row['id'] as int,
            district_id: row['district_id'] as int,
            name_bn: row['name_bn'] as String?,
            name_en: row['name_en'] as String),
        arguments: [districtId]);
  }

  @override
  Future<List<CityCorporationEntity>> getCityCrops() async {
    return _queryAdapter.queryList('SELECT * FROM city_corporation',
        mapper: (Map<String, Object?> row) => CityCorporationEntity(
            id: row['id'] as int,
            district_id: row['district_id'] as int,
            name_bn: row['name_bn'] as String?,
            name_en: row['name_en'] as String));
  }

  @override
  Future<List<BloodGroupEntity>> getBloodGroups() async {
    return _queryAdapter.queryList('SELECT * FROM blood',
        mapper: (Map<String, Object?> row) => BloodGroupEntity(
            id: row['id'] as String,
            name_en: row['name_en'] as String,
            name_bn: row['name_bn'] as String?));
  }

  @override
  Future<List<GenderEntity>> getGenders() async {
    return _queryAdapter.queryList('SELECT * FROM gender',
        mapper: (Map<String, Object?> row) => GenderEntity(
            id: row['id'] as String,
            name_en: row['name_en'] as String,
            name_bn: row['name_bn'] as String?));
  }

  @override
  Future<List<DesignationEntity>> getDesignations() async {
    return _queryAdapter.queryList('SELECT * FROM designation',
        mapper: (Map<String, Object?> row) => DesignationEntity(
            id: row['id'] as int,
            name_en: row['name_en'] as String,
            name_bn: row['name_bn'] as String?));
  }

  @override
  Future<String?> getDesignationNameById(int id) async {
    return _queryAdapter.query('select name_en from designation where id=?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [id]);
  }

  @override
  Future<String?> getDivisionNameById(int id) async {
    return _queryAdapter.query('select name_en from division where id=?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [id]);
  }

  @override
  Future<String?> getDistrictNameById(int id) async {
    return _queryAdapter.query('select name_en from district where id=?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [id]);
  }

  @override
  Future<String?> getCityCorporationNameById(int id) async {
    return _queryAdapter.query(
        'select name_en from city_corporation where id=?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [id]);
  }

  @override
  Future<void> dropContactTable() async {
    await _queryAdapter.queryNoReturn('delete from contact');
  }

  @override
  Future<void> dropDivisionTable() async {
    await _queryAdapter.queryNoReturn('delete from division');
  }

  @override
  Future<void> dropDistrictTable() async {
    await _queryAdapter.queryNoReturn('delete from district');
  }

  @override
  Future<void> dropCityCorpsTable() async {
    await _queryAdapter.queryNoReturn('delete from city_corporation');
  }

  @override
  Future<void> dropBloodTable() async {
    await _queryAdapter.queryNoReturn('delete from blood');
  }

  @override
  Future<void> dropGenderTable() async {
    await _queryAdapter.queryNoReturn('delete from gender');
  }

  @override
  Future<void> dropDesignationTable() async {
    await _queryAdapter.queryNoReturn('delete from designation');
  }

  @override
  Future<void> insertDivision(List<DivisionEntity> division) async {
    await _divisionEntityInsertionAdapter.insertList(
        division, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertDesignation(List<DesignationEntity> designation) async {
    await _designationEntityInsertionAdapter.insertList(
        designation, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertDistrict(List<DistrictEntity> district) async {
    await _districtEntityInsertionAdapter.insertList(
        district, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertCityCorporation(
      List<CityCorporationEntity> cityCorporationEntity) async {
    await _cityCorporationEntityInsertionAdapter.insertList(
        cityCorporationEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertBloodGroup(List<BloodGroupEntity> bloodGroupEntity) async {
    await _bloodGroupEntityInsertionAdapter.insertList(
        bloodGroupEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertGender(List<GenderEntity> bloodGroupEntity) async {
    await _genderEntityInsertionAdapter.insertList(
        bloodGroupEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertProgressStatus(
      List<ProgressStatusModel> progressStatus) async {
    await _progressStatusModelInsertionAdapter.insertList(
        progressStatus, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertSchemeStatus(List<SchemeStatusModel> schemeStatus) async {
    await _schemeStatusModelInsertionAdapter.insertList(
        schemeStatus, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertSchemeCategories(
      List<SchemeCategoryModel> schemeCategory) async {
    await _schemeCategoryModelInsertionAdapter.insertList(
        schemeCategory, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertSchemeSubCategories(
      List<SchemeSubCategoryModel> schemeSubCategory) async {
    await _schemeSubCategoryModelInsertionAdapter.insertList(
        schemeSubCategory, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertSchemePackages(List<PackageModel> packages) async {
    await _packageModelInsertionAdapter.insertList(
        packages, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertComplaintType(ComplaintTypeModel model) async {
    await _complaintTypeModelInsertionAdapter.insert(
        model, OnConflictStrategy.replace);
  }
}

class _$ContactDao extends ContactDao {
  _$ContactDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _contactModelInsertionAdapter = InsertionAdapter(
            database,
            'contact',
            (ContactModel item) => <String, Object?>{
                  'id': item.id,
                  'division_id': item.division_id,
                  'district_id': item.district_id,
                  'organogram_id': item.organogram_id,
                  'designation_id': item.designation_id,
                  'name_en': item.name_en,
                  'name_bn': item.name_bn,
                  'email': item.email,
                  'mobile_number': item.mobile_number,
                  'whats_app_number': item.whats_app_number,
                  'division_name_en': item.division_name_en,
                  'district_name_en': item.district_name_en,
                  'organogram_name_en': item.organogram_name_en,
                  'blood_group': item.blood_group,
                  'gender': item.gender,
                  'date_of_birth': item.date_of_birth,
                  'present_address': item.present_address,
                  'permanent_address': item.permanent_address,
                  'nid_number': item.nid_number,
                  'profile_image': item.profile_image,
                  'profile_image_url': item.profile_image_url
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ContactModel> _contactModelInsertionAdapter;

  @override
  Future<ContactModel?> getAllContacts() async {
    return _queryAdapter.query('select * from contact',
        mapper: (Map<String, Object?> row) => ContactModel(
            id: row['id'] as int,
            division_id: row['division_id'] as int,
            organogram_id: row['organogram_id'] as int,
            district_id: row['district_id'] as int,
            designation_id: row['designation_id'] as int?,
            name_en: row['name_en'] as String,
            name_bn: row['name_bn'] as String?,
            email: row['email'] as String,
            mobile_number: row['mobile_number'] as String,
            whats_app_number: row['whats_app_number'] as String?,
            division_name_en: row['division_name_en'] as String?,
            district_name_en: row['district_name_en'] as String?,
            organogram_name_en: row['organogram_name_en'] as String?,
            blood_group: row['blood_group'] as String?,
            gender: row['gender'] as String?,
            date_of_birth: row['date_of_birth'] as String?,
            present_address: row['present_address'] as String?,
            permanent_address: row['permanent_address'] as String?,
            nid_number: row['nid_number'] as String?,
            profile_image: row['profile_image'] as String?,
            profile_image_url: row['profile_image_url'] as String?));
  }

  @override
  Future<void> clearContactTable() async {
    await _queryAdapter.queryNoReturn('delete from contact');
  }

  @override
  Future<void> insertContact(ContactModel contactEntity) async {
    await _contactModelInsertionAdapter.insert(
        contactEntity, OnConflictStrategy.replace);
  }
}

class _$SchemeDao extends SchemeDao {
  _$SchemeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _schemeInsertionAdapter = InsertionAdapter(
            database,
            'scheme',
            (Scheme item) => <String, Object?>{
                  'id': item.id,
                  'division_id': item.division_id,
                  'district_id': item.district_id,
                  'upazila_id': item.upazila_id,
                  'is_lipw': item.is_lipw,
                  'organogram_id': item.organogram_id,
                  'scheme_name': item.scheme_name,
                  'scheme_status': item.scheme_status,
                  'scheme_type_name_en': item.scheme_type_name_en,
                  'scheme_type_name_bn': item.scheme_type_name_bn,
                  'scheme_work_type_en': item.scheme_work_type_en,
                  'scheme_work_type_bn': item.scheme_work_type_bn,
                  'package_name_en': item.package_name_en,
                  'package_name_bn': item.package_name_bn,
                  'concurred_estimated_amount': item.concurred_estimated_amount,
                  'contractor_name': item.contractor_name,
                  'contracted_amount': item.contracted_amount,
                  'reporting_date': item.reporting_date,
                  'date_of_agreement': item.date_of_agreement,
                  'date_of_commencement': item.date_of_commencement,
                  'date_commencement_of_work_planned':
                      item.date_commencement_of_work_planned,
                  'date_conceptual_proposal_submitted_to_pmu':
                      item.date_conceptual_proposal_submitted_to_pmu,
                  'date_final_proposal_submitted_to_pmu':
                      item.date_final_proposal_submitted_to_pmu,
                  'date_proposal_approved_for_preparation_of_bid':
                      item.date_proposal_approved_for_preparation_of_bid,
                  'date_invitation_of_bid': item.date_invitation_of_bid,
                  'date_award_of_contract': item.date_award_of_contract,
                  'safeguard_related_issues': item.safeguard_related_issues,
                  'remarks': item.remarks,
                  'piller_name_en': item.piller_name_en,
                  'is_climate_risk_incorporated':
                      item.is_climate_risk_incorporated,
                  'has_safeguard_related_issues':
                      item.has_safeguard_related_issues,
                  'scheme_category_id': item.scheme_category_id,
                  'scheme_sub_category_id': item.scheme_sub_category_id,
                  'date_of_planned_completion_date':
                      item.date_of_planned_completion_date,
                  'date_of_actual_completion_date':
                      item.date_of_actual_completion_date,
                  'number_of_male_beficiary': item.number_of_male_beficiary,
                  'number_of_female_beficiary': item.number_of_female_beficiary
                }),
        _schemeLogInResModelInsertionAdapter = InsertionAdapter(
            database,
            'scheme_user_login',
            (SchemeLogInResModel item) => <String, Object?>{
                  'api_token': item.api_token,
                  'user_id': item.user_id,
                  'user_division_id': item.user_division_id,
                  'user_district_id': item.user_district_id,
                  'user_organogram_id': item.user_organogram_id,
                  'user_level': item.user_level,
                  'user_name_en': item.user_name_en,
                  'username': item.username,
                  'code': item.code,
                  'message': item.message
                }),
        _schemeProgressInsertionAdapter = InsertionAdapter(
            database,
            'scheme_progress',
            (SchemeProgress item) => <String, Object?>{
                  'selfId': item.selfId,
                  'id': item.id,
                  'scheme_id': item.scheme_id,
                  'division_id': item.division_id,
                  'district_id': item.district_id,
                  'upazila_id': item.upazila_id,
                  'organogram_id': item.organogram_id,
                  'reported_date': item.reported_date,
                  'male_labor_number_reported': item.male_labor_number_reported,
                  'female_labor_number_reported':
                      item.female_labor_number_reported,
                  'male_labor_days_reported': item.male_labor_days_reported,
                  'female_labor_days_reported': item.female_labor_days_reported,
                  'women_number_paid_employement':
                      item.women_number_paid_employement,
                  'physical_progress': item.physical_progress,
                  'financial_progress': item.financial_progress,
                  'amount_spent_in_bdt': item.amount_spent_in_bdt,
                  'total_labor_cost_paid': item.total_labor_cost_paid,
                  'scheme_status': item.scheme_status,
                  'status': item.status,
                  'is_road_map': item.is_road_map,
                  'monthName': item.monthName,
                  'dayOfMonth': item.dayOfMonth,
                  'year': item.year,
                  'remarks': item.remarks
                }),
        _myLatLngInsertionAdapter = InsertionAdapter(
            database,
            'proposed_poly_line',
            (MyLatLng item) => <String, Object?>{
                  'id': item.id,
                  'lat': item.lat,
                  'lng': item.lng,
                  'schemeId': item.schemeId
                }),
        _progressLatLngModelInsertionAdapter = InsertionAdapter(
            database,
            'progress_lat_lng',
            (ProgressLatLngModel item) => <String, Object?>{
                  'id': item.id,
                  'selfId': item.selfId,
                  'lat': item.lat,
                  'lng': item.lng,
                  'schemeId': item.schemeId,
                  'progressId': item.progressId
                }),
        _progressImageModelInsertionAdapter = InsertionAdapter(
            database,
            'progress_image',
            (ProgressImageModel item) => <String, Object?>{
                  'selfId': item.selfId,
                  'scheme_id': item.id,
                  'scheme_progress_id': item.scheme_progress_id,
                  'scheme_progress_image_url': item.scheme_progress_image_url
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Scheme> _schemeInsertionAdapter;

  final InsertionAdapter<SchemeLogInResModel>
      _schemeLogInResModelInsertionAdapter;

  final InsertionAdapter<SchemeProgress> _schemeProgressInsertionAdapter;

  final InsertionAdapter<MyLatLng> _myLatLngInsertionAdapter;

  final InsertionAdapter<ProgressLatLngModel>
      _progressLatLngModelInsertionAdapter;

  final InsertionAdapter<ProgressImageModel>
      _progressImageModelInsertionAdapter;

  @override
  Future<SchemeLogInResModel?> getSchemeUserInfo() async {
    return _queryAdapter.query('select * from scheme_user_login',
        mapper: (Map<String, Object?> row) => SchemeLogInResModel(
            code: row['code'] as int,
            message: row['message'] as String,
            user_id: row['user_id'] as int,
            api_token: row['api_token'] as String,
            user_division_id: row['user_division_id'] as int,
            user_district_id: row['user_district_id'] as int,
            user_organogram_id: row['user_organogram_id'] as int,
            user_level: row['user_level'] as String?,
            user_name_en: row['user_name_en'] as String?,
            username: row['username'] as String?));
  }

  @override
  Future<int?> updateProgressWithServerId(
    int serverId,
    int selfId,
  ) async {
    return _queryAdapter.query(
        'Update scheme_progress SET id=?1 WHERE selfId=?2',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [serverId, selfId]);
  }

  @override
  Future<List<ProgressAndStatusJoinModel>?> getListOfProgressWithStatus(
      int id) async {
    return _queryAdapter.queryList(
        'select * from ProgressAndStatusJoinModel where scheme_id=?1 order by id desc',
        mapper: (Map<String, Object?> row) => ProgressAndStatusJoinModel(selfId: row['selfId'] as int, id: row['id'] as int?, scheme_id: row['scheme_id'] as int?, scheme_name: row['scheme_name'] as String, financial_progress: row['financial_progress'] as String?, physical_progress: row['physical_progress'] as String?, monthName: row['monthName'] as String?, dayOfMonth: row['dayOfMonth'] as String?, male_labor_number_reported: row['male_labor_number_reported'] as int?, female_labor_number_reported: row['female_labor_number_reported'] as int?, scheme_status: row['scheme_status'] as int?, name_en: row['name_en'] as String?, year: row['year'] as String?, total_labor_cost_paid: row['total_labor_cost_paid'] as String?),
        arguments: [id]);
  }

  @override
  Future<int?> countSchemeList() async {
    return _queryAdapter.query('select count(*) from scheme',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<int?> getDivisionIdBySchemeId(int id) async {
    return _queryAdapter.query('select division_id from scheme where id=?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [id]);
  }

  @override
  Future<int?> getDistrictIdBySchemeId(int id) async {
    return _queryAdapter.query('select district_id from scheme where id=?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [id]);
  }

  @override
  Future<int?> getCityCropsBySchemeId(int id) async {
    return _queryAdapter.query('select organogram_id from scheme where id=?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [id]);
  }

  @override
  Future<List<Scheme>> getSchemeList() async {
    return _queryAdapter.queryList('select * from scheme order by id desc',
        mapper: (Map<String, Object?> row) => Scheme(
            id: row['id'] as int,
            division_id: row['division_id'] as int,
            district_id: row['district_id'] as int,
            upazila_id: row['upazila_id'] as int?,
            organogram_id: row['organogram_id'] as int?,
            is_lipw: row['is_lipw'] as int,
            scheme_name: row['scheme_name'] as String,
            scheme_status: row['scheme_status'] as String,
            scheme_type_name_en: row['scheme_type_name_en'] as String?,
            scheme_type_name_bn: row['scheme_type_name_bn'] as String?,
            scheme_work_type_en: row['scheme_work_type_en'] as String?,
            scheme_work_type_bn: row['scheme_work_type_bn'] as String?,
            package_name_en: row['package_name_en'] as String?,
            package_name_bn: row['package_name_bn'] as String?,
            concurred_estimated_amount:
                row['concurred_estimated_amount'] as String,
            contracted_amount: row['contracted_amount'] as String,
            contractor_name: row['contractor_name'] as String,
            number_of_female_beficiary:
                row['number_of_female_beficiary'] as int,
            number_of_male_beficiary: row['number_of_male_beficiary'] as int,
            reporting_date: row['reporting_date'] as String,
            date_of_agreement: row['date_of_agreement'] as String,
            date_of_commencement: row['date_of_commencement'] as String,
            date_of_planned_completion_date:
                row['date_of_planned_completion_date'] as String,
            date_of_actual_completion_date:
                row['date_of_actual_completion_date'] as String,
            date_commencement_of_work_planned:
                row['date_commencement_of_work_planned'] as String,
            date_conceptual_proposal_submitted_to_pmu:
                row['date_conceptual_proposal_submitted_to_pmu'] as String,
            date_final_proposal_submitted_to_pmu:
                row['date_final_proposal_submitted_to_pmu'] as String,
            date_proposal_approved_for_preparation_of_bid:
                row['date_proposal_approved_for_preparation_of_bid'] as String,
            date_invitation_of_bid: row['date_invitation_of_bid'] as String,
            date_award_of_contract: row['date_award_of_contract'] as String,
            safeguard_related_issues: row['safeguard_related_issues'] as String,
            remarks: row['remarks'] as String,
            is_climate_risk_incorporated:
                row['is_climate_risk_incorporated'] as int,
            has_safeguard_related_issues:
                row['has_safeguard_related_issues'] as int,
            scheme_category_id: row['scheme_category_id'] as int?,
            scheme_sub_category_id: row['scheme_sub_category_id'] as int?,
            piller_name_en: row['piller_name_en'] as String));
  }

  @override
  Future<List<Scheme>> getSchemeListByDivId(int divId) async {
    return _queryAdapter.queryList(
        'select * from scheme where division_id=?1 order by id desc',
        mapper: (Map<String, Object?> row) => Scheme(
            id: row['id'] as int,
            division_id: row['division_id'] as int,
            district_id: row['district_id'] as int,
            upazila_id: row['upazila_id'] as int?,
            organogram_id: row['organogram_id'] as int?,
            is_lipw: row['is_lipw'] as int,
            scheme_name: row['scheme_name'] as String,
            scheme_status: row['scheme_status'] as String,
            scheme_type_name_en: row['scheme_type_name_en'] as String?,
            scheme_type_name_bn: row['scheme_type_name_bn'] as String?,
            scheme_work_type_en: row['scheme_work_type_en'] as String?,
            scheme_work_type_bn: row['scheme_work_type_bn'] as String?,
            package_name_en: row['package_name_en'] as String?,
            package_name_bn: row['package_name_bn'] as String?,
            concurred_estimated_amount:
                row['concurred_estimated_amount'] as String,
            contracted_amount: row['contracted_amount'] as String,
            contractor_name: row['contractor_name'] as String,
            number_of_female_beficiary:
                row['number_of_female_beficiary'] as int,
            number_of_male_beficiary: row['number_of_male_beficiary'] as int,
            reporting_date: row['reporting_date'] as String,
            date_of_agreement: row['date_of_agreement'] as String,
            date_of_commencement: row['date_of_commencement'] as String,
            date_of_planned_completion_date:
                row['date_of_planned_completion_date'] as String,
            date_of_actual_completion_date:
                row['date_of_actual_completion_date'] as String,
            date_commencement_of_work_planned:
                row['date_commencement_of_work_planned'] as String,
            date_conceptual_proposal_submitted_to_pmu:
                row['date_conceptual_proposal_submitted_to_pmu'] as String,
            date_final_proposal_submitted_to_pmu:
                row['date_final_proposal_submitted_to_pmu'] as String,
            date_proposal_approved_for_preparation_of_bid:
                row['date_proposal_approved_for_preparation_of_bid'] as String,
            date_invitation_of_bid: row['date_invitation_of_bid'] as String,
            date_award_of_contract: row['date_award_of_contract'] as String,
            safeguard_related_issues: row['safeguard_related_issues'] as String,
            remarks: row['remarks'] as String,
            is_climate_risk_incorporated:
                row['is_climate_risk_incorporated'] as int,
            has_safeguard_related_issues:
                row['has_safeguard_related_issues'] as int,
            scheme_category_id: row['scheme_category_id'] as int?,
            scheme_sub_category_id: row['scheme_sub_category_id'] as int?,
            piller_name_en: row['piller_name_en'] as String),
        arguments: [divId]);
  }

  @override
  Future<List<Scheme>> getSchemeListByDivIdDisId(
    int divId,
    int disId,
  ) async {
    return _queryAdapter.queryList(
        'select * from scheme where division_id=?1 and district_id=?2 order by id desc',
        mapper: (Map<String, Object?> row) => Scheme(id: row['id'] as int, division_id: row['division_id'] as int, district_id: row['district_id'] as int, upazila_id: row['upazila_id'] as int?, organogram_id: row['organogram_id'] as int?, is_lipw: row['is_lipw'] as int, scheme_name: row['scheme_name'] as String, scheme_status: row['scheme_status'] as String, scheme_type_name_en: row['scheme_type_name_en'] as String?, scheme_type_name_bn: row['scheme_type_name_bn'] as String?, scheme_work_type_en: row['scheme_work_type_en'] as String?, scheme_work_type_bn: row['scheme_work_type_bn'] as String?, package_name_en: row['package_name_en'] as String?, package_name_bn: row['package_name_bn'] as String?, concurred_estimated_amount: row['concurred_estimated_amount'] as String, contracted_amount: row['contracted_amount'] as String, contractor_name: row['contractor_name'] as String, number_of_female_beficiary: row['number_of_female_beficiary'] as int, number_of_male_beficiary: row['number_of_male_beficiary'] as int, reporting_date: row['reporting_date'] as String, date_of_agreement: row['date_of_agreement'] as String, date_of_commencement: row['date_of_commencement'] as String, date_of_planned_completion_date: row['date_of_planned_completion_date'] as String, date_of_actual_completion_date: row['date_of_actual_completion_date'] as String, date_commencement_of_work_planned: row['date_commencement_of_work_planned'] as String, date_conceptual_proposal_submitted_to_pmu: row['date_conceptual_proposal_submitted_to_pmu'] as String, date_final_proposal_submitted_to_pmu: row['date_final_proposal_submitted_to_pmu'] as String, date_proposal_approved_for_preparation_of_bid: row['date_proposal_approved_for_preparation_of_bid'] as String, date_invitation_of_bid: row['date_invitation_of_bid'] as String, date_award_of_contract: row['date_award_of_contract'] as String, safeguard_related_issues: row['safeguard_related_issues'] as String, remarks: row['remarks'] as String, is_climate_risk_incorporated: row['is_climate_risk_incorporated'] as int, has_safeguard_related_issues: row['has_safeguard_related_issues'] as int, scheme_category_id: row['scheme_category_id'] as int?, scheme_sub_category_id: row['scheme_sub_category_id'] as int?, piller_name_en: row['piller_name_en'] as String),
        arguments: [divId, disId]);
  }

  @override
  Future<List<Scheme>> getSchemeListByDivIdDisIdCityId(
    int divId,
    int disId,
    int cityId,
  ) async {
    return _queryAdapter.queryList(
        'select * from scheme where division_id=?1 and district_id=?2 and organogram_id=?3 order by id desc',
        mapper: (Map<String, Object?> row) => Scheme(id: row['id'] as int, division_id: row['division_id'] as int, district_id: row['district_id'] as int, upazila_id: row['upazila_id'] as int?, organogram_id: row['organogram_id'] as int?, is_lipw: row['is_lipw'] as int, scheme_name: row['scheme_name'] as String, scheme_status: row['scheme_status'] as String, scheme_type_name_en: row['scheme_type_name_en'] as String?, scheme_type_name_bn: row['scheme_type_name_bn'] as String?, scheme_work_type_en: row['scheme_work_type_en'] as String?, scheme_work_type_bn: row['scheme_work_type_bn'] as String?, package_name_en: row['package_name_en'] as String?, package_name_bn: row['package_name_bn'] as String?, concurred_estimated_amount: row['concurred_estimated_amount'] as String, contracted_amount: row['contracted_amount'] as String, contractor_name: row['contractor_name'] as String, number_of_female_beficiary: row['number_of_female_beficiary'] as int, number_of_male_beficiary: row['number_of_male_beficiary'] as int, reporting_date: row['reporting_date'] as String, date_of_agreement: row['date_of_agreement'] as String, date_of_commencement: row['date_of_commencement'] as String, date_of_planned_completion_date: row['date_of_planned_completion_date'] as String, date_of_actual_completion_date: row['date_of_actual_completion_date'] as String, date_commencement_of_work_planned: row['date_commencement_of_work_planned'] as String, date_conceptual_proposal_submitted_to_pmu: row['date_conceptual_proposal_submitted_to_pmu'] as String, date_final_proposal_submitted_to_pmu: row['date_final_proposal_submitted_to_pmu'] as String, date_proposal_approved_for_preparation_of_bid: row['date_proposal_approved_for_preparation_of_bid'] as String, date_invitation_of_bid: row['date_invitation_of_bid'] as String, date_award_of_contract: row['date_award_of_contract'] as String, safeguard_related_issues: row['safeguard_related_issues'] as String, remarks: row['remarks'] as String, is_climate_risk_incorporated: row['is_climate_risk_incorporated'] as int, has_safeguard_related_issues: row['has_safeguard_related_issues'] as int, scheme_category_id: row['scheme_category_id'] as int?, scheme_sub_category_id: row['scheme_sub_category_id'] as int?, piller_name_en: row['piller_name_en'] as String),
        arguments: [divId, disId, cityId]);
  }

  @override
  Future<List<MyLatLng>?> getSchemeProposedLineById(int id) async {
    return _queryAdapter.queryList(
        'select * from proposed_poly_line where schemeId=?1',
        mapper: (Map<String, Object?> row) => MyLatLng(
            lat: row['lat'] as String,
            lng: row['lng'] as String,
            schemeId: row['schemeId'] as int),
        arguments: [id]);
  }

  @override
  Future<Scheme?> getSchemeById(int id) async {
    return _queryAdapter.query('select * from scheme where id=?1',
        mapper: (Map<String, Object?> row) => Scheme(
            id: row['id'] as int,
            division_id: row['division_id'] as int,
            district_id: row['district_id'] as int,
            upazila_id: row['upazila_id'] as int?,
            organogram_id: row['organogram_id'] as int?,
            is_lipw: row['is_lipw'] as int,
            scheme_name: row['scheme_name'] as String,
            scheme_status: row['scheme_status'] as String,
            scheme_type_name_en: row['scheme_type_name_en'] as String?,
            scheme_type_name_bn: row['scheme_type_name_bn'] as String?,
            scheme_work_type_en: row['scheme_work_type_en'] as String?,
            scheme_work_type_bn: row['scheme_work_type_bn'] as String?,
            package_name_en: row['package_name_en'] as String?,
            package_name_bn: row['package_name_bn'] as String?,
            concurred_estimated_amount:
                row['concurred_estimated_amount'] as String,
            contracted_amount: row['contracted_amount'] as String,
            contractor_name: row['contractor_name'] as String,
            number_of_female_beficiary:
                row['number_of_female_beficiary'] as int,
            number_of_male_beficiary: row['number_of_male_beficiary'] as int,
            reporting_date: row['reporting_date'] as String,
            date_of_agreement: row['date_of_agreement'] as String,
            date_of_commencement: row['date_of_commencement'] as String,
            date_of_planned_completion_date:
                row['date_of_planned_completion_date'] as String,
            date_of_actual_completion_date:
                row['date_of_actual_completion_date'] as String,
            date_commencement_of_work_planned:
                row['date_commencement_of_work_planned'] as String,
            date_conceptual_proposal_submitted_to_pmu:
                row['date_conceptual_proposal_submitted_to_pmu'] as String,
            date_final_proposal_submitted_to_pmu:
                row['date_final_proposal_submitted_to_pmu'] as String,
            date_proposal_approved_for_preparation_of_bid:
                row['date_proposal_approved_for_preparation_of_bid'] as String,
            date_invitation_of_bid: row['date_invitation_of_bid'] as String,
            date_award_of_contract: row['date_award_of_contract'] as String,
            safeguard_related_issues: row['safeguard_related_issues'] as String,
            remarks: row['remarks'] as String,
            is_climate_risk_incorporated:
                row['is_climate_risk_incorporated'] as int,
            has_safeguard_related_issues:
                row['has_safeguard_related_issues'] as int,
            scheme_category_id: row['scheme_category_id'] as int?,
            scheme_sub_category_id: row['scheme_sub_category_id'] as int?,
            piller_name_en: row['piller_name_en'] as String),
        arguments: [id]);
  }

  @override
  Future<SchemeProgress?> getProgressById(int id) async {
    return _queryAdapter.query('select * from scheme_progress where id=?1',
        mapper: (Map<String, Object?> row) => SchemeProgress(
            id: row['id'] as int?,
            scheme_id: row['scheme_id'] as int,
            division_id: row['division_id'] as int?,
            district_id: row['district_id'] as int?,
            upazila_id: row['upazila_id'] as int?,
            organogram_id: row['organogram_id'] as int?,
            reported_date: row['reported_date'] as String?,
            male_labor_number_reported:
                row['male_labor_number_reported'] as int?,
            female_labor_number_reported:
                row['female_labor_number_reported'] as int?,
            male_labor_days_reported: row['male_labor_days_reported'] as int?,
            female_labor_days_reported:
                row['female_labor_days_reported'] as int?,
            women_number_paid_employement:
                row['women_number_paid_employement'] as int?,
            physical_progress: row['physical_progress'] as String?,
            financial_progress: row['financial_progress'] as String?,
            amount_spent_in_bdt: row['amount_spent_in_bdt'] as String?,
            total_labor_cost_paid: row['total_labor_cost_paid'] as String?,
            is_road_map: row['is_road_map'] as int?,
            scheme_status: row['scheme_status'] as int?,
            status: row['status'] as int?,
            monthName: row['monthName'] as String?,
            dayOfMonth: row['dayOfMonth'] as String?,
            year: row['year'] as String?,
            remarks: row['remarks'] as String?),
        arguments: [id]);
  }

  @override
  Future<List<ProgressImageModel>?> getProgressImagesById(int id) async {
    return _queryAdapter.queryList(
        'select * from progress_image where scheme_progress_id=?1',
        mapper: (Map<String, Object?> row) => ProgressImageModel(
            id: row['scheme_id'] as int,
            selfId: row['selfId'] as int?,
            scheme_progress_id: row['scheme_progress_id'] as int,
            scheme_progress_image_url:
                row['scheme_progress_image_url'] as String),
        arguments: [id]);
  }

  @override
  Future<List<ProgressLatLngModel>?> getProgressLatLong(
    int schemeId,
    int progressId,
  ) async {
    return _queryAdapter.queryList(
        'select * from progress_lat_lng where schemeId=?1 and progressId=?2',
        mapper: (Map<String, Object?> row) => ProgressLatLngModel(
            selfId: row['selfId'] as int,
            lat: row['lat'] as double,
            lng: row['lng'] as double,
            schemeId: row['schemeId'] as int,
            progressId: row['progressId'] as int?),
        arguments: [schemeId, progressId]);
  }

  @override
  Future<void> dropSchemeTable() async {
    await _queryAdapter.queryNoReturn('delete from scheme');
  }

  @override
  Future<void> dropSchemeProgressTable() async {
    await _queryAdapter.queryNoReturn('delete from scheme_progress');
  }

  @override
  Future<void> clearProgressLtLngTable() async {
    await _queryAdapter.queryNoReturn('delete from progress_lat_lng');
  }

  @override
  Future<void> clearProgressImageTable() async {
    await _queryAdapter.queryNoReturn('delete from progress_image');
  }

  @override
  Future<void> insertScheme(Scheme scheme) async {
    await _schemeInsertionAdapter.insert(scheme, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertSchemeLoggedInUserDetails(
      SchemeLogInResModel userModel) async {
    await _schemeLogInResModelInsertionAdapter.insert(
        userModel, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertSchemeProgress(List<SchemeProgress> progress) async {
    await _schemeProgressInsertionAdapter.insertList(
        progress, OnConflictStrategy.replace);
  }

  @override
  Future<int> saveSchemeProgress(SchemeProgress progress) {
    return _schemeProgressInsertionAdapter.insertAndReturnId(
        progress, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertProposedSchemeLine(MyLatLng myLatLng) async {
    await _myLatLngInsertionAdapter.insert(
        myLatLng, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertProgressLatLngList(List<ProgressLatLngModel> model) async {
    await _progressLatLngModelInsertionAdapter.insertList(
        model, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertProgressImageList(List<ProgressImageModel> model) async {
    await _progressImageModelInsertionAdapter.insertList(
        model, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertProgressLatLng(ProgressLatLngModel model) async {
    await _progressLatLngModelInsertionAdapter.insert(
        model, OnConflictStrategy.abort);
  }
}

class _$GrsDao extends GrsDao {
  _$GrsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _complaintDetailsModelInsertionAdapter = InsertionAdapter(
            database,
            'complaint',
            (ComplaintDetailsModel item) => <String, Object?>{
                  'id': item.id,
                  'tracking_number': item.tracking_number,
                  'complaint_submit_date': item.complaint_submit_date,
                  'division_id': item.division_id,
                  'district_id': item.district_id,
                  'organogram_id': item.organogram_id,
                  'site_office': item.site_office,
                  'complaint_type_id': item.complaint_type_id,
                  'complaint_title': item.complaint_title,
                  'complaint_explanation': item.complaint_explanation,
                  'complainant_name': item.complainant_name,
                  'complainant_email': item.complainant_email,
                  'complainant_phone': item.complainant_phone,
                  'complainant_address': item.complainant_address,
                  'submission_media': item.submission_media,
                  'complaint_status': item.complaint_status,
                  'division_name_en': item.division_name_en,
                  'districts_name_en': item.districts_name_en,
                  'organogram_name_en': item.organogram_name_en
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ComplaintDetailsModel>
      _complaintDetailsModelInsertionAdapter;

  @override
  Future<List<ComplaintDetailsModel>> getComplaintListByDivIdDisIdCityId(
    int divId,
    int disId,
    int cityId,
  ) async {
    return _queryAdapter.queryList(
        'select * from complaint where division_id=?1 and district_id=?2 and organogram_id=?3',
        mapper: (Map<String, Object?> row) => ComplaintDetailsModel(id: row['id'] as int, tracking_number: row['tracking_number'] as String, complaint_submit_date: row['complaint_submit_date'] as String, division_id: row['division_id'] as int, district_id: row['district_id'] as int, organogram_id: row['organogram_id'] as int, site_office: row['site_office'] as String, complaint_type_id: row['complaint_type_id'] as int, complaint_title: row['complaint_title'] as String, complaint_explanation: row['complaint_explanation'] as String, submission_media: row['submission_media'] as String, complaint_status: row['complaint_status'] as String, complainant_name: row['complainant_name'] as String?, complainant_email: row['complainant_email'] as String?, complainant_phone: row['complainant_phone'] as String?, complainant_address: row['complainant_address'] as String?, division_name_en: row['division_name_en'] as String, districts_name_en: row['districts_name_en'] as String, organogram_name_en: row['organogram_name_en'] as String),
        arguments: [divId, disId, cityId]);
  }

  @override
  Future<List<ComplaintDetailsModel>> getComplaintListByDivIdDisId(
    int divId,
    int disId,
  ) async {
    return _queryAdapter.queryList(
        'select * from complaint where division_id=?1 and district_id=?2',
        mapper: (Map<String, Object?> row) => ComplaintDetailsModel(
            id: row['id'] as int,
            tracking_number: row['tracking_number'] as String,
            complaint_submit_date: row['complaint_submit_date'] as String,
            division_id: row['division_id'] as int,
            district_id: row['district_id'] as int,
            organogram_id: row['organogram_id'] as int,
            site_office: row['site_office'] as String,
            complaint_type_id: row['complaint_type_id'] as int,
            complaint_title: row['complaint_title'] as String,
            complaint_explanation: row['complaint_explanation'] as String,
            submission_media: row['submission_media'] as String,
            complaint_status: row['complaint_status'] as String,
            complainant_name: row['complainant_name'] as String?,
            complainant_email: row['complainant_email'] as String?,
            complainant_phone: row['complainant_phone'] as String?,
            complainant_address: row['complainant_address'] as String?,
            division_name_en: row['division_name_en'] as String,
            districts_name_en: row['districts_name_en'] as String,
            organogram_name_en: row['organogram_name_en'] as String),
        arguments: [divId, disId]);
  }

  @override
  Future<List<ComplaintDetailsModel>> getComplaintListByDivId(int divId) async {
    return _queryAdapter.queryList(
        'select * from complaint where division_id=?1',
        mapper: (Map<String, Object?> row) => ComplaintDetailsModel(
            id: row['id'] as int,
            tracking_number: row['tracking_number'] as String,
            complaint_submit_date: row['complaint_submit_date'] as String,
            division_id: row['division_id'] as int,
            district_id: row['district_id'] as int,
            organogram_id: row['organogram_id'] as int,
            site_office: row['site_office'] as String,
            complaint_type_id: row['complaint_type_id'] as int,
            complaint_title: row['complaint_title'] as String,
            complaint_explanation: row['complaint_explanation'] as String,
            submission_media: row['submission_media'] as String,
            complaint_status: row['complaint_status'] as String,
            complainant_name: row['complainant_name'] as String?,
            complainant_email: row['complainant_email'] as String?,
            complainant_phone: row['complainant_phone'] as String?,
            complainant_address: row['complainant_address'] as String?,
            division_name_en: row['division_name_en'] as String,
            districts_name_en: row['districts_name_en'] as String,
            organogram_name_en: row['organogram_name_en'] as String),
        arguments: [divId]);
  }

  @override
  Future<List<ComplaintDetailsModel>> getComplaintList() async {
    return _queryAdapter.queryList('select * from complaint',
        mapper: (Map<String, Object?> row) => ComplaintDetailsModel(
            id: row['id'] as int,
            tracking_number: row['tracking_number'] as String,
            complaint_submit_date: row['complaint_submit_date'] as String,
            division_id: row['division_id'] as int,
            district_id: row['district_id'] as int,
            organogram_id: row['organogram_id'] as int,
            site_office: row['site_office'] as String,
            complaint_type_id: row['complaint_type_id'] as int,
            complaint_title: row['complaint_title'] as String,
            complaint_explanation: row['complaint_explanation'] as String,
            submission_media: row['submission_media'] as String,
            complaint_status: row['complaint_status'] as String,
            complainant_name: row['complainant_name'] as String?,
            complainant_email: row['complainant_email'] as String?,
            complainant_phone: row['complainant_phone'] as String?,
            complainant_address: row['complainant_address'] as String?,
            division_name_en: row['division_name_en'] as String,
            districts_name_en: row['districts_name_en'] as String,
            organogram_name_en: row['organogram_name_en'] as String));
  }

  @override
  Future<void> insertComplaints(List<ComplaintDetailsModel> complaints) async {
    await _complaintDetailsModelInsertionAdapter.insertList(
        complaints, OnConflictStrategy.replace);
  }
}
