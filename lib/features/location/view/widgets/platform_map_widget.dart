import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/features/camping/location/location_camping_view_model.dart';
import 'package:to_camp/data/models/wishlist_model.dart';
import 'package:to_camp/features/camping/wishlist/utils/like_utils.dart';
import 'package:to_camp/features/camping/wishlist/wishlist_view_model.dart';
import 'package:to_camp/features/location/view_model/location_state.dart';
import 'package:to_camp/core/provider/marker_icon_provider.dart';
import 'package:flutter_riverpod/legacy.dart';

final cameraPositionProvider = StateProvider<CameraPosition?>(
  (ref) => null,
);

final showRefreshProvider = StateProvider<bool>((ref) => false);
final showCardProvider = StateProvider<bool>((ref) => true);

final mapControllerProvider = StateProvider<PlatformMapController?>(
  (ref) => null,
);

final locationIndexProvider = StateProvider<int>((ref) => 0);

class PlatformMapWidget extends ConsumerStatefulWidget {
  final LocationSuccess location;
  final List<CampingModel> models;
  const PlatformMapWidget({
    required this.location,
    required this.models,
    super.key,
  });

  @override
  ConsumerState<PlatformMapWidget> createState() =>
      _PlatformMapWidgetState();
}

class _PlatformMapWidgetState extends ConsumerState<PlatformMapWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final markerIcons = ref.watch(markerIconProvider);
    final mapController = ref.watch(mapControllerProvider);
    final wishlist = ref.watch(wishlistViewModelProvider);

    return PlatformMap(
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.location.lat, widget.location.lng),
        zoom: 12,
      ),
      rotateGesturesEnabled: false,
      onMapCreated: (controller) async {
        await Future.delayed(Duration(milliseconds: 200));
        ref.read(mapControllerProvider.notifier).state = controller;
        if (widget.models.isNotEmpty) {
          controller.showMarkerInfoWindow(
            MarkerId(widget.models.first.id),
          );
        }
      },

      /// 카메라 이동이 끝날 때
      onCameraIdle: () {
        if (mapController != null) {
          ref.read(showRefreshProvider.notifier).state = true;
        }
      },

      /// 카메라 이동 시작
      onCameraMoveStarted: () {
        if (mapController != null) {
          ref.read(showCardProvider.notifier).state = false;
        }
      },

      /// 카메라 이동 중 상시 실행
      onCameraMove: (position) => onCameraMove(position, ref),
      markers: markerIcons.isEmpty
          ? {}
          : Set.from(
              setMarkersFromModels(
                wishlist,
                markerIcons,
                mapController,
              ),
            ),
    );
  }

  List<Marker> setMarkersFromModels(
    List<WishlistModel> wishlist,
    List<Uint8List> markerIcons,
    PlatformMapController? mapController,
  ) {
    final models = widget.models;
    return List.generate(models.length, (index) {
      final model = models[index];
      final isLiked = LikeUtils.checkIsLiked(wishlist, model);
      return Marker(
        markerId: MarkerId(model.id),
        icon: BitmapDescriptor.fromBytes(
          markerIcons[isLiked ? 1 : 0],
        ),
        position: LatLng(model.lat, model.lng),
        consumeTapEvents: true,
        onTap: () => ref
            .read(locationCampingViewModelProvider.notifier)
            .onMarkerTap(models: models, targetModel: model),

        infoWindow: InfoWindow(
          title: model.name,
          snippet: model.address,
        ),
      );
    });
  }

  void onCameraMove(CameraPosition position, WidgetRef ref) {
    ref.read(cameraPositionProvider.notifier).state = position;
  }
}
