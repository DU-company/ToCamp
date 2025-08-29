import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/common/theme/component/custom_icon_button.dart';
import 'package:to_camp/common/theme/component/error_message_widget.dart';
import 'package:to_camp/common/theme/component/primary_button.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
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
    return SingleChildScrollView(
      child: ErrorMessageWidget(
        message: '캠핑장 정보를 불러올 수 없습니다. $id: $message',
        onTap: () {
          ref.read(campingDetailProvider(id).notifier).getDetail();
        },
      ),
    );
  }
}
