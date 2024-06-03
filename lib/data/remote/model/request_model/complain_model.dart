class ComplainModel {
  final String division_id;
  final String district_id;
  final String organogram_id;
  final String site_office;
  final String complaint_type_id;
  final String complaint_title;
  final String complaint_explanation;
  final String complainant_name;
  final String complainant_email;
  final String complainant_phone;
  final String complainant_address;

  ComplainModel(
      {required this.division_id,
      required this.district_id,
      required this.organogram_id,
      required this.site_office,
      required this.complaint_type_id,
      required this.complaint_title,
      required this.complaint_explanation,
      required this.complainant_name,
      required this.complainant_email,
      required this.complainant_phone,
      required this.complainant_address});


  Map<String,String> toJson()
  {
    Map<String, String> map={
      'division_id':division_id,
      'district_id':district_id,
      'organogram_id':organogram_id,
      'site_office':site_office,
      'complaint_type_id':complaint_type_id,
      'complaint_title':complaint_title,
      'complaint_explanation':complaint_explanation,
      'complainant_name':complainant_name,
      'complainant_email':complainant_email,
      'complainant_phone':complainant_phone,
      'complainant_address':complainant_address,


    };

    return map;


  }

}
