class DashBoardDataModel {
  int totalSchemes;
  int totalUlgiForTotalScheme;
  int totalConcurredEstimatedAmount;
  int totalUlgiForTotalConcurredEstimatedAmount;
  int totalContractedAmount;
  int totalUlgiForContractedAmount;

  List<WorkTypeWiseSchemeModel> pieChartWorkTypeWiseSchemesContents;

  DashBoardDataModel({required this.totalSchemes,
    required this.totalUlgiForTotalScheme,
    required this.totalConcurredEstimatedAmount,
    required this.totalUlgiForTotalConcurredEstimatedAmount,
    required this.totalContractedAmount,
    required this.totalUlgiForContractedAmount,
    required this.pieChartWorkTypeWiseSchemesContents});

  factory DashBoardDataModel.fromJson(Map<String, dynamic>json)=>
      DashBoardDataModel(totalSchemes: json['totalSchemes'],
          totalUlgiForTotalScheme: json['totalUlgiForTotalScheme'],
          totalConcurredEstimatedAmount: json['totalConcurredEstimatedAmount'],
          totalUlgiForTotalConcurredEstimatedAmount: json['totalUlgiForTotalConcurredEstimatedAmount'],
          totalContractedAmount: json['totalContractedAmount'],
          totalUlgiForContractedAmount: json['totalUlgiForContractedAmount'],
          pieChartWorkTypeWiseSchemesContents: List.from(json['pieChartWorkTypeWiseSchemesContents']) );
}

class WorkTypeWiseSchemeModel {
  String workType;
  int value;

  WorkTypeWiseSchemeModel({required this.workType, required this.value});

  factory WorkTypeWiseSchemeModel.fromJson(Map<String, dynamic> json) =>
      WorkTypeWiseSchemeModel(workType: json['workType'], value: json['value']);
}
