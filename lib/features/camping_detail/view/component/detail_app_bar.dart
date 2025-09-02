import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:to_camp/common/const/data.dart';
import 'package:to_camp/common/theme/component/custom_icon_button.dart';
import 'package:to_camp/common/theme/res/layout.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/camping_detail/model/camping_detail_model.dart';
import 'package:to_camp/features/image/view/component/base_network_image.dart';
import 'package:to_camp/features/image/view/screen/image_grid_screen.dart';
import 'package:to_camp/features/like/view/component/like_button.dart';
import 'package:to_camp/routes/dynamic_link_service.dart';

final imageIndexProvider = StateProvider.autoDispose<int>((ref) => 0);

class DetailAppBar extends ConsumerWidget {
  final CampingDetailModel detailModel;
  const DetailAppBar({super.key, required this.detailModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 8,
      toolbarHeight: 42,
      title: _Buttons(detailModel: detailModel),
      expandedHeight: context.layout(350, tablet: 450, desktop: 350),
      flexibleSpace: _ImagePageView(detailModel: detailModel),
    );
  }
}

class _Buttons extends ConsumerWidget {
  final CampingDetailModel detailModel;
  const _Buttons({super.key, required this.detailModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        CustomIconButton(
          onTap: () {
            context.pop();
          },
          icon: PhosphorIconsBold.caretLeft,
          size: 26,
        ),
        Spacer(),
        LikeButton(
          campingModel: detailModel.campingModel,
          size: 26,
          isDetail: true,
        ),
        CustomIconButton(
          onTap: () => DynamicLinkService.shareLink(
            context,
            detailModel.campingModel,
          ),
          icon: PhosphorIcons.shareNetwork(),
          size: 26,
        ),
      ],
    );
  }
}

class _ImagePageView extends ConsumerWidget {
  final CampingDetailModel detailModel;
  const _ImagePageView({super.key, required this.detailModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campingModel = detailModel.campingModel;
    final hasThumbUrl = campingModel.thumbUrl.isNotEmpty;
    final imgLength = hasThumbUrl
        ? detailModel.imgUrls.length + 1
        : detailModel.imgUrls.length;
    final hasImages = imgLength != 0;

    return FlexibleSpaceBar(
      background: Stack(
        children: [
          /// 썸네일 및 상세 이미지가 없는 경우
          if (!hasThumbUrl && !hasImages)
            Image.asset(
              CAMPING_IMAGE,
              fit: BoxFit.cover,
              width: double.infinity,
            ),

          /// 썸네일은 있는데, 상세 이미지는 없는 경오 (약간 특이 케이스)
          if (hasThumbUrl && !hasImages)
            BaseNetworkImage(imgUrl: campingModel.thumbUrl),

          /// 상세 이미지가 있는 경우
          if (hasImages)
            GestureDetector(
              onTap: () {
                context.pushNamed(
                  ImageGridScreen.routeName,
                  queryParameters: {'id': campingModel.id},
                );
              },
              child: PageView.builder(
                onPageChanged: (index) {
                  ref.read(imageIndexProvider.notifier).state = index;
                },
                itemCount: imgLength,
                itemBuilder: (context, index) {
                  /// 썸네일이 존재하는 경우,첫 이미지는 썸네일로 보여준다.(UX개선)
                  if (hasThumbUrl && index == 0) {
                    return BaseNetworkImage(
                      imgUrl: campingModel.thumbUrl,
                    );
                  }
                  final imgUrl = hasThumbUrl
                      ? detailModel.imgUrls[index - 1]
                      : detailModel.imgUrls[index];

                  return BaseNetworkImage(imgUrl: imgUrl);
                },
              ),
            ),
          if (hasImages) _IndexBox(length: imgLength),
        ],
      ),
    );
  }
}

class _IndexBox extends ConsumerWidget {
  final int length;
  const _IndexBox({super.key, required this.length});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(imageIndexProvider);
    final theme = ref.watch(themeServiceProvider);
    return Positioned(
      bottom: 16,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: theme.color.surface.withOpacity(0.6),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          ),
        ),
        child: Text(
          '전경 | ${index + 1}/$length',
          style: theme.typo.body1,
        ),
      ),
    );
  }
}
