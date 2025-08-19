import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CampingDetailLoadingScreen extends StatelessWidget {
  const CampingDetailLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Skeletonizer(
      enabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Image
          renderContainer(
            width: width,
            height: 300,
            margin: EdgeInsets.zero,
          ),

          /// Title
          renderContainer(width: width / 3 * 2),

          /// Region
          renderContainer(width: width / 2),

          ///  ETC...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              renderContainer(width: width / 4),
              renderContainer(width: width / 4),
            ],
          ),
        ],
      ),
    );
  }

  renderContainer({
    required double width,
    double? height,
    EdgeInsets? margin,
  }) {
    return Container(
      margin:
          margin ?? EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      height: height ?? 32,
      width: width,
      color: Colors.grey,
    );
  }
}
