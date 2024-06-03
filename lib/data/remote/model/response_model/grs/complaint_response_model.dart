import 'dart:convert';

import 'package:com.lged.lgcrrp.misulgi/data/remote/model/common_response.dart';

class ComplaintResponseModel extends CommonResponse {
  int? id;
  String? tracking_number;

  ComplaintResponseModel(
      {required super.code, required super.message, this.id,this.tracking_number});

  factory ComplaintResponseModel.fromJson(Map<String, dynamic> json) =>
      ComplaintResponseModel(
          code: json['code'], message: json['message'], id: json['id'],tracking_number: json['tracking_number']);
}
