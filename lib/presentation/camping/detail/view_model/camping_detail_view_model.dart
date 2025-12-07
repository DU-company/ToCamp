import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/core/models/pagination_params.dart';
import 'package:to_camp/core/provider/current_camping_provider.dart';
import 'package:to_camp/data/repositories/camping_repository.dart';
import 'package:to_camp/presentation/camping/detail/view_model/camping_detail_state.dart';

final campingDetailViewModelProvider = NotifierProvider.family(
  (String id) => CampingDetailViewModel(id),
);

class CampingDetailViewModel extends Notifier<CampingDetailState> {
  final String id;
  CampingDetailViewModel(this.id);

  late final CampingRepository repository;

  @override
  CampingDetailState build() {
    repository = ref.read(campingRepositoryProvider);
    getDetail();
    return CampingDetailLoading();
  }

  Future<void> getDetail() async {
    try {
      state = CampingDetailLoading();
      final params = PaginationParams(take: 30, pageNo: 1, id: id);
      final campingModel = ref.read(selectedCampingProvider)!;
      final resp = await repository.getCampingDetail(
        params,
        campingModel,
      );
      state = CampingDetailSuccess(resp);
    } catch (e) {
      state = CampingDetailError(e.toString());
    }
  }
}
