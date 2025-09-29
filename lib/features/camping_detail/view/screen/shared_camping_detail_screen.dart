import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/pagination/model/pagination_model.dart';
import 'package:to_camp/common/theme/component/error_message_widget.dart';
import 'package:to_camp/common/view/default_layout.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping_detail/provider/camping_detail_provider.dart';
import 'package:to_camp/features/camping_detail/view/screen/camping_detail_loading_screen.dart';
import 'package:to_camp/features/camping_detail/view/screen/camping_detail_screen.dart';
import 'package:to_camp/features/search/provider/search_camping_provider.dart';

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
    final state = ref.watch(searchCampingProvider(name));

    return DefaultLayout(child: body(state, ref));
  }

  Widget body(PaginationState state, WidgetRef ref) {
    // 로딩위젯
    if (state is PaginationLoading) {
      return CampingDetailLoadingScreen();
    }
    // 에러 위젯
    if (state is PaginationError) {
      return ErrorMessageWidget(
        onTap: () {
          ref.read(searchCampingProvider(name).notifier).paginate();
        },
        message: state.message,
      );
    }
    state as PaginationSuccess<CampingModel>;
    return CampingDetailScreen(id: id);
  }
}
