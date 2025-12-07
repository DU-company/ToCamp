import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/presentation/camping/location/view_model/location_camping_view_model.dart';
import 'package:to_camp/data/models/wishlist_model.dart';
import 'package:to_camp/presentation/camping/wishlist/utils/wishlist_utils.dart';
import 'package:to_camp/presentation/camping/wishlist/wishlist_view_model.dart';
import 'package:to_camp/presentation/camping/location/view_model/location_state.dart';
import 'package:to_camp/core/provider/marker_icon_provider.dart';
import 'package:flutter_riverpod/legacy.dart';

class CustomMapView extends StatelessWidget {
  final CameraPosition initialCameraPosition;
  final Set<Marker> markers;
  final void Function(PlatformMapController controller)? onMapCreated;
  final void Function(CameraPosition cameraPosition)? onCameraMove;
  final void Function()? onCameraIdle;
  final void Function()? onCameraMoveStarted;
  const CustomMapView({
    super.key,
    required this.initialCameraPosition,
    required this.markers,
    required this.onMapCreated,
    required this.onCameraMoveStarted,
    required this.onCameraMove,
    required this.onCameraIdle,
  });

  @override
  Widget build(BuildContext context) {
    return PlatformMap(
      initialCameraPosition: initialCameraPosition,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      rotateGesturesEnabled: false,
      markers: markers,
      onMapCreated: onMapCreated,
      onCameraMoveStarted: onCameraMoveStarted, // 카메랑 이동 시작 시 한 번 실행
      onCameraMove: onCameraMove, // 카메라 이동 중 상시 실행
      onCameraIdle: onCameraIdle, // 카메라 이동 끝날 때 한 번 실행
    );
  }
}
