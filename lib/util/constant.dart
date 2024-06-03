const String schemeUserId = 'scheme_user_id';
const String schemeUserLevel = 'scheme_user_level';
const String schemeDivisionId = 'scheme_division_id';
const String schemeDistrictId = 'scheme_district_id';
const String schemeOrganogramId = 'scheme_organogram_id';
const String selectedSchemeId = 'selectedSchemeId';
const String selectedProgressId = 'selectedProgressId';
const String contactId = 'id';

enum UserLevel {
  pmu('pmu'),
  dv('dv'),
  dc('dc'),
  rsmu('rsmu'),
  ulgi('ulgi');

  final String value;

  const UserLevel(this.value);
}

enum SchemeStatusEnum {
  inProgress(name: 'Tender in Progress', val: "1"),
  running(name: 'Work in Progress', val: "2"),
  done(name: 'Work Completed', val: "3"),
  hold(name: 'Work on Hold', val: "4"),
  notApplicable(name: 'Not Applicable', val: "5");

  final String name;
  final String val;

  const SchemeStatusEnum({required this.name, required this.val});

 static String getName(String val) {
    String name;

    if (val == SchemeStatusEnum.inProgress.val) {
      name = SchemeStatusEnum.inProgress.name;
    } else if (val == SchemeStatusEnum.running.val) {
      name = SchemeStatusEnum.running.name;
    } else if (val == SchemeStatusEnum.done.val) {
      name = SchemeStatusEnum.done.name;
    } else if (val == SchemeStatusEnum.hold.val) {
      name = SchemeStatusEnum.hold.name;
    } else if (val == SchemeStatusEnum.notApplicable.val) {
      name = SchemeStatusEnum.notApplicable.name;
    } else {
      name = "N/A";
    }

    return name;
  }
}

class Result {




}
