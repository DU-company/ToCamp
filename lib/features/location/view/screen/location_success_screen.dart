import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:to_camp/features/location/model/location_model.dart';

class LocationSuccessScreen extends StatelessWidget {
  final LocationSuccess location;
  const LocationSuccessScreen({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('성공!'));
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(location.lat, location.lng),
        zoom: 8,
      ),
    );
  }
}
