import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/theme/component/error_message_widget.dart';
import 'package:to_camp/features/camping_detail/provider/camping_detail_provider.dart';

class CampingDetailErrorScreen extends ConsumerWidget {
  final String id;
  final String message;
  const CampingDetailErrorScreen({
    super.key,
    required this.id,
    required this.message,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ErrorMessageWidget(
      message: message,
      onTap: () {
        ref.read(campingDetailProvider(id).notifier).getDetail();
      },
    );
  }
}
