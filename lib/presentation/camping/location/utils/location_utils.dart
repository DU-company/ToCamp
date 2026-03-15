import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/data/models/wishlist_model.dart';
import 'package:to_camp/presentation/camping/wishlist/utils/wishlist_utils.dart';

class LocationUtils {
  static double radiusByZoom(double zoom) {
    if (zoom > 12.0) {
      return 15000;
    } else if (zoom > 9.0) {
      return 20000;
    } else {
      return 50000;
    }
  }

  static List<CampingModel> sortByDistance(
    List<CampingModel> models,
    double lat,
    double lng,
  ) {
    models.sort((a, b) {
      final distanceA = Geolocator.distanceBetween(
        lat,
        lng,
        a.lat,
        a.lng,
      );
      final distanceB = Geolocator.distanceBetween(
        lat,
        lng,
        b.lat,
        b.lng,
      );

      return distanceA.compareTo(distanceB);
    });
    return models;
  }

  static List<Marker> createMarkers({
    required List<CampingModel> totalModels,
    required List<WishlistModel> wishlist,
    required List<Uint8List> markerIcons,
    required Function(CampingModel model) onTap,
  }) {
    if (markerIcons.isEmpty) return [];

    return List.generate(totalModels.length, (index) {
      final model = totalModels[index];
      final isLiked = WishlistUtils.checkIsLiked(wishlist, model);
      final markerIcon = BitmapDescriptor.fromBytes(
        markerIcons[isLiked ? 1 : 0],
      );
      return Marker(
        markerId: MarkerId(model.id),
        icon: markerIcon,

        position: LatLng(model.lat, model.lng),
        onTap: () => onTap(model),

        consumeTapEvents: true,
        infoWindow: InfoWindow(
          title: model.name,
          snippet: model.address,
        ),
      );
    });
  }
}
