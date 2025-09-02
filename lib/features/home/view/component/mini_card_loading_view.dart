import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MiniCardLoadingView extends StatelessWidget {
  const MiniCardLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: SizedBox(
        height: 350,
        child: Skeletonizer(
          enabled: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              renderContainer(200, 250),
              const SizedBox(height: 4),
              renderContainer(24, 150),
              const SizedBox(height: 4),
              renderContainer(24, 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderContainer(double height, double width) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: height,
        width: width,
        color: Colors.grey,
      ),
    );
  }
}
