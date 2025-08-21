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
  final String siteBottomCl1; //잔디
  final String siteBottomCl2; //파쇄석
  final String siteBottomCl3; //데크
  final String siteBottomCl4; //자갈
  final String siteBottomCl5; //흙
  final bool isDetail;
  final bool isHorizontal;
  final bool readMore;

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
    required this.isHorizontal,
    required this.readMore,
  });

  factory CampingCard.fromModel({
    required CampingModel model,
    bool isDetail = false,
    bool isHorizontal = false,
    bool readMore = false,
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
      isHorizontal: isHorizontal,
      readMore: readMore,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);

    return dynamicWidget(
      ImageBox(thumbUrl: thumbUrl),
      NameBox(name: name, theme: theme),
      FeaturesAndAddressBox(
        sbrsCl: sbrsCl,
        posblFcltyCl: posblFcltyCl,
        theme: theme,
        doNm: doNm,
        sigunguNm: sigunguNm,
        address: address,
        isDetail: isDetail,
      ),
      EtcBox(
        theme: theme,
        pet: pet,
        fire: fire,
        caravan: caravan,
        siteBottomCl1: siteBottomCl1,
        siteBottomCl2: siteBottomCl2,
        siteBottomCl3: siteBottomCl3,
        siteBottomCl4: siteBottomCl4,
        siteBottomCl5: siteBottomCl5,
      ),
      IntroBox(
        lineIntro: lineIntro,
        intro: intro,
        theme: theme,
        maxLine: readMore ? 100 : 3,
      ),
    );
  }

  Widget dynamicWidget(
    Widget imageBox,
    Widget nameBox,
    Widget featuresBox,
    Widget etcBox,
    Widget introBox,
  ) {
    return Padding(
      padding: EdgeInsets.all(isDetail ? 4 : 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: isHorizontal
            ? [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.stretch,
                          children: [nameBox, Spacer(), introBox],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(flex: 1, child: imageBox),
                    ],
                  ),
                ),
                featuresBox,
                etcBox,
              ]
            : [
                if (!isDetail) imageBox,
                nameBox,
                featuresBox,
                etcBox,
                if (isDetail) introBox,
              ],
      ),
    );
  }
}

class ImageBox extends StatelessWidget {
  final String thumbUrl;
  const ImageBox({super.key, required this.thumbUrl});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(8),
        child: thumbUrl.isEmpty
            ? Image.asset('asset/img/camping.jpg', fit: BoxFit.cover)
            : CachedNetworkImage(
                imageUrl: thumbUrl,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}

class NameBox extends StatelessWidget {
  final String name;
  final AppTheme theme;
  const NameBox({super.key, required this.name, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      maxLines: 2,
      style: theme.typo.headline2.copyWith(
        fontWeight: theme.typo.semiBold,
      ),
    );
  }
}

class IntroBox extends StatelessWidget {
  final String lineIntro;
  final String intro;
  final AppTheme theme;
  final int maxLine;
  const IntroBox({
    super.key,
    required this.lineIntro,
    required this.intro,
    required this.theme,
    required this.maxLine,
  });

  @override
  Widget build(BuildContext context) {
    final hasIntro = lineIntro.isNotEmpty || intro.isNotEmpty;
    final longerIntro = lineIntro.length > intro.length
        ? lineIntro
        : intro;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16),
        if (hasIntro)
          Text(
            longerIntro,
            maxLines: maxLine,
            overflow: TextOverflow.ellipsis,
            style: theme.typo.headline6.copyWith(
              // height: 1.5,
              color: theme.color.subtext,
            ),
          ),
      ],
    );
  }
}

class FeaturesAndAddressBox extends StatelessWidget {
  final String sbrsCl;
  final String posblFcltyCl;
  final AppTheme theme;
  final String doNm;
  final String sigunguNm;
  final String address;
  final bool isDetail;
  const FeaturesAndAddressBox({
    super.key,
    required this.sbrsCl,
    required this.posblFcltyCl,
    required this.theme,
    required this.doNm,
    required this.address,
    required this.sigunguNm,
    required this.isDetail,
  });

