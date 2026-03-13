import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/data/models/camping_detail_model.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/presentation/common/widgets/bottom_sheet/base_bottom_sheet.dart';
import 'package:to_camp/presentation/common/widgets/primary_button.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/presentation/camping/wishlist/wishlist_view_model.dart';
import 'package:to_camp/presentation/camping/wishlist/utils/wishlist_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailFooter extends ConsumerWidget {
  final CampingDetailModel detailModel;

  const DetailFooter({super.key, required this.detailModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final wishlist = ref.watch(wishlistViewModelProvider);

    final campingModel = detailModel.campingModel;

    /// Boolean
    final isLiked = WishlistUtils.checkIsLiked(
      wishlist,
      campingModel,
    );
    final hasLink =
        campingModel.homepage.isNotEmpty ||
        campingModel.resveUrl.isNotEmpty;

    return BaseBottomSheet(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PrimaryButton(
              text: '예약 사이트',
              onPressed: hasLink ? onTapLink : null,
            ),
          ),

          /// Like
          const SizedBox(width: 8),
          PrimaryButton(
            onPressed: () =>
                onLikePressed(context, ref, isLiked, campingModel),
            icon: isLiked
                ? PhosphorIconsFill.heart
                : PhosphorIconsBold.heart,
            backgroundColor: theme.color.surface,
            foregroundColor: isLiked
                ? theme.color.secondary
                : theme.color.onHintContainer,
            borderColor: theme.color.onHintContainer,
          ),
        ],
      ),
    );
  }

  Future<void> onTapLink() async {
    final campingModel = detailModel.campingModel;
    String url;
    if (campingModel.resveUrl.isNotEmpty) {
      url = campingModel.resveUrl;
    } else {
      url = campingModel.homepage;
    }
    await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.inAppBrowserView,
    );
  }

  void onLikePressed(
    BuildContext context,
    WidgetRef ref,
    bool isLiked,
    CampingModel campingModel,
  ) {
    ref
        .read(wishlistViewModelProvider.notifier)
        .onLikePressed(
          context: context,
          isLiked: isLiked,
          campingModel: campingModel,
        );
  }
}
