import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/core/supabase/model/banner_ad_model.dart';
import 'package:to_camp/core/supabase/repository/supabase_data_source.dart';

final bannerAdViewModelProvider = NotifierProvider(
  () => BannerAdViewModel(),
);

class BannerAdViewModel extends Notifier<List<BannerAdModel>> {
  SupabaseRepository get repository =>
      ref.read(supabaseRepositoryProvider);
  @override
  List<BannerAdModel> build() {
    getBannerAd();
    return [];
  }

  Future<void> getBannerAd() async {
    try {
      final resp = await repository.getBannerAd();
      state = resp;
    } catch (e) {
      /// 에러 발생 시, 1개의 데이터를 반환
      state = [
        BannerAdModel(id: '1', priority: 1, imgUrl: '', link: ''),
      ];
    }
  }
}
