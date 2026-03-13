import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/presentation/camping/location/widgets/location_camping_success_view.dart';
import 'package:to_camp/presentation/common/widgets/error_message_widget.dart';
import 'package:to_camp/presentation/common/widgets/loading_widget.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/presentation/camping/location/view_model/location_camping_view_model.dart';
import 'package:to_camp/presentation/camping/location/view_model/location_state.dart';
import 'package:to_camp/core/models/pagination_state.dart';

/// 받아온 위치 정보로 지도를 띄우는 화면
class LocationCampingScreen extends ConsumerWidget {
  final LocationState location;
  const LocationCampingScreen({super.key, required this.location});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationCampingState = ref.watch(
      locationCampingViewModelProvider,
    );

    if (locationCampingState is PaginationLoading) {
      return const LoadingWidget();
    }
    if (locationCampingState is PaginationError) {
      return ErrorMessageWidget(
        message: locationCampingState.message,
        onTap: () => ref
            .read(locationCampingViewModelProvider.notifier)
            .paginate(),
      );
    }

    locationCampingState as PaginationSuccess<CampingModel>;
    return LocationCampingSuccessView(
      state: locationCampingState,
      location: location,
    );
  }
}
