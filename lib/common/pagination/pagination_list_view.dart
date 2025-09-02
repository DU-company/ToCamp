import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/model/pagination_model.dart';
import 'package:to_camp/common/theme/component/custom_divider.dart';
import 'package:to_camp/common/theme/component/error_message_widget.dart';
import 'package:to_camp/common/theme/component/loading_widget.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/provider/camping_provider.dart';
import 'package:to_camp/features/camping/view/component/camping_card.dart';
import 'package:to_camp/features/like/view/component/like_button.dart';

class PaginationListView extends ConsumerStatefulWidget {
  const PaginationListView({super.key});

  @override
  ConsumerState<PaginationListView> createState() =>
      _PaginationListViewState();
}

class _PaginationListViewState
    extends ConsumerState<PaginationListView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(listener);
  }

  listener() {
    if (scrollController.offset >
        scrollController.position.maxScrollExtent - 300) {
      EasyThrottle.throttle('pagination', Duration(seconds: 1), () {
        ref
            .read(campingProvider.notifier)
            .paginate(fetchingMore: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(campingProvider);

    if (data is PaginationLoading) {
      return LoadingWidget();
    }
    if (data is PaginationError) {
      return ErrorMessageWidget(message: data.message, onTap: () {});
    }
    data as PaginationSuccess<CampingModel>;

    return ListView.separated(
      controller: scrollController,
      itemCount: data.items.length,
      itemBuilder: (context, index) {
        final model = data.items[index];
        return CampingCard.fromModel(
          model: model,
          likeButton: LikeButton(campingModel: model),
        );
      },
      separatorBuilder: (_, _) => CustomDivider(),
    );
  }
}
