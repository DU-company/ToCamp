import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/features/common/widgets/custom_icon_button.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/features/camping/base/widgets/camping_card.dart';
import 'package:to_camp/features/camping/wishlist/widgets/like_button.dart';
import 'package:flutter_riverpod/legacy.dart';

final readMoreProvider = StateProvider.autoDispose((ref) => false);

class DetailBody extends ConsumerWidget {
  final CampingModel campingModel;
  const DetailBody({super.key, required this.campingModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readMore = ref.watch(readMoreProvider);
    final theme = ref.watch(themeServiceProvider);
    final hasIntro =
        campingModel.lineIntro.isNotEmpty ||
        campingModel.intro.isNotEmpty;
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
          if (hasIntro)
            CustomIconButton(
              foregroundColor: theme.color.primary,
              onTap: () {
                ref.read(readMoreProvider.notifier).state = !readMore;
              },
              icon: readMore
                  ? PhosphorIconsBold.caretUp
                  : PhosphorIconsBold.caretDown,
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
