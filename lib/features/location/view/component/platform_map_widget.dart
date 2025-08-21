import 'dart:typed_data';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/location/model/location_model.dart';
import 'package:to_camp/features/location/provider/marker_icon_provider.dart';

final cameraPositionProvider = StateProvider<CameraPosition?>(
  (ref) => null,
);

final showRefreshProvider = StateProvider<bool>((ref) => false);
final showCardProvider = StateProvider<bool>((ref) => true);

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
  PlatformMapController? mapController;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final markerIcons = ref.watch(markerIconProvider);
    return PlatformMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.location.lat, widget.location.lng),
        zoom: 10,
      ),
      rotateGesturesEnabled: false,
      minMaxZoomPreference: MinMaxZoomPreference(8, 12),
      onMapCreated: (controller) async {
        await Future.delayed(Duration(milliseconds: 100));
        mapController = controller;
      },
      onCameraMove: (position) => onCameraMove(position, ref),
      onCameraMoveStarted: () async {
        if (mapController != null) {
          ref.read(showCardProvider.notifier).state = false;
          ref.read(showRefreshProvider.notifier).state = true;
          print('1');
        }
      },
      markers: markerIcons.isEmpty
          ? {}
          : setMarkersFromModels(
              widget.models,
              markerIcons,
              mapController,
            ),
      myLocationEnabled: true,
    );
  }

  Set<Marker> setMarkersFromModels(
    List<CampingModel> models,
    List<Uint8List> markerIcons,
    PlatformMapController? mapController,
  ) {
    Set<Marker> markers = {};
    for (final model in models) {
      final marker = Marker(
        consumeTapEvents: true,
        icon: BitmapDescriptor.fromBytes(markerIcons.first),
        markerId: MarkerId(model.id),
        position: LatLng(model.lat, model.lng),
        onTap: () async {
          final index = models.indexWhere((e) => e.id == model.id);

          if (mapController != null) {
            await mapController.animateCamera(
              CameraUpdate.newLatLngZoom(
                LatLng(model.lat, model.lng),
                12,
              ),
            );
            ref.read(locationIndexProvider.notifier).state = index;
            ref.read(showCardProvider.notifier).state = true;
          }
        },
        infoWindow: InfoWindow(
          title: model.name,
          snippet: model.address,
        ),
      );
      markers.add(marker);
    }

    return markers;
  }

  void onCameraMove(CameraPosition position, WidgetRef ref) {
    ref.read(cameraPositionProvider.notifier).state = position;
  }
}
