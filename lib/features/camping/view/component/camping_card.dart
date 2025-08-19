import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/common/theme/foundation/app_theme.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';

class CampingCard extends ConsumerWidget {
  final String id;
  final String thumbUrl;
  final String name;
  final String lineIntro;
  final String intro;
  final String sbrsCl;
  final String posblFcltyCl;
  final String doNm;
  final String sigunguNm;
  final String address;
  final String fire;
  final String pet;
  final String caravan;
  final double lng;
  final double lat;
  final String resveUrl;
  final String tel;
  final String siteBottomCl1;
  final String siteBottomCl2;
  final String siteBottomCl3;
  final String siteBottomCl4;
  final String siteBottomCl5;
  final bool isDetail;

  const CampingCard({
    super.key,
    required this.id,
    required this.thumbUrl,
    required this.name,
    required this.lineIntro,
    required this.intro,
    required this.sbrsCl,
    required this.posblFcltyCl,
    required this.doNm,
    required this.sigunguNm,
    required this.address,
    required this.fire,
    required this.pet,
    required this.caravan,
    required this.lng,
    required this.lat,
    required this.resveUrl,
    required this.tel,
    required this.siteBottomCl1,
    required this.siteBottomCl2,
    required this.siteBottomCl3,
    required this.siteBottomCl4,
    required this.siteBottomCl5,
    required this.isDetail,
  });

  factory CampingCard.fromModel({
    required CampingModel model,
    bool isDetail = false,
  }) {
    return CampingCard(
      id: model.id,
      thumbUrl: model.thumbUrl,
      name: model.name,
      lineIntro: model.lineIntro,
      intro: model.intro,
      sbrsCl: model.sbrsCl,
      posblFcltyCl: model.posblFcltyCl,
      doNm: model.doNm,
      sigunguNm: model.sigunguNm,
      address: model.address,
      fire: model.fire,
      pet: model.pet,
      caravan: model.caravan,
      lng: model.lng,
      lat: model.lat,
      resveUrl: model.resveUrl,
      tel: model.tel,
      siteBottomCl1: model.siteBottomCl1,
      siteBottomCl2: model.siteBottomCl2,
      siteBottomCl3: model.siteBottomCl3,
      siteBottomCl4: model.siteBottomCl4,
      siteBottomCl5: model.siteBottomCl5,
      isDetail: isDetail,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final hasFeatures = sbrsCl.isNotEmpty || posblFcltyCl.isNotEmpty;
    return Padding(
      padding: EdgeInsets.all(isDetail ? 4 : 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// Image
          if (!isDetail)
            AspectRatio(
              aspectRatio: 1.5,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(8),
                child: thumbUrl.isEmpty
                    ? Image.asset(
                        'asset/img/camping.jpg',
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        imageUrl: thumbUrl,
                        fit: BoxFit.cover,
                      ),
              ),
            ),

          /// Name
          const SizedBox(height: 8),
          Text(
            name,
            style: theme.typo.headline3.copyWith(
              fontWeight: theme.typo.semiBold,
            ),
          ),

          /// Features
          if (hasFeatures) const SizedBox(height: 8),
          if (hasFeatures)
            Text(
              splitText(sbrsCl + posblFcltyCl),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.typo.body1.copyWith(
                color: theme.color.onHintContainer,
              ),
            ),

          /// Address
          const SizedBox(height: 8),
          Text(
            '$doNm  $sigunguNm',
            style: theme.typo.subtitle1.copyWith(
              fontWeight: theme.typo.semiBold,
              color: theme.color.subtext,
            ),
          ),

          /// Fire, Pet, Caravan
          const SizedBox(height: 8),
          Row(
            children: [
              _IconWithLabel(
                text: fire,
                icon: PhosphorIconsFill.campfire,
                label: '화로',
              ),
              if (pet != 'N' && pet != '불가능' && pet.isNotEmpty)
                renderDot(theme),
              _IconWithLabel(
                text: pet,
                icon: PhosphorIconsFill.dog,
                label: pet,
              ),
              if (caravan != 'N' &&
                  caravan != '불가능' &&
                  caravan.isNotEmpty)
                renderDot(theme),
              _IconWithLabel(
                text: caravan,
                icon: PhosphorIconsBold.truckTrailer,
                label: '카라반',
              ),
            ],
          ),
        ],
      ),
    );
  }

  String splitText(String text) {
    if (text.isEmpty) return '';
    final split = text.split(',');
    final joined = split.join(' · ');
    return joined;
  }

  Text renderDot(AppTheme theme) => Text(
    ' • ',
    style: theme.typo.subtitle2.copyWith(color: theme.color.primary),
  );
}

class _IconWithLabel extends ConsumerWidget {
  final String text;
  final IconData icon;
  final String label;
  const _IconWithLabel({
    super.key,
    required this.text,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    if (text == 'N' || text == '불가능' || text.isEmpty)
      return SizedBox();

    return Row(
      children: [
        Icon(icon, color: theme.color.primary),
        const SizedBox(width: 2),
        Text(
          label,
          style: theme.typo.subtitle2.copyWith(
            color: theme.color.primary,
            fontWeight: theme.typo.semiBold,
          ),
        ),
      ],
    );
  }
}
