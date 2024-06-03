import 'package:flutter/material.dart';

class MyCircleAvatar extends StatelessWidget {
  final String? imageUrl;
  final double? radius;

  const MyCircleAvatar({super.key, this.imageUrl,this.radius=90});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius:radius,
      backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
      child: imageUrl == null ? Icon(Icons.person,size: 90,) : null,
    );
  }
}
