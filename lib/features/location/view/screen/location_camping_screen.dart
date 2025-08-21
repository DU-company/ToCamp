import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/common/model/pagination_model.dart';
import 'package:to_camp/common/theme/component/custom_icon_button.dart';
import 'package:to_camp/common/theme/component/error_message_widget.dart';
import 'package:to_camp/common/theme/component/loading_widget.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/common/view/default_layout.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/view/screen/camping_success_screen.dart';
import 'package:to_camp/features/location/provider/location_camping_provider.dart';

class LocationCampingScreen extends ConsumerWidget {
  static String get routeName => 'location';

  const LocationCampingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(locationCampingProvider);

    return DefaultLayout(child: body(data, ref));
  }

  Widget body(PaginationState data, WidgetRef ref) {
    if (data is PaginationLoading) {
      return LoadingWidget();
    }
    if (data is PaginationError) {
      return ErrorMessageWidget(
        message: data.message,
        onTap: () {
          ref.read(locationCampingProvider.notifier).paginate();
        },
      );
    }
    data as PaginationSuccess<CampingModel>;
    return Stack(
      children: [
        CampingSuccessScreen(data: data),
        _MapButton(),
      ],
    );
  }
}

class _MapButton extends ConsumerWidget {
  const _MapButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return Positioned(
      bottom: 32,
      right: 16,
      child: CustomIconButton(
        foregroundColor: theme.color.primary,
        size: 42,
        onTap: () {
          context.pop();
        },
        icon: PhosphorIcons.mapPinArea(),
      ),
    );
  }
}
