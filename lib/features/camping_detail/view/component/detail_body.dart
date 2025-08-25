import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/common/theme/component/custom_icon_button.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/view/component/camping_card.dart';
import 'package:to_camp/features/camping_detail/view/component/detail_map.dart';
import 'package:to_camp/features/like/view/component/like_button.dart';

final readMoreProvider = StateProvider.autoDispose((ref) => false);

class DetailBody extends ConsumerWidget {
  final CampingModel campingModel;
  const DetailBody({super.key, required this.campingModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readMore = ref.watch(readMoreProvider);
    final theme = ref.watch(themeServiceProvider);
    return SliverToBoxAdapter(
      child: Column(
        children: [
          CampingCard.fromModel(
            likeButton: LikeButton(campingModel: campingModel),
            model: campingModel,
            isDetail: true,
            readMore: readMore,
          ),

          /// ReadMoreButton
          CustomIconButton(
            foregroundColor: theme.color.primary,
            onTap: () {
              ref.read(readMoreProvider.notifier).state = !readMore;
            },
            icon: readMore
                ? PhosphorIconsBold.caretUp
                : PhosphorIconsBold.caretDown,
          ),
          const Divider(height: 32),
          DetailMap(model: campingModel),
        ],
      ),
    );
  }
}
