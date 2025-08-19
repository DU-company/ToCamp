import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/model/pagination_model.dart';
import 'package:to_camp/common/provider/current_camping_provider.dart';
import 'package:to_camp/common/theme/component/loading_widget.dart';
import 'package:to_camp/common/view/default_layout.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/view/component/camping_card.dart';
import 'package:to_camp/features/camping_detail/model/camping_detail_model.dart';
import 'package:to_camp/features/camping_detail/provider/camping_detail_provider.dart';
import 'package:to_camp/features/camping_detail/view/screen/camping_detail_error_screen.dart';
import 'package:to_camp/features/camping_detail/view/screen/camping_detail_loading_screen.dart';
import 'package:to_camp/features/camping_detail/view/screen/camping_detail_success_screen.dart';

class CampingDetailScreen extends ConsumerWidget {
  static String get routeName => 'detail';
  final String id;
  const CampingDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(campingDetailProvider(id));

    return DefaultLayout(child: body(detailState));
  }

  Widget body(CampingDetailState detail) {
    // 로딩위젯
    if (detail is CampingDetailLoading) {
      return CampingDetailLoadingScreen();
    }
    // 에러 위젯
    if (detail is CampingDetailError) {
      return CampingDetailErrorScreen(id: id);
    }
    detail as CampingDetailModel;
    return CampingDetailSuccessScreen(detail: detail);
  }
}
