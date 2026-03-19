import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/presentation/common/widgets/bottom_sheet/base_bottom_sheet.dart';
import 'package:to_camp/presentation/common/widgets/tile.dart';

class WishlistOptionsBottomSheet extends ConsumerWidget {
  final VoidCallback onTapDelete;
  final VoidCallback onTapEditName;
  const WishlistOptionsBottomSheet({
    super.key,
    required this.onTapDelete,
    required this.onTapEditName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.read(themeServiceProvider);

    return BaseBottomSheet(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Tile(
            text: '이름 변경',
            onTap: onTapEditName,
            icon: PhosphorIcons.pencilSimpleLine(),
          ),
          Tile(
            text: '위시리스트 삭제',
            onTap: onTapDelete,
            icon: PhosphorIcons.trashSimple(),
            color: theme.color.secondary,
          ),
        ],
      ),
    );
  }
}
