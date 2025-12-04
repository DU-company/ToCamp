import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/core/view/default_layout.dart';
import 'package:to_camp/features/camping_detail/model/camping_detail_model.dart';
import 'package:to_camp/features/camping_detail/provider/camping_detail_provider.dart';
import 'package:to_camp/features/image/view/widgets/base_network_image.dart';
import 'package:to_camp/features/image/view/screen/image_detail_screen.dart';
import 'package:flutter_riverpod/legacy.dart';

final imageDetailIndexProvider = StateProvider<int>((ref) => 0);

class ImageGridScreen extends ConsumerWidget {
  static String get routeName => 'imageGrid';
  final List<String> imgUrls;
  const ImageGridScreen({super.key, required this.imgUrls});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final detail = ref.watch(campingDetailProvider(id));

    return DefaultLayout(
      appBar: AppBar(title: Text('${imgUrls.length}장의 사진')),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemCount: imgUrls.length,
        itemBuilder: (context, index) {
          final imgUrl = imgUrls[index];
          return GestureDetector(
            onTap: () {
              ref.read(imageDetailIndexProvider.notifier).state =
                  index;
              context.pushNamed(
                ImageDetailScreen.routeName,
                extra: imgUrls,
              );
            },
            child: BaseNetworkImage(imgUrl: imgUrl, memSize: 300),
          );
        },
      ),
    );
  }
}
