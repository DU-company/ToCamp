import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:to_camp/common/theme/component/custom_icon_button.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/camping_detail/model/camping_detail_model.dart';
import 'package:to_camp/features/like/view/component/like_button.dart';

final imageIndexProvider = StateProvider.autoDispose<int>((ref) => 0);

class DetailAppBar extends ConsumerWidget {
  final CampingDetailModel detail;
  const DetailAppBar({super.key, required this.detail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final campingModel = detail.campingModel;
    final hasThumbUrl = campingModel.thumbUrl.isNotEmpty;
    final totalLength = hasThumbUrl
        ? detail.imgUrls.length + 1
        : detail.imgUrls.length;

    return SliverAppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 8,
      toolbarHeight: 42,
      title: _Buttons(detailModel: detail),
      expandedHeight: 250,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            if (totalLength == 0)
              Image.asset(
                'asset/img/camping.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
              ),

            if (totalLength != 0)
              PageView.builder(
                onPageChanged: (index) {
                  ref.read(imageIndexProvider.notifier).state = index;
                },
                itemCount: totalLength,
                itemBuilder: (context, index) {
                  if (hasThumbUrl && index == 0) {
                    return CachedNetworkImage(
                      imageUrl: campingModel.thumbUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
                  }
                  final imgUrl = hasThumbUrl
                      ? detail.imgUrls[index - 1]
                      : detail.imgUrls[index];

                  return CachedNetworkImage(
                    imageUrl: imgUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) {
                      return Skeletonizer(
                        enabled: true,
                        child: Container(
                          color: theme.color.hintContainer,
                          height: 300,
                          width: 300,
                        ),
                      );
                    },
                  );
                },
              ),
            if (totalLength != 0) _IndexBox(length: totalLength),
          ],
        ),
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  final CampingDetailModel detailModel;
  const _Buttons({super.key, required this.detailModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomIconButton(
          onTap: () {
            context.pop();
          },
          icon: PhosphorIconsBold.caretLeft,
        ),
        Spacer(),
        LikeButton(
          campingModel: detailModel.campingModel,
          size: 24,
          isDetail: true,
        ),
        // CustomIconButton(onTap: () {}, icon: PhosphorIcons.heart()),
        CustomIconButton(
          onTap: () {},
          icon: PhosphorIcons.dotsThreeOutlineVertical(),
        ),
      ],
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
        child: Text(
          '전경 | ${index + 1}/$length',
          style: theme.typo.body1,
        ),
        decoration: BoxDecoration(
          color: theme.color.surface.withOpacity(0.6),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          ),
        ),
      ),
    );
  }
}
