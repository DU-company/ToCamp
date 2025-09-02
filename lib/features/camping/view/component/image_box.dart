import 'package:flutter/material.dart';
import 'package:to_camp/common/const/data.dart';
import 'package:to_camp/features/image/view/component/base_network_image.dart';

class ImageBox extends StatelessWidget {
  final String thumbUrl;
  final Widget? likeButton;
  final double radius;
  final double aspectRatio;
  const ImageBox({
    super.key,
    required this.thumbUrl,
    required this.likeButton,
    this.aspectRatio = 1.3,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: aspectRatio,
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(radius),
            child: thumbUrl.isEmpty
                ? Image.asset(
              CAMPING_IMAGE,
              fit: BoxFit.cover,
              width: double.infinity,
            )
                : BaseNetworkImage(imgUrl: thumbUrl),
          ),
        ),

        if (likeButton != null) likeButton!,
      ],
    );
  }
}