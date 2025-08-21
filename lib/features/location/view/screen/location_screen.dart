import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/theme/component/loading_widget.dart';
import 'package:to_camp/features/location/model/location_model.dart';
import 'package:to_camp/features/location/provider/location_provider.dart';
import 'package:to_camp/features/location/view/screen/location_error_screen.dart';
import 'package:to_camp/features/location/view/screen/map_screen.dart';

class LocationScreen extends ConsumerWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(locationProvider);

    if (locationState is LocationLoading) {
      return LoadingWidget();
    }
    if (locationState is LocationError) {
      return LocationErrorScreen(message: locationState.message);
    }

    locationState as LocationSuccess;
    return MapScreen(location: locationState);
  }
}
