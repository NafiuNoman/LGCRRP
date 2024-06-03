import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:com.lged.lgcrrp.misulgi/page/test/test_controller.dart';
import 'package:pie_chart/pie_chart.dart';

class TestFormPage extends StatefulWidget {
  const TestFormPage({super.key});

  @override
  State<TestFormPage> createState() => _TestFormPageState();
}

class _TestFormPageState extends State<TestFormPage> {
  Map<String, double> dataMap = {
    "Completed": 1126,
    "Running": 1326,
    "Work On Hold": 0,
    "Tender In Progress": 2239,
  };

  Map<String, double> ringDataMap = {
    "Maintenance": 935,
    "Improvement": 1333,
    "New": 2423,
  };
  final ctr = Get.put(TestController());
  bool visible = true;
  bool isDone = false;
  List<File> selectedFile = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Expanded(
              child: PieChart(
                dataMap: dataMap,
                colorList: [
                  Colors.green,
                  Colors.blue.shade900,
                  Colors.deepOrange,
                  Colors.blue.shade200,
                ],
                chartValuesOptions: const ChartValuesOptions(
                  showChartValuesInPercentage: true,
                  decimalPlaces: 1,
                ),
                legendOptions: const LegendOptions(
                    legendPosition: LegendPosition.bottom,
                    showLegendsInRow: true),
              ),
            ),
            const Gap(30),
            Expanded(
              child: PieChart(
                dataMap: ringDataMap,
                chartType: ChartType.ring,
                ringStrokeWidth: 48,
                centerText: 'Total: ${4691}',
                colorList: [
                  Colors.green,
                  Colors.blue.shade900,
                  Colors.deepOrange,
                  Colors.blue.shade200,
                ],
                chartValuesOptions: const ChartValuesOptions(
                  showChartValuesOutside: true,
                  // showChartValuesInPercentage: true,
                  // decimalPlaces: 1,
                ),
                legendOptions: const LegendOptions(
                    legendPosition: LegendPosition.bottom,
                    showLegendsInRow: true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                  color: Colors.blue,
                  width: 1.5,
                )),
                width: MediaQuery.of(context).size.width,
                height: 120,
                child: Row(
                  children: [
                    Flexible(
                      child: Container(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.green),),
                      ),
                        decoration: BoxDecoration(
                            border:
                                Border(right: BorderSide(color: Colors.blue))),
                      ),
                      flex: 1,
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 4,
                      child: Container(

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Ahemd Nafiu Noman',overflow: TextOverflow.ellipsis,),
                              Text('Software Engineer',overflow: TextOverflow.ellipsis,),
                              Text('01516510222'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                            border:
                            Border(left: BorderSide(color: Colors.blue))), child: Icon(Icons.phone,color: Colors.blue,),                     ),
                      flex: 1,
                      fit: FlexFit.tight,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
