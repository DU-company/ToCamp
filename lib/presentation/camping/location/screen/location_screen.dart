import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/presentation/common/widgets/error_message_widget.dart';
import 'package:to_camp/presentation/common/widgets/loading_widget.dart';
import 'package:to_camp/presentation/camping/location/screen/location_camping_screen.dart';
import 'package:to_camp/presentation/camping/location/view_model/location_state.dart';
import 'package:to_camp/presentation/camping/location/view_model/location_view_model.dart';

/// TODO : Location 및 LocationCamping 의 ViewModel 합치기?

/// GPS로 지도 화면을 보여주는 화면
class LocationScreen extends ConsumerWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(locationViewModelProvider);

    if (locationState is LocationLoading) {
      return const LoadingWidget();
    }

    return LocationCampingScreen(location: locationState);
  }
}
