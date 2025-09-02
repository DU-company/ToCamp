import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/common/view/default_layout.dart';
import 'package:to_camp/features/camping_detail/model/camping_detail_model.dart';
import 'package:to_camp/features/camping_detail/provider/camping_detail_provider.dart';
import 'package:to_camp/features/image/view/component/base_network_image.dart';
import 'package:to_camp/features/image/view/screen/image_grid_screen.dart';

final showAppBarProvider = StateProvider.autoDispose((ref) => true);

class ImageDetailScreen extends ConsumerWidget {
  static String get routeName => 'imageDetail';
  final String id;
  const ImageDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final detail =
        ref.watch(campingDetailProvider(id)) as CampingDetailModel;
    final showAppBar = ref.watch(showAppBarProvider);
    final currentIndex = ref.watch(imageDetailIndexProvider);

    return DefaultLayout(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              ref.read(showAppBarProvider.notifier).state =
                  !showAppBar;
            },
            child: InteractiveViewer(
              maxScale: 3,
              child: PageView.builder(
                controller: PageController(initialPage: currentIndex),
                itemCount: detail.imgUrls.length,
                onPageChanged: (value) {
                  ref.read(imageDetailIndexProvider.notifier).state =
                      value;
                },
                itemBuilder: (context, index) {
                  final imgUrl = detail.imgUrls[index];
                  return BaseNetworkImage(
                    imgUrl: imgUrl,
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
          ),
          if (showAppBar)
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: AppBar(
                backgroundColor: theme.color.surface.withValues(
                  alpha: 0.9,
                ),
                title: Text(
                  '${currentIndex + 1}/${detail.imgUrls.length}',
                ),
              ),
            ),
        ],
      ),
    );
  }
}
