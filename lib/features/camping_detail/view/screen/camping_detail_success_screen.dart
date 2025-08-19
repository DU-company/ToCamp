import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:to_camp/common/theme/component/custom_icon_button.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/camping_detail/model/camping_detail_model.dart';
import 'package:to_camp/features/camping_detail/view/component/detail_app_bar.dart';
import 'package:to_camp/features/camping_detail/view/component/detail_body.dart';

class CampingDetailSuccessScreen extends ConsumerWidget {
  final CampingDetailModel detail;

  const CampingDetailSuccessScreen({super.key, required this.detail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return CustomScrollView(
      slivers: [
        DetailAppBar(detail: detail),
        DetailBody(campingModel: detail.campingModel),
      ],
    );
  }
}
