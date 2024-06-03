import 'package:floor/floor.dart';

@DatabaseView(
    'select p.selfId, p.id, p.scheme_id, s.scheme_name,p.physical_progress,p.financial_progress,p.monthName,p.dayOfMonth, p.year , p.total_labor_cost_paid , p.male_labor_number_reported, p.female_labor_number_reported, ps.name_en from scheme_progress as p inner join progress_status as ps on p.status=ps.id inner join scheme as s on s.id=p.scheme_id ')
class ProgressAndStatusJoinModel {
  int selfId;
  int? id;
  int? scheme_id;
  String scheme_name;
  String? physical_progress;
  String? financial_progress;
  int? male_labor_number_reported;
  int? female_labor_number_reported;
  int? scheme_status;
  String? monthName;
  String? dayOfMonth;
  String? name_en;
  String? year;
  String? total_labor_cost_paid;


  ProgressAndStatusJoinModel({required this.selfId,
    this.id,
    this.scheme_id,
    required this.scheme_name,
    this.financial_progress,
    this.physical_progress,
    this.monthName,
    this.dayOfMonth,
    this.male_labor_number_reported,
    this.female_labor_number_reported,
    required this.scheme_status,
    this.name_en,
    this.year,
  this.total_labor_cost_paid});
}
