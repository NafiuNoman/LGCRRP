import 'package:flutter/material.dart';

class CommonStyle {


 static ButtonStyle elevatedBtnStyle = ButtonStyle(
      backgroundColor:
      const MaterialStatePropertyAll(Color(0xff0C356A)),
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0))));


 static TextStyle schemeTextStyle = const TextStyle(color: Colors.white);


}