import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/presentation/common/layout/default_layout.dart';
import 'package:to_camp/presentation/image/screen/image_detail_screen.dart';
import 'package:to_camp/presentation/image/widgets/base_network_image.dart';
import 'package:flutter_riverpod/legacy.dart';

final imageDetailIndexProvider = StateProvider<int>((ref) => 0);

class ImageGridScreen extends ConsumerWidget {
  static String get routeName => 'image-grid';
  final List<String> imgUrls;
  const ImageGridScreen({super.key, required this.imgUrls});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            child: BaseNetworkImage(imgUrl: imgUrl, memSize: 200),
          );
        },
      ),
    );
  }
}
