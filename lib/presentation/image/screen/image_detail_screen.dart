import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/presentation/common/layout/default_layout.dart';
import 'package:to_camp/presentation/image/widgets/base_network_image.dart';
import 'package:to_camp/presentation/image/screen/image_grid_screen.dart';
import 'package:flutter_riverpod/legacy.dart';

final showAppBarProvider = StateProvider.autoDispose((ref) => true);

class ImageDetailScreen extends ConsumerWidget {
  static String get routeName => 'image-detail';
  final List<String> imgUrls;
  const ImageDetailScreen({super.key, required this.imgUrls});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
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
                itemCount: imgUrls.length,
                onPageChanged: (value) {
                  ref.read(imageDetailIndexProvider.notifier).state =
                      value;
                },
                itemBuilder: (context, index) {
                  final imgUrl = imgUrls[index];
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
                title: Text('${currentIndex + 1}/${imgUrls.length}'),
              ),
            ),
        ],
      ),
    );
  }
}
