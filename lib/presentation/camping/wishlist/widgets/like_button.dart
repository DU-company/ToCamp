import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/presentation/common/widgets/custom_icon_button.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/presentation/camping/wishlist/widgets/bottom_sheet/select_category_bottom_sheet.dart';
import 'package:to_camp/presentation/camping/wishlist/wishlist_view_model.dart';
import 'package:to_camp/presentation/camping/wishlist/utils/wishlist_utils.dart';

class LikeButton extends ConsumerWidget {
  final CampingModel campingModel;
  final double size;
  final double position;
  final bool isDetail;
  const LikeButton({
    super.key,
    required this.campingModel,
    this.position = 4,
    this.size = 28,
    this.isDetail = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isDetail) {
      return _Button(campingModel: campingModel, size: size);
    }
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
    required this.size,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final wishlist = ref.watch(wishlistViewModelProvider);
    final isLiked = WishlistUtils.checkIsLiked(wishlist, campingModel);

    return CustomIconButton(
      onTap: () => ref
          .read(wishlistViewModelProvider.notifier)
          .onLikePressed(
            context: context,
            isLiked: isLiked,
            campingModel: campingModel,
          ),
      size: size,
      backgroundColor: theme.color.surface,
      foregroundColor: isLiked
          ? theme.color.secondary
          : theme.color.text,
      icon: isLiked ? PhosphorIconsFill.heart : PhosphorIcons.heart(),
    );
  }
}
