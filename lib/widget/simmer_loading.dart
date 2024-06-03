import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class SimmerLoading extends StatelessWidget {
  const SimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100.0,
      child: ListView.builder(itemBuilder: (ct,i)=>
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: ListTile(
              leading: Container(
                height: 80,
                width: 80,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              title: Container(

                height: 20,
                width: 100,
                decoration: const BoxDecoration(shape: BoxShape.rectangle,color: Colors.green),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(

                  height: 20,
                  width: 100,
                  decoration: const BoxDecoration(shape: BoxShape.rectangle,color: Colors.green),
                ),
              ),
            ),
          ),

        itemCount: 6,),
    );
  }
}
