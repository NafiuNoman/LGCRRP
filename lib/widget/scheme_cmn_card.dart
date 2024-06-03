import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../page/scheme/scheme_details_page.dart';
import '../util/constant.dart';

class SchemeCmnCard extends StatelessWidget {
  String? workTypeEn;
  String? schemeTypeEn;
  String? packageNameEn;
  String schemeName;
  String schemeStatus;
  int numberOfMaleBeficiary;
  int numberOfFemaleBeficiary;
  String concurredEstimatedAmount;

  SchemeCmnCard(
      {super.key,
      this.workTypeEn,
      this.schemeTypeEn,
      required this.schemeName,
      required this.schemeStatus,
      this.packageNameEn,
      required this.numberOfMaleBeficiary,
      required this.numberOfFemaleBeficiary,
      required this.concurredEstimatedAmount});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      title: const Text('Scheme'),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              Text(
                '${workTypeEn ?? ""}: ',
                style: TextStyle(
                    color: headerTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 11),
              ),
              Text(schemeTypeEn ?? ' ',
                  style: TextStyle(
                      color: headerTextColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 11)),
            ],
          ),
        ),
        const Gap(18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            schemeName,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xff333333),
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
        const Gap(18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Package",
                      style: TextStyle(
                          color: headerTextColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(packageNameEn ?? 'N/A',
                        maxLines: 1,
                        style: const TextStyle(
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w400,
                            fontSize: 11)),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Status",
                    style: TextStyle(
                        color: headerTextColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: const Color(0xff407BFF)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 3),
                      child: Text(SchemeStatusEnum.getName(schemeStatus),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 8)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Gap(18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Concurred Estimated Amount",
                      style: TextStyle(
                          color: headerTextColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(concurredEstimatedAmount,
                        maxLines: 1,
                        style: const TextStyle(
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w400,
                            fontSize: 11)),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Beneficiaries",
                    style: TextStyle(
                        color: headerTextColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.man,
                        size: 14,
                      ),
                      Text(
                        numberOfMaleBeficiary.toString(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      ),
                      const Icon(
                        Icons.woman,
                        size: 14,
                      ),
                      Text(
                        numberOfFemaleBeficiary.toString(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const Gap(18),
      ],
    );
  }
}
