import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/core/theme/component/error_message_widget.dart';
import 'package:to_camp/core/theme/component/loading_widget.dart';
import 'package:to_camp/features/location/view/widgets/location_success_view.dart';
import 'package:to_camp/features/location/view_model/location_state.dart';
import 'package:to_camp/features/location/view_model/location_view_model.dart';

/// GPS로 지도 화면을 보여주는 화면
class LocationScreen extends ConsumerWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(locationViewModelProvider);

    if (locationState is LocationLoading) {
      return LoadingWidget();
    }
    if (locationState is LocationError) {
      return ErrorMessageWidget(
        message: locationState.message,
        onTap: () => ref
            .read(locationViewModelProvider.notifier)
            .getCurrentLocation(),
      );
    }

    locationState as LocationSuccess;
    return LocationSuccessView(location: locationState);
  }
}
