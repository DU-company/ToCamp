import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/presentation/common/layout/default_layout.dart';
import 'package:to_camp/presentation/image/widgets/base_network_image.dart';
import 'package:to_camp/presentation/image/screen/image_grid_screen.dart';

class ImageDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'image-detail';
  final List<String> imgUrls;
  const ImageDetailScreen({super.key, required this.imgUrls});

  @override
  ConsumerState<ImageDetailScreen> createState() =>
      _ImageDetailScreenState();
}

class _ImageDetailScreenState
    extends ConsumerState<ImageDetailScreen> {
  late final PageController pageController;
  late final TransformationController transformationController;
  bool showAppBar = true;
  bool isZoomed = false;

  @override
  void initState() {
    super.initState();
    initController();
  }

  @override
  void dispose() {
    transformationController.removeListener(zoomListener);
    transformationController.dispose();
    pageController.dispose();
    super.dispose();
  }

  void initController() {
    final currentIndex = ref.read(imageDetailIndexProvider);
    pageController = PageController(initialPage: currentIndex);
    transformationController = TransformationController();
    transformationController.addListener(zoomListener);
  }

  void zoomListener() {
    final scale = transformationController.value.getMaxScaleOnAxis();
    setState(() {
      isZoomed = scale > 1.0; // 확대 여부 체크
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeServiceProvider);
    final currentIndex = ref.watch(imageDetailIndexProvider);

    return DefaultLayout(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => setState(() {
              showAppBar = !showAppBar;
            }),
            child: InteractiveViewer(
              transformationController: transformationController,
              maxScale: 3,
              child: PageView.builder(
                physics: isZoomed
                    ? const NeverScrollableScrollPhysics()
                    : const BouncingScrollPhysics(),
                controller: pageController,
                itemCount: widget.imgUrls.length,
                onPageChanged: (value) {
                  ref.read(imageDetailIndexProvider.notifier).state =
                      value;
                },
                itemBuilder: (context, index) {
                  final imgUrl = widget.imgUrls[index];
                  return BaseNetworkImage(
                    imgUrl: imgUrl,
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
          ),

          /// AppBar
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
                  '${currentIndex + 1}/${widget.imgUrls.length}',
                ),
              ),
            ),
        ],
      ),
    );
  }
}
