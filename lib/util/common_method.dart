import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:url_launcher/url_launcher.dart";

Future<void> intentApp(BuildContext context, Uri url) async {

  if (await canLaunchUrl(url)) {
    launchUrl(url);
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("App is not installed")));
  }
}

Text myLabel(String label,) {
  return Text.rich(
      TextSpan(text: label, style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Color(0xff121826)), children: const [
    TextSpan(
      text: '*',
      style: TextStyle(color: Colors.red, fontSize: 11),
    ),
  ]));
}


// for progress list date view
Map<String, String> makeRepresentableDate(String reportingDate) {
  DateFormat format = DateFormat("dd-MM-yyyy");
  DateTime dateTime = format.parse(reportingDate);

  String monthName = DateFormat('MMM').format(dateTime);

  Map<String, String> map = {
    'month': monthName,
    'year': dateTime.year.toString(),
    'dayOfMonth': dateTime.day.toString()
  };

  return map;
}

String dateFormatForView(String reportingDate) {

  if(reportingDate!="N/A")
    {
      DateFormat format = DateFormat("yyyy-MM-dd");
      DateTime dateTime = format.parse(reportingDate);

      String monthName = DateFormat('MMM').format(dateTime);

      return '${dateTime.day.toString()}-$monthName-${dateTime.year.toString()}';
    }
  else
    {
      return "N/A";
    }


}

String makeDateForFormView(DateTime dateTime) {
  String monthName = DateFormat('MMM').format(dateTime);

  return '${dateTime.day.toString()}-$monthName-${dateTime.year.toString()}';
}


