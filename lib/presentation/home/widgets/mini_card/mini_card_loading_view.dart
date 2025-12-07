import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:to_camp/presentation/camping/detail/widgets/camping_detail_loading_view.dart';

class MiniCardLoadingView extends StatelessWidget {
  const MiniCardLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: SizedBox(
            height: 350,
            child: Skeletonizer(
              enabled: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Image
                  SizedBox(
                    height: 200,
                    width: 250,
                    child: Bone.square(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  Text(
                    'Title________',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text('Description', style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
