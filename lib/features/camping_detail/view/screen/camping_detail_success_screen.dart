import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/features/camping_detail/model/camping_detail_model.dart';
import 'package:to_camp/features/camping_detail/view/component/detail_app_bar.dart';
import 'package:to_camp/features/camping_detail/view/component/detail_body.dart';
import 'package:to_camp/features/camping_detail/view/component/detail_footer.dart';

class CampingDetailSuccessScreen extends ConsumerWidget {
  final CampingDetailModel detail;

  const CampingDetailSuccessScreen({super.key, required this.detail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              DetailAppBar(detailModel: detail),
              DetailBody(campingModel: detail.campingModel),
            ],
          ),
        ),
        DetailFooter(detailModel: detail),
      ],
    );
  }
}
