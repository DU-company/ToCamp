import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/features/common/widgets/error_message_widget.dart';
import 'package:to_camp/features/common/layout/default_layout.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/features/camping/search/search_view_model.dart';
import 'package:to_camp/features/camping_detail/view/screen/camping_detail_loading_screen.dart';
import 'package:to_camp/features/camping_detail/view/screen/camping_detail_screen.dart';
import 'package:to_camp/core/models/pagination_state.dart';

class SharedCampingDetailScreen extends ConsumerWidget {
  static String get routeName => 'shared';

  final String id;
  final String name;

  const SharedCampingDetailScreen({
    super.key,
    required this.id,
    required this.name,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchViewModelProvider(name));

    return DefaultLayout(child: body(state, ref));
  }

  Widget body(PaginationStateV2 state, WidgetRef ref) {
    if (state is PaginationLoadingV2) {
      return CampingDetailLoadingView();
    }

    if (state is PaginationErrorV2) {
      return ErrorMessageWidget(
        onTap: () => ref
            .read(searchViewModelProvider(name).notifier)
            .paginate(),
        message: state.message,
      );
    }
    state as PaginationSuccessV2<CampingModel>;
    return CampingDetailScreen(id: id);
  }
}
