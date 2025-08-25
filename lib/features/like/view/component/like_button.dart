import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/common/theme/component/custom_icon_button.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/like/provider/camping_like_provider.dart';

class LikeButton extends ConsumerWidget {
  final CampingModel campingModel;
  final double size;
  final double position;
  final bool isDetail;
  const LikeButton({
    super.key,
    required this.campingModel,
    this.position = 8,
    this.size = 32,
    this.isDetail = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isDetail)
      return _Button(campingModel: campingModel, size: size);
    return Positioned(
      top: position,
      right: position,
      child: _Button(campingModel: campingModel, size: size),
    );
  }
}

class _Button extends ConsumerWidget {
  final CampingModel campingModel;
  final double size;
  const _Button({
    super.key,
    required this.campingModel,
    this.size = 32,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likeList = ref.watch(campingLikeProvider);
    final theme = ref.watch(themeServiceProvider);
    final isLiked = likeList.any((e) => e.id == campingModel.id);
    return CustomIconButton(
      onTap: () {
        EasyThrottle.throttle('like', Duration(seconds: 1), () {
          ref
              .read(campingLikeProvider.notifier)
              .onLikePressed(campingModel);
        });
      },
      size: size,
      backgroundColor: theme.color.surface,
      foregroundColor: isLiked
          ? theme.color.secondary
          : theme.color.text,
      icon: isLiked ? PhosphorIconsFill.heart : PhosphorIcons.heart(),
    );
  }
}
