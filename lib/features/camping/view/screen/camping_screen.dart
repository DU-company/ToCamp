import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/model/pagination_model.dart';
import 'package:to_camp/common/theme/component/loading_widget.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/provider/camping_provider.dart';
import 'package:to_camp/features/camping/service/camping_service.dart';
import 'package:to_camp/features/camping/view/component/camping_card.dart';

class CampingScreen extends ConsumerWidget {
  const CampingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(campingProvider);
    print(data);
    if (data is PaginationLoading) {
      return LoadingWidget();
    }
    if (data is PaginationError) {
      return Center(child: Text(data.message));
    }
    data as PaginationSuccess<CampingModel>;
    return ListView.separated(
      itemCount: data.response.body.items.item.length,
      itemBuilder: (context, index) {
        final model = data.response.body.items.item[index];

        return GestureDetector(
          onTap: () {
            ref
                .read(campingServiceProvider)
                .onCampingCardTap(context, model);
          },
          child: CampingCard.fromModel(model: model),
        );
      },
      separatorBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.only(bottom: 8.0, right: 16, left: 16),
          child: Divider(),
        );
      },
    );
  }
}
