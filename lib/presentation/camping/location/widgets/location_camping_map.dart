import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:to_camp/core/const/data.dart';
import 'package:to_camp/core/provider/marker_icon_provider.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/data/models/wishlist_model.dart';
import 'package:to_camp/presentation/camping/location/view_model/location_camping_view_model.dart';
import 'package:to_camp/presentation/common/widgets/custom_map_view.dart';
import 'package:to_camp/presentation/camping/location/view_model/location_state.dart';
import 'package:to_camp/presentation/camping/wishlist/utils/wishlist_utils.dart';
import 'package:to_camp/presentation/camping/wishlist/wishlist_view_model.dart';

final cameraPositionProvider = StateProvider<CameraPosition?>(
  (ref) => null,
);

final showRefreshProvider = StateProvider<bool>((ref) => false);
final showCardProvider = StateProvider<bool>((ref) => true);

final mapControllerProvider = StateProvider<PlatformMapController?>(
  (ref) => null,
);
final locationIndexProvider = StateProvider<int>((ref) => 0);

class LocationCampingMap extends ConsumerStatefulWidget {
  final LocationState location;
  final List<CampingModel> models;
  const LocationCampingMap({
    super.key,
    required this.location,
    required this.models,
  });

  @override
  ConsumerState<LocationCampingMap> createState() =>
      _LocationCampingMap();
}

class _LocationCampingMap extends ConsumerState<LocationCampingMap>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  late LatLng initialLatLng;

  @override
  void initState() {
    super.initState();
    if (widget.location is LocationSuccess) {
      final location = widget.location as LocationSuccess;
      initialLatLng = LatLng(location.lat, location.lng);
    } else {
      // 서울의 lat lng
      initialLatLng = const LatLng(LAT_OF_SEOUL, LNG_OF_SEOUL);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final markerIcons = ref.watch(markerIconProvider);
    final mapController = ref.watch(mapControllerProvider);
    final wishlist = ref.watch(wishlistViewModelProvider);

    return CustomMapView(
      initialCameraPosition: CameraPosition(
        target: initialLatLng,
        zoom: 12,
      ),
      markers: Set.from(setMarkersFromModels(wishlist, markerIcons)),
      onMapCreated: _onMapCreated,
      onCameraMoveStarted: () => _onCameraMoveStarted(mapController),
      onCameraMove: (cameraPosition) => _onCameraMove(cameraPosition),
      onCameraIdle: () => _onCameraIdle(mapController),
    );
  }

  List<Marker> setMarkersFromModels(
    List<WishlistModel> wishlist,
    List<Uint8List> markerIcons,
  ) {
    if (markerIcons.isEmpty) return [];

    final models = widget.models;
    return List.generate(models.length, (index) {
      final model = models[index];
      final isLiked = WishlistUtils.checkIsLiked(wishlist, model);
      final markerIcon = BitmapDescriptor.fromBytes(
        markerIcons[isLiked ? 1 : 0],
      );
      return Marker(
        markerId: MarkerId(model.id),
        icon: markerIcon,

        position: LatLng(model.lat, model.lng),
        onTap: () => _onTapMarker(models, model),
        consumeTapEvents: true,
        infoWindow: InfoWindow(
          title: model.name,
          snippet: model.address,
        ),
      );
    });
  }

  void _onTapMarker(
    List<CampingModel> models,
    CampingModel targetModel,
  ) {
    ref
        .read(locationCampingViewModelProvider.notifier)
        .onTapMarker(models: models, targetModel: targetModel);
  }

  void _onCameraMove(CameraPosition cameraPosition) {
    ref.read(cameraPositionProvider.notifier).state = cameraPosition;
  }

  void _onMapCreated(PlatformMapController controller) async {
    final models = widget.models;

    await Future.delayed(const Duration(milliseconds: 200));
    ref.read(mapControllerProvider.notifier).state = controller;
    if (models.isNotEmpty) {
      controller.showMarkerInfoWindow(MarkerId(models.first.id));
    }
  }

  void _onCameraIdle(PlatformMapController? mapController) {
    if (mapController != null) {
      ref.read(showRefreshProvider.notifier).state = true;
    }
  }

  void _onCameraMoveStarted(PlatformMapController? mapController) {
    if (mapController != null) {
      ref.read(showCardProvider.notifier).state = false;
    }
  }
}