  @override
  Widget build(BuildContext context) {
    final hasFeatures = sbrsCl.isNotEmpty || posblFcltyCl.isNotEmpty;

    final pAddress = isDetail ? address : '$doNm $sigunguNm';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /// Features
        if (hasFeatures) const SizedBox(height: 8),
        if (hasFeatures)
          Text(
            splitText(sbrsCl + posblFcltyCl),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.typo.subtitle1.copyWith(
              color: theme.color.inactive,
            ),
          ),

        /// Address
        const SizedBox(height: 8),
        Text(
          pAddress,
          style: theme.typo.subtitle1.copyWith(
            fontWeight: theme.typo.semiBold,
            color: theme.color.subtext,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  String splitText(String text) {
    if (text.isEmpty) return '';
    final split = text.split(',');
    final joined = split.join(' · ');
    return joined;
  }
}

class EtcBox extends StatelessWidget {
  final AppTheme theme;
  final String pet;
  final String fire;
  final String caravan;
  final String siteBottomCl1;
  final String siteBottomCl2;
  final String siteBottomCl3;
  final String siteBottomCl4;
  final String siteBottomCl5;

  const EtcBox({
    super.key,
    required this.theme,
    required this.pet,
    required this.fire,
    required this.caravan,
    required this.siteBottomCl1,
    required this.siteBottomCl2,
    required this.siteBottomCl3,
    required this.siteBottomCl4,
    required this.siteBottomCl5,
  });

  @override
  Widget build(BuildContext context) {
    final isPetAllowed = pet.isNotEmpty && pet != '불가능';
    final isCaravanAllowed = caravan.isNotEmpty && caravan != 'N';
    final isFireAllowed = fire.isNotEmpty && fire != '불가능';
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: 4,
      spacing: 4,
      children: [
        if (isFireAllowed)
          const _IconWithLabel(
            icon: PhosphorIconsBold.campfire,
            label: '화로',
          ),

        /// Pet
        if (isPetAllowed) renderDot(theme),
        if (isPetAllowed)
          _IconWithLabel(icon: PhosphorIconsFill.dog, label: pet),

        /// Caravan
        if (isCaravanAllowed) renderDot(theme),
        if (isCaravanAllowed)
          _IconWithLabel(
            icon: PhosphorIconsBold.truckTrailer,
            label: '카라반',
          ),

        if (siteBottomCl1 != '0') renderDot(theme),
        _SiteType(siteCount: siteBottomCl1, type: '잔디'),

        if (siteBottomCl2 != '0') renderDot(theme),
        _SiteType(siteCount: siteBottomCl2, type: '파쇄석'),

        if (siteBottomCl3 != '0') renderDot(theme),
        _SiteType(siteCount: siteBottomCl3, type: '데크'),

        if (siteBottomCl4 != '0') renderDot(theme),
        _SiteType(siteCount: siteBottomCl4, type: '자갈'),

        if (siteBottomCl5 != '0') renderDot(theme),
        _SiteType(siteCount: siteBottomCl5, type: '흙'),
      ],
    );
  }

  Text renderDot(AppTheme theme) => Text(
    '•',
    style: theme.typo.subtitle2.copyWith(color: theme.color.primary),
  );
}

class _IconWithLabel extends ConsumerWidget {
  final IconData icon;
  final String label;
  const _IconWithLabel({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: theme.color.primary),
            const SizedBox(width: 4),
            Text(
              label,
              style: theme.typo.subtitle2.copyWith(
                color: theme.color.primary,
                fontWeight: theme.typo.semiBold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SiteType extends ConsumerWidget {
  final String siteCount;
  final String type;
  const _SiteType({
    super.key,
    required this.siteCount,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);

    if (siteCount == '0') return SizedBox();
    return Text(
      '$type $siteCount',
      style: theme.typo.subtitle2.copyWith(
        color: theme.color.primary,
        fontWeight: theme.typo.semiBold,
      ),
    );
  }
}
