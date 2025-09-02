import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:to_camp/common/theme/component/error_message_widget.dart';

class BaseNetworkImage extends StatelessWidget {
  final String imgUrl;
  final BoxFit fit;
  final double height;
  const BaseNetworkImage({
    super.key,
    required this.imgUrl,
    this.fit = BoxFit.cover,
    this.height = 250,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      fit: fit,
      width: double.infinity,
      height: height,
      fadeInDuration: Duration(milliseconds: 100),
      placeholder: (context, url) {
        return Skeletonizer(
          enabled: true,
          child: Container(
            color: Colors.red,
            height: height,
            width: double.infinity,
          ),
        );
      },
      errorWidget: (context, url, error) {
        return const ErrorMessageWidget(
          message: 'ERROR',
          onTap: null,
        );
      },
    );
  }
}
