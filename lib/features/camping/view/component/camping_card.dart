import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/theme/res/layout.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/view/component/features_box.dart';
import 'package:to_camp/features/camping/view/component/etc_box.dart';
import 'package:to_camp/features/camping/view/component/image_box.dart';
import 'package:to_camp/features/camping/view/component/intro_box.dart';
import 'package:to_camp/features/camping/view/component/name_box.dart';

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
  final Widget likeButton;
  final bool isDetail;
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
    required this.likeButton,
    required this.readMore,
  });

  factory CampingCard.fromModel({
    required CampingModel model,
    required Widget likeButton,
    bool isDetail = false,
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
      likeButton: likeButton,
      isDetail: isDetail,
      readMore: readMore,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);

    return _ResponsiveCampingCard(
      imageBox: ImageBox(thumbUrl: thumbUrl, likeButton: likeButton),
      nameBox: NameBox(name: name, theme: theme),
      introBox: IntroBox(
        lineIntro: lineIntro,
        intro: intro,
        theme: theme,
        maxLine: readMore ? 100 : 5,
      ),
      addressBox: FeaturesAndAddressBox(
        sbrsCl: sbrsCl,
        posblFcltyCl: posblFcltyCl,
        theme: theme,
        doNm: doNm,
        sigunguNm: sigunguNm,
        address: address,
        isDetail: isDetail,
      ),
      etcBox: EtcBox(
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
      isDetail: isDetail,
    );
  }
}

class _ResponsiveCampingCard extends StatelessWidget {
  final Widget imageBox;
  final Widget nameBox;
  final Widget introBox;
  final Widget addressBox;
  final Widget etcBox;
  final bool isDetail;
  const _ResponsiveCampingCard({
    super.key,
    required this.imageBox,
    required this.nameBox,
    required this.introBox,
    required this.addressBox,
    required this.etcBox,
    required this.isDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: context.layout(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(child: nameBox),
                    addressBox,
                    etcBox,
                    if (isDetail) introBox,
                  ],
                ),
              ),
              const SizedBox(width: 4),
              if (!isDetail) Expanded(flex: 2, child: imageBox),
            ],
          ),
        ),
        mobile: Column(
          children: [
            if (!isDetail) imageBox,
            nameBox,
            addressBox,
            etcBox,
            if (isDetail) introBox,
          ],
        ),
      ),
    );
  }
}
