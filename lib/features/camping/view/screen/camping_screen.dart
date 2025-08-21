import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/model/pagination_model.dart';
import 'package:to_camp/common/theme/component/error_message_widget.dart';
import 'package:to_camp/common/theme/component/loading_widget.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/provider/camping_provider.dart';
import 'package:to_camp/features/camping/service/camping_service.dart';
import 'package:to_camp/features/camping/view/component/camping_card.dart';
import 'package:to_camp/features/camping/view/screen/camping_success_screen.dart';

class CampingScreen extends ConsumerWidget {
  const CampingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(campingProvider);
    if (data is PaginationLoading) {
      return LoadingWidget();
    }
    if (data is PaginationError) {
      return ErrorMessageWidget(
        message: data.message,
        onTap: () {
          ref.read(campingProvider.notifier).paginate();
        },
      );
    }
    data as PaginationSuccess<CampingModel>;
    return CampingSuccessScreen(data: data);
  }
}
