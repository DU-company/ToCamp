import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/data/data_sources/supabase/banner_ad_data_source.dart';
import 'package:to_camp/data/models/banner_ad_model.dart';

final bannerAdRepositoryProvider = Provider((ref) {
  final dataSource = ref.read(bannerAdDataSourceProvider);
  return BannerAdRepository(dataSource);
});

class BannerAdRepository {
  final BannerAdDataSource dataSource;

  BannerAdRepository(this.dataSource);

  Future<List<BannerAdModel>> getBannerAds() async {
    final resp = await dataSource.fetchBannerAd();
    return resp.map((e) => BannerAdModel.fromJson(e)).toList();
  }
}
