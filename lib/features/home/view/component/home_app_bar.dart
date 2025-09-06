import 'package:flutter/material.dart';
import 'package:to_camp/common/const/data.dart';
import 'package:to_camp/common/theme/res/layout.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: context.layout(350, tablet: 400, desktop: 500),
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          CAMPING_BANNER,
          alignment: AlignmentGeometry.bottomLeft,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
