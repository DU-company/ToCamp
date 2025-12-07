import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/data/models/banner_ad_model.dart';
import 'package:to_camp/data/repositories/supabase/banner_ad_repository.dart';

final bannerAdViewModelProvider = NotifierProvider(
  () => BannerAdViewModel(),
);

class BannerAdViewModel extends Notifier<List<BannerAdModel>> {
  BannerAdRepository get repository =>
      ref.read(bannerAdRepositoryProvider);
  @override
  List<BannerAdModel> build() {
    getBannerAd();
    return [];
  }

  Future<void> getBannerAd() async {
    try {
      final resp = await repository.getBannerAds();
      state = resp;
    } catch (e) {
      /// 에러 발생 시, 1개의 데이터를 반환
      state = [
        BannerAdModel(id: '1', priority: 1, imgUrl: '', link: ''),
      ];
    }
  }
}
