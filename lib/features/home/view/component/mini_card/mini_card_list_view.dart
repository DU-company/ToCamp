import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/common/pagination/model/pagination_model.dart';
import 'package:to_camp/common/theme/component/error_message_widget.dart';
import 'package:to_camp/common/theme/foundation/app_theme.dart';
import 'package:to_camp/common/theme/res/layout.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/service/camping_service.dart';
import 'package:to_camp/features/home/view/component/mini_card/camping_mini_card.dart';
import 'package:to_camp/features/home/view/component/mini_card/mini_card_loading_view.dart';

class MiniCardListView extends ConsumerWidget {
  final String label1;
  final String label2;
  final VoidCallback onTap;
  final StateNotifierProvider<StateNotifier, PaginationState>?
  provider;
  final StateNotifierProviderFamily<
    StateNotifier,
    PaginationState,
    String
  >?
  familyProvider;
  final String? family;
  final String emptyString;
  final VoidCallback onRefresh;
  const MiniCardListView({
    super.key,
    required this.label1,
    required this.label2,
    required this.provider,
    required this.familyProvider,
    required this.family,
    required this.emptyString,
    required this.onTap,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final isFamily = familyProvider != null;
    final data = isFamily
        ? ref.watch(familyProvider!(family!))
        : ref.watch(provider!);

    return SizedBox(
      height: 350,
      child: Column(
        children: [
          _Labels(
            label1: label1,
            label2: label2,
            onTap: onTap,
            theme: theme,
          ),
          if (data is PaginationError)
            Expanded(
              child: ErrorMessageWidget(
                message: data.message,
                onTap: onRefresh,
              ),
            ),

          if (data is PaginationLoading)
            Expanded(
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return MiniCardLoadingView();
                },
              ),
            ),

          if (data is PaginationSuccess<CampingModel>)
            Expanded(
              child: data.items.isEmpty
                  ? Center(
                      child: Text(
                        emptyString,
                        style: theme.typo.subtitle1,
                      ),
                    )
                  : ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: data.items.length,
                      itemBuilder: (context, index) {
                        final model = data.items[index];
                        return GestureDetector(
                          onTap: () {
                            ref
                                .read(campingServiceProvider)
                                .onCampingCardTap(context, model);
                          },
                          child: CampingMiniCard(campingModel: model),
                        );
                      },
                    ),
            ),
        ],
      ),
    );
  }
}

class _Labels extends StatelessWidget {
  final String label1;
  final String label2;
  final VoidCallback onTap;
  final AppTheme theme;
  const _Labels({
    super.key,
    required this.label1,
    required this.label2,
    required this.onTap,
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
            onTap: onTap,
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
