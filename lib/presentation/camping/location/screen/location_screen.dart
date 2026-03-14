import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/presentation/common/widgets/loading_widget.dart';
import 'package:to_camp/presentation/camping/location/screen/location_camping_screen.dart';
import 'package:to_camp/presentation/camping/location/view_model/location_state.dart';
import 'package:to_camp/presentation/camping/location/view_model/location_view_model.dart';

/// TODO : Location 및 LocationCamping 의 ViewModel 합치기?

/// GPS로 지도 화면을 보여주는 화면
class LocationScreen extends ConsumerStatefulWidget {
  const LocationScreen({super.key});

  @override
  ConsumerState<LocationScreen> createState() =>
      _LocationScreenState();
}

class _LocationScreenState extends ConsumerState<LocationScreen>
    with WidgetsBindingObserver {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  bool isResumed = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && isResumed) {
      isResumed = false;
      ref.invalidate(locationViewModelProvider);
      print('gd');
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationState = ref.watch(locationViewModelProvider);

    if (locationState is LocationLoading) {
      return const LoadingWidget();
    }

    return LocationCampingScreen(location: locationState);
  }

  void _onTapMyLocation(LocationState location) {
    // final mapController = ref.read(mapControllerProvider);
    // LocationState 가 success면 내 위치로 카메라 이동
    // if (mapController != null) {
    if (location is LocationSuccess) {
      // mapController.animateCamera(
      //   CameraUpdate.newLatLngZoom(
      //     LatLng(pLocation.lat, pLocation.lng),
      //     13,
      //   ),
      // );
      // Error인 경우에는 다이얼로그
    } else {
      final pLocation = location as LocationError;
      if (pLocation.errorType ==
          DeviceLocationErrorType.locationService) {
        // showDialog(
        //   context: context,
        //   builder: (context) => GpsEnableDialog(),
        // );
      } else if (pLocation.errorType ==
          DeviceLocationErrorType.permissionDenied) {
        // showDialog(
        //   context: context,
        //   builder: (context) =>
        //       LocationPermissionDialog(onResume: () {}),
        // );
      } else {
        // ...
      }
    }
  }

  // }
}
