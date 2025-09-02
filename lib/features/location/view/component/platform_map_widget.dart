import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/like/model/camping_like_model.dart';
import 'package:to_camp/features/like/provider/camping_like_provider.dart';
import 'package:to_camp/features/like/utils/like_utils.dart';
import 'package:to_camp/features/location/model/location_model.dart';
import 'package:to_camp/features/location/provider/marker_icon_provider.dart';
import 'package:to_camp/features/location/service/location_camping_service.dart';

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
    final likeModels = ref.watch(campingLikeProvider);

    return PlatformMap(
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.location.lat, widget.location.lng),
        zoom: 12,
      ),
      rotateGesturesEnabled: false,
      // minMaxZoomPreference: MinMaxZoomPreference(8, 12),
      onMapCreated: (controller) async {
        await Future.delayed(Duration(milliseconds: 100));
        ref.read(mapControllerProvider.notifier).state = controller;
        if (widget.models.isNotEmpty) {
          controller.showMarkerInfoWindow(
            MarkerId(widget.models.first.id),
          );
        }
      },
      onCameraIdle: () {
        if (mapController != null) {
          ref.read(showRefreshProvider.notifier).state = true;
        }
      },
      onCameraMoveStarted: () {
        if (mapController != null) {
          ref.read(showCardProvider.notifier).state = false;
        }
      },
      onCameraMove: (position) => onCameraMove(position, ref),
      markers: markerIcons.isEmpty
          ? {}
          : Set.from(
              setMarkersFromModels(
                likeModels,
                markerIcons,
                mapController,
              ),
            ),
      myLocationEnabled: true,
    );
  }

  List<Marker> setMarkersFromModels(
    List<CampingLikeModel> likeModels,
    List<Uint8List> markerIcons,
    PlatformMapController? mapController,
  ) {
    final models = widget.models;
    return List.generate(models.length, (index) {
      final model = models[index];
      final isLiked = LikeUtils.checkIsLiked(likeModels, model);
      return Marker(
        markerId: MarkerId(model.id),
        icon: BitmapDescriptor.fromBytes(
          markerIcons[isLiked ? 1 : 0],
        ),
        position: LatLng(model.lat, model.lng),
        consumeTapEvents: true,
        onTap: () {
          ref
              .read(locationCampingServiceProvider)
              .onMarkerTap(models: models, model: model);
        },
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
