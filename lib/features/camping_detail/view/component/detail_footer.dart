import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/common/theme/component/bottom_sheet/base_bottom_sheet.dart';
import 'package:to_camp/common/theme/component/primary_button.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/camping_detail/model/camping_detail_model.dart';
import 'package:to_camp/features/like/provider/camping_like_provider.dart';
import 'package:to_camp/features/like/service/camping_like_service.dart';
import 'package:to_camp/features/like/utils/like_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailFooter extends ConsumerWidget {
  final CampingDetailModel detailModel;

  const DetailFooter({super.key, required this.detailModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final likeList = ref.watch(campingLikeProvider);
    final campingModel = detailModel.campingModel;
    final isLiked = LikeUtils.checkIsLiked(likeList, campingModel);
    final hasDomain =
        campingModel.homepage.isNotEmpty ||
        campingModel.resveUrl.isNotEmpty;
    return BaseBottomSheet(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PrimaryButton(
              onPressed: hasDomain
                  ? () async {
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
                  : null,
              text: '예약 사이트',
              padding: 20,
            ),
          ),

          /// Like
          const SizedBox(width: 8),
          PrimaryButton(
            onPressed: () {
              ref
                  .read(campingLikeServiceProvider)
                  .onLikePressed(
                    context: context,
                    isLiked: isLiked,
                    campingModel: campingModel,
                  );
            },
            icon: isLiked
                ? PhosphorIconsFill.heart
                : PhosphorIconsBold.heart,
            backgroundColor: theme.color.surface,
            foregroundColor: isLiked
                ? theme.color.secondary
                : theme.color.subtext,
            padding: 20,
          ),
        ],
      ),
    );
  }
}


