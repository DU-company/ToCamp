import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/presentation/common/widgets/error_message_widget.dart';
import 'package:to_camp/core/theme/foundation/app_theme.dart';
import 'package:to_camp/core/theme/res/layout.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/presentation/camping/base/based_list_view_model.dart';
import 'package:to_camp/core/models/pagination_state.dart';
import 'package:to_camp/presentation/home/widgets/mini_card/camping_mini_card.dart';
import 'package:to_camp/presentation/home/widgets/mini_card/mini_card_loading_view.dart';

class MiniCardListView extends ConsumerWidget {
  final PaginationState state;
  final String emptyString;
  final String label1;
  final String label2;
  final VoidCallback onReadMore;
  final VoidCallback onRefresh;
  const MiniCardListView({
    super.key,
    required this.state,
    required this.emptyString,
    required this.label1,
    required this.label2,
    required this.onReadMore,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);

    return SizedBox(
      height: 350,
      child: Column(
        children: [
          _Labels(
            label1: label1,
            label2: label2,
            onReadMore: onReadMore,
            theme: theme,
          ),
          Expanded(child: body(ref)),
        ],
      ),
    );
  }

  Widget body(WidgetRef ref) {
    if (state is PaginationError) {
      final pState = state as PaginationError;
      return ErrorMessageWidget(
        message: pState.message,
        onTap: onRefresh,
      );
    }

    if (state is PaginationLoading) {
      return MiniCardLoadingView();
    }

    final pState = state as PaginationSuccess<CampingModel>;
    final items = pState.items;
    if (items.isEmpty) {
      return ErrorMessageWidget(message: emptyString, onTap: null);
    }

    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: pState.items.length,
      itemBuilder: (context, index) {
        final model = pState.items[index];
        return GestureDetector(
          onTap: () => ref
              .read(basedListViewModelProvider.notifier)
              .onCampingCardTap(context, model),
          child: CampingMiniCard(campingModel: model),
        );
      },
    );
  }
}

class _Labels extends StatelessWidget {
  final String label1;
  final String label2;
  final VoidCallback onReadMore;
  final AppTheme theme;
  const _Labels({
    super.key,
    required this.label1,
    required this.label2,
    required this.onReadMore,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 8,
      ),
      child: Row(
        children: [
          Text(
            label1,
            style: context.layout(
              theme.typo.headline5,
              mobile: theme.typo.headline6,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: onReadMore,
            child: Row(
              children: [
                Text(
                  label2,
                  style: context.layout(
                    theme.typo.subtitle1,
                    mobile: theme.typo.subtitle2,
                  ),
                ),
                Icon(
                  PhosphorIconsBold.caretRight,
                  color: theme.color.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
