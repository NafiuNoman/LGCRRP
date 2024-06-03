import 'package:floor/floor.dart';
import '../common_response.dart';
import '../response_model/scheme/scheme_setup_model.dart';

class SetupModel extends CommonResponse {
  List<DivisionEntity> divisions;
  List<DistrictEntity> districts;
  List<CityCorporationEntity> cityCorpPaurashavas;
  List<DesignationEntity> designations;
  List<GenderEntity> genders;
  List<BloodGroupEntity> bloodGroups;
  List<CommonLabelModel>? commonLabels;

  SetupModel(
      {required this.divisions,
      required this.districts,
      required this.cityCorpPaurashavas,
      required this.designations,
      required this.genders,
      required this.bloodGroups,
        this.commonLabels,
      required super.code,
      required super.message});

  factory SetupModel.fromJson(Map<String, dynamic> json) => SetupModel(
      code: json['code'],
      message: json['message'],
      divisions:
          List.from(json['divisions'].map((x) => DivisionEntity.fromJson(x))),
      districts:
          List.from(json['districts'].map((x) => DistrictEntity.fromJson(x))),
      cityCorpPaurashavas: List.from(json['cityCorpPaurashavas']
          .map((x) => CityCorporationEntity.fromJson(x))),
      designations: List.from(
          json['designations'].map((x) => DesignationEntity.fromJson(x))),
      genders: List.from(json['genders'].map((x) => GenderEntity.fromJson(x))),
      bloodGroups: List.from(
          json['bloodGroups'].map((x) => BloodGroupEntity.fromJson(x))),
    commonLabels: List.from(json['commonLabels'])
        .map((e) => CommonLabelModel.fromJson(e))
        .toList(),

  );
}

@Entity(tableName: 'division')
class DivisionEntity {
  @PrimaryKey()
  final int id;
  final String name_en;
  final String? name_bn;

  DivisionEntity({
    required this.id,
    required this.name_en,
     this.name_bn,
  });

  factory DivisionEntity.fromJson(Map<String, dynamic> json) => DivisionEntity(
      id: json['id'], name_en: json['name_en'], name_bn: json['name_bn']);
}

@Entity(tableName: "district")
class DistrictEntity {
  @primaryKey
  final int id;
  final int division_id;
  final String name_en;
  final String? name_bn;

  DistrictEntity(
      {required this.id,
      required this.division_id,
       this.name_bn,
      required this.name_en});

  factory DistrictEntity.fromJson(Map<String, dynamic> json) => DistrictEntity(
      id: json['id'],
      division_id: json['division_id'],
      name_bn: json["name_bn"],
      name_en: json["name_en"]);
}

@Entity(tableName: 'city_corporation')
class CityCorporationEntity {
  @primaryKey
  final int id;
  final int district_id;
  final String name_en;
  final String? name_bn;

  CityCorporationEntity(
      {required this.id,
      required this.district_id,
       this.name_bn,
      required this.name_en});

  factory CityCorporationEntity.fromJson(Map<String, dynamic> json) =>
      CityCorporationEntity(
          id: json['id'],
          district_id: json['district_id'],
          name_bn: json["name_bn"],
          name_en: json["name_en"]);
}

@Entity(tableName: "designation")
class DesignationEntity {
  @PrimaryKey()
  int id;
  String name_en;
  String? name_bn;

  DesignationEntity(
      {required this.id, required this.name_en,  this.name_bn});

  factory DesignationEntity.fromJson(Map<String, dynamic> json) =>
      DesignationEntity(
          id: json['id'], name_en: json['name_en'], name_bn: json['name_bn']);
}

@Entity(tableName: 'gender')
class GenderEntity {
  @primaryKey
  String id;
  String name_en;
  String? name_bn;

  GenderEntity(
      {required this.id, required this.name_en,  this.name_bn});

  factory GenderEntity.fromJson(Map<String, dynamic> json) => GenderEntity(
      id: json['id'], name_en: json['name_en'], name_bn: json['name_bn']);
}

@Entity(tableName: "blood")
class BloodGroupEntity {
  @primaryKey
  String id;
  String name_en;
  String? name_bn;

  BloodGroupEntity(
      {required this.id, required this.name_en,  this.name_bn});

  factory BloodGroupEntity.fromJson(Map<String, dynamic> json) =>
      BloodGroupEntity(
          id: json['id'], name_en: json['name_en'], name_bn: json['name_bn']);
}
