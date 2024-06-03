import 'package:flutter/material.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue.shade200,
      shadowColor: Colors.black12,
      iconTheme: const IconThemeData(color: Colors.white),
      title: const Text(
        "MIS, LGCRRP, LGED",
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 16),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50.0);
}
