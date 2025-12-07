import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/presentation/camping/detail/view_model/camping_detail_state.dart';
import 'package:to_camp/presentation/camping/detail/view_model/camping_detail_view_model.dart';
import 'package:to_camp/presentation/common/layout/default_layout.dart';
import 'package:to_camp/presentation/common/widgets/error_message_widget.dart';
import 'package:to_camp/presentation/camping/detail/widgets/camping_detail_loading_view.dart';
import 'package:to_camp/presentation/camping/detail/widgets/camping_detail_success_view.dart';

class CampingDetailScreen extends ConsumerWidget {
  static String get routeName => 'detail';
  final String id;
  const CampingDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(campingDetailViewModelProvider(id));

    return DefaultLayout(child: body(ref, detailState));
  }

  Widget body(WidgetRef ref, CampingDetailState detail) {
    if (detail is CampingDetailLoading) {
      return CampingDetailLoadingView();
    }
    if (detail is CampingDetailError) {
      return ErrorMessageWidget(
        message: detail.message,
        onTap: () {
          ref
              .read(campingDetailViewModelProvider(id).notifier)
              .getDetail();
        },
      );
    }
    detail as CampingDetailSuccess;
    return CampingDetailSuccessView(detail: detail.detail);
  }
}
