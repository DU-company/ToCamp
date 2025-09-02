import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:to_camp/common/supabase/model/banner_ad_model.dart';
import 'package:to_camp/features/image/view/component/base_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class BannerAdCard extends StatelessWidget {
  final String id;
  final String imgUrl;
  final String link;

  const BannerAdCard({
    super.key,
    required this.id,
    required this.imgUrl,
    required this.link,
  });

  factory BannerAdCard.fromModel({required BannerAdModel model}) {
    return BannerAdCard(
      id: model.id,
      imgUrl: model.imgUrl,
      link: model.link,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await launchUrl(Uri.parse(link));
      },
      child: BaseNetworkImage(imgUrl: imgUrl, fit: BoxFit.fill),
    );
  }
}
