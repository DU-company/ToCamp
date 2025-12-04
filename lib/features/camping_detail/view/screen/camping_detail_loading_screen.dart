import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:to_camp/core/theme/res/layout.dart';

class CampingDetailLoadingView extends StatelessWidget {
  const CampingDetailLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Skeletonizer(
      enabled: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Image
          SizedBox(
            height: 350,
            width: double.infinity,
            child: Bone.square(),
          ),
          Text('Title__Space', style: TextStyle(fontSize: 24)),
          Text('Description', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
