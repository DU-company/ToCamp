import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:to_camp/common/exception/location_exception.dart';
import 'package:to_camp/common/pagination/model/pagination_model.dart';
import 'package:to_camp/common/pagination/model/pagination_params.dart';
import 'package:to_camp/features/location/utils/location_utils.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/repository/camping_repository.dart';
import 'package:to_camp/features/location/model/location_model.dart';
import 'package:to_camp/features/location/provider/location_provider.dart';
import 'package:to_camp/features/location/view/component/platform_map_widget.dart';

final locationCampingServiceProvider = Provider((ref) {
  final campingRepository = ref.watch(campingRepositoryProvider);
  return LocationCampingService(
    campingRepository: campingRepository,
    ref: ref,
  );
});

class LocationCampingService {
  final CampingRepository campingRepository;
  final Ref ref;
  LocationCampingService({
    required this.campingRepository,
    required this.ref,
  });

  Future<PaginationSuccess<CampingModel>> paginate() async {
    try {
      double? lat;
      double? lng;
      int take = 50;
      double radius = 20000;

      final cameraPosition = ref.read(cameraPositionProvider);
      if (cameraPosition != null) {
        lat = cameraPosition.target.latitude;
        lng = cameraPosition.target.longitude;
        radius = LocationUtils.radiusByZoom(cameraPosition.zoom);
        take = LocationUtils.takeByZoom(cameraPosition.zoom);
      }
      final location = ref.read(locationProvider);

      if (location is LocationSuccess) {
        final params = PaginationParams(
          pageNo: 1,
          lat: lat ?? location.lat,
          lng: lng ?? location.lng,
          take: take,
          radius: radius,
        );
        final resp = await campingRepository.locationBasedPaginate(
          params,
        );

        final items = resp.items;

        final pItems = LocationUtils.sortByDistance(
          items,
          lat ?? location.lat,
          lng ?? location.lng,
        );
        return PaginationSuccess(
          items: pItems,
          totalCount: resp.totalCount,
        );
      } else {
        throw '실패';
      }
    } catch (e, s) {
      print('$e $s');
      throw FailedLocationPaginate();
    }
  }

  Future<void> onMarkerTap({
    required List<CampingModel> models,
    required CampingModel model,
  }) async {
    if (models.isEmpty) return;

    final mapController = ref.read(mapControllerProvider);

    final index = models.indexWhere((e) => e.id == model.id);

    if (mapController != null) {
      ref.read(locationIndexProvider.notifier).state = index;

      await mapController.animateCamera(
        CameraUpdate.newLatLng(LatLng(model.lat, model.lng)),
      );

      ref.read(showCardProvider.notifier).state = true;

      mapController.showMarkerInfoWindow(MarkerId(model.id));
    }
  }
}
