import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:to_camp/data/models/banner_ad_model.dart';
import 'package:to_camp/features/image/view/widgets/base_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class BannerAdCard extends StatelessWidget {
  final BannerAdModel model;

  const BannerAdCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () async {
          await launchUrl(Uri.parse(model.link));
        },
        child: BaseNetworkImage(
          imgUrl: model.imgUrl,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
