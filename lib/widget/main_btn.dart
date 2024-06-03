import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainBtn extends StatelessWidget {
  final textColor = const Color(0xff141414);
  final String title;
  final String subtitle;
  final String svgPath;
  final String? pageName;
  final void Function()? onTap;

  const MainBtn(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.svgPath,
      this.pageName = "/placeholder",
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: 154,
      height: 151,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 4.0,
              offset: Offset(3, 4),
              color: Colors.black12,
            ),
          ]),
      child: InkWell(
        splashColor: Colors.blue.shade100,
        onTap: onTap ??
                () {
              Navigator.pushNamed(context, pageName!);
            },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(svgPath),
              Text(
                title,
                style: TextStyle(
                    fontSize: 14,
                    color: textColor,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              Text(
                subtitle,
                style: TextStyle(
                    fontSize: 11,
                    color: textColor,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
