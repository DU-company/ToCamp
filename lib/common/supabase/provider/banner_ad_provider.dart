import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/supabase/model/banner_ad_model.dart';
import 'package:to_camp/common/supabase/repository/supabase_repository.dart';

final bannerAdProvider = StateNotifierProvider((ref) {
  final supabaseRepository = ref.watch(supabaseRepositoryProvider);
  return BannerAdStateNotifier(
    supabaseRepository: supabaseRepository,
  );
});

class BannerAdStateNotifier
    extends StateNotifier<List<BannerAdModel>> {
  final SupabaseRepository supabaseRepository;

  BannerAdStateNotifier({required this.supabaseRepository})
    : super([]) {
    getBannerAd();
  }

  Future<void> getBannerAd() async {
    try {
      final resp = await supabaseRepository.getBannerAd();
      state = resp;
    } catch (e) {
      /// 에러 발생 시, 1개의 데이터를 반환
      state = [
        BannerAdModel(id: '1', priority: 1, imgUrl: '', link: ''),
      ];
    }
  }
}
