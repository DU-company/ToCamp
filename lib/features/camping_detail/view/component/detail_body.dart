import 'package:flutter/material.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/view/component/camping_card.dart';

class DetailBody extends StatelessWidget {
  final CampingModel campingModel;
  const DetailBody({super.key, required this.campingModel});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: CampingCard.fromModel(
        model: campingModel,
        isDetail: true,
      ),
    );
  }
}
