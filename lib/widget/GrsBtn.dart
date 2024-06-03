import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class GrsBtn extends StatelessWidget {
  final textColor = const Color(0xff141414);
  final String title;
  final String subtitle;
  final String? pageName;
  final void Function()? onTap;

  const GrsBtn(
      {super.key,
      required this.title,
      required this.subtitle,
      this.pageName = "/schemeProgressAddPage",
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 98,width: 130,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              Text(
                title,
                style: TextStyle(
                    fontSize: 13.98,
                    color: textColor,
                    fontWeight: FontWeight.w700),

              ),
              const Gap(10),
              Text(
                subtitle,
                style: TextStyle(
                    fontSize: 10.98,
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
