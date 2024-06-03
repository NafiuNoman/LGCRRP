import 'package:flutter/material.dart';
class MyContactBtn extends StatelessWidget {
  final Widget icon;
  final String label;
  final void Function() pressedFunction;

  const MyContactBtn({
    super.key,
    required this.icon,
    required this.label,
    required this.pressedFunction
  });

  @override
  Widget build(BuildContext context) {
    //TODO: Make entire column clickable
    return Column(children: [
      OutlinedButton(
          onPressed: pressedFunction,
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Color(0xFF3282B8)),
            fixedSize: MaterialStatePropertyAll(Size.fromRadius(35)),
            shape: MaterialStatePropertyAll(CircleBorder()),
          ),
          child:icon),
      Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w400),
      ),
    ]);
  }
}
