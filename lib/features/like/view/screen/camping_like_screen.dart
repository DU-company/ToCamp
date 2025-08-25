import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/features/camping/service/camping_service.dart';
import 'package:to_camp/features/like/provider/camping_like_provider.dart';
import 'package:to_camp/features/like/view/component/like_button.dart';
import 'package:to_camp/features/like/view/component/like_camping_card.dart';

class CampingLikeScreen extends ConsumerWidget {
  const CampingLikeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(campingLikeProvider);
    return SafeArea(
      child: ListView.separated(
        itemBuilder: (context, index) {
          final model = data[index];
          return GestureDetector(
            onTap: () {
              ref
                  .read(campingServiceProvider)
                  .onCampingCardTap(context, model);
            },
            child: LikeCampingCard.fromModel(
              model: model,
              likeButton: LikeButton(
                campingModel: model,
                position: 0,
                size: 24,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: data.length,
      ),
    );
  }
}
