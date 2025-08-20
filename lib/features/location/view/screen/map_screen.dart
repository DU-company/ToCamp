import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/features/location/model/location_model.dart';
import 'package:to_camp/features/location/provider/location_provider.dart';
import 'package:to_camp/features/location/view/screen/location_error_screen.dart';
import 'package:to_camp/features/location/view/screen/location_loading_screen.dart';
import 'package:to_camp/features/location/view/screen/location_success_screen.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(locationProvider);
    if (locationState is LocationLoading) {
      return LocationLoadingScreen();
    }
    if (locationState is LocationError) {
      return LocationErrorScreen(message: locationState.message);
    }

    locationState as LocationSuccess;
    return LocationSuccessScreen(location: locationState);
  }
}
