import 'package:com.lged.lgcrrp.misulgi/data/remote/model/common_response.dart';
import 'package:floor/floor.dart';

class SchemeSetupData extends CommonResponse {
  List<ProgressStatusModel>? schemeApprovalStatus;
  List<SchemeStatusModel>? schemeStatus;
  List<CommonLabelModel>? commonLabels;
  final List<PackageModel> packages;
  final List<SchemeCategoryModel> schemeSectors;
  final List<SchemeSubCategoryModel> schemeSubSectors;

  SchemeSetupData({
    required super.code,
    required super.message,
    this.schemeApprovalStatus,
    this.schemeStatus,
    this.commonLabels,
    required this.packages,
    required this.schemeSectors,
    required this.schemeSubSectors,
  });

  factory SchemeSetupData.fromJson(Map<String, dynamic> json) =>
      SchemeSetupData(
        code: json['code'],
        message: json['message'],
        schemeApprovalStatus: List.from(json['schemeApprovalStatus'])
            .map((e) => ProgressStatusModel.fromJson(e))
            .toList(),
        schemeStatus: List.from(json['schemeStatus'])
            .map((e) => SchemeStatusModel.fromJson(e))
            .toList(),
        commonLabels: List.from(json['commonLabels'])
            .map((e) => CommonLabelModel.fromJson(e))
            .toList(),
        packages: List.from(json['packages'])
            .map((e) => PackageModel.fromJson(e))
            .toList(),

        schemeSectors: List.from(json['schemeSectors'])
            .map((e) => SchemeCategoryModel.fromJson(e))
            .toList(),
        schemeSubSectors: List.from(json['schemeSubSectors'])
            .map((e) => SchemeSubCategoryModel.fromJson(e))
            .toList(),
      );
}

class CommonLabelModel {
  final int id;
  final String data_type;
  final String name_en;

  CommonLabelModel(
      {required this.id, required this.data_type, required this.name_en});

  factory CommonLabelModel.fromJson(Map<String, dynamic> json) =>
      CommonLabelModel(
          id: json['id'],
          data_type: json['data_type'],
          name_en: json['name_en']);
}

@Entity(tableName: 'complaint_type')
class ComplaintTypeModel {
  @primaryKey
  final int id;
  final String data_type;
  final String name_en;

  ComplaintTypeModel(
      {required this.id, required this.data_type, required this.name_en});

  factory ComplaintTypeModel.fromJson(Map<String, dynamic> json) =>
      ComplaintTypeModel(
          id: json['id'],
          data_type: json['data_type'],
          name_en: json['name_en']);
}

@Entity(tableName: "progress_status")
class ProgressStatusModel {
  @primaryKey
  int id;
  String? name_en;
  String? name_bn;

  ProgressStatusModel({required this.id, this.name_en, this.name_bn});

  factory ProgressStatusModel.fromJson(Map<String, dynamic> json) =>
      ProgressStatusModel(
          id: json['id'], name_bn: json['name_bn'], name_en: json['name_en']);
}

@Entity(tableName: 'scheme_status')
class SchemeStatusModel {
  @primaryKey
  int id;
  String? name_en;
  String? name_bn;

  SchemeStatusModel({required this.id, this.name_en, this.name_bn});

  factory SchemeStatusModel.fromJson(Map<String, dynamic> json) =>
      SchemeStatusModel(
          id: json['id'], name_bn: json['name_bn'], name_en: json['name_en']);
}
@Entity(tableName: 'package')
class PackageModel {
  @primaryKey
  final int id;
  final String name_en;

  PackageModel({required this.id, required this.name_en});

  factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
        id: json['id'],
        name_en: json['name_en'],
      );
}
@Entity(tableName: 'scheme_category')
class SchemeCategoryModel {
  @primaryKey
  final int id;
  final String name_en;

  SchemeCategoryModel({required this.id, required this.name_en});

  factory SchemeCategoryModel.fromJson(Map<String, dynamic> json) =>
      SchemeCategoryModel(
        id: json['id'],
        name_en: json['name_en'],
      );
}
@Entity(tableName: 'scheme_sub_category')
class SchemeSubCategoryModel {
  @primaryKey
  final int id;
  final int sector_id;
  final String name_en;

  SchemeSubCategoryModel({required this.id, required this.name_en,required this.sector_id});

  factory SchemeSubCategoryModel.fromJson(Map<String, dynamic> json) =>
      SchemeSubCategoryModel(
        id: json['id'],
        sector_id: json['sector_id'],
        name_en: json['name_en'],
      );
}
