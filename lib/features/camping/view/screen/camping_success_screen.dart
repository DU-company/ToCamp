import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/model/pagination_model.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/service/camping_service.dart';
import 'package:to_camp/features/camping/view/component/camping_card.dart';
import 'package:to_camp/features/camping/view/screen/camping_screen.dart';

class CampingSuccessScreen extends ConsumerWidget {
  final PaginationSuccess<CampingModel> data;
  const CampingSuccessScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      itemCount: data.items.length,
      itemBuilder: (context, index) {
        final model = data.items[index];
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
