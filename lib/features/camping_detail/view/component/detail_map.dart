import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:to_camp/common/theme/component/custom_divider.dart';
import 'package:to_camp/common/theme/component/tile.dart';
import 'package:to_camp/common/theme/res/layout.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/common/utils/toast_utils.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/location/provider/marker_icon_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailMap extends ConsumerWidget {
  final CampingModel model;
  const DetailMap({super.key, required this.model});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 32,
      ),
      child: Column(
        children: [
          context.layout(const CustomDivider(), desktop: SizedBox()),
          _Address(address: model.address),
          const SizedBox(height: 8),
          _Map(model: model),
          const SizedBox(height: 8),
          _Tel(model: model),
        ],
      ),
    );
  }
}

class _Address extends ConsumerWidget {
  final String address;
  const _Address({super.key, required this.address});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    if (address.isEmpty) return SizedBox();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// Location Icon
        Icon(
          PhosphorIconsBold.mapPinArea,
          color: theme.color.primary,
          size: 28,
        ),

        /// Address
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            address,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.typo.subtitle1.copyWith(
              color: theme.color.subtext,
            ),
          ),
        ),

        /// Copy Button
        const SizedBox(width: 8.0),
        InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            Clipboard.setData(ClipboardData(text: address));
            ref
                .read(toastUtilsProvider)
                .showToast(text: '클립보드에 복사되었습니다', isError: false);
          },
          child: Icon(
            PhosphorIconsBold.copy,
            color: theme.color.subtext,
            size: 28,
          ),
        ),
      ],
    );
  }
}

class _Map extends ConsumerWidget {
  final CampingModel model;
  const _Map({super.key, required this.model});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final markerIcons = ref.watch(markerIconProvider);
    late final PlatformMapController? mapController;

    if (model.lat == 0 || model.lng == 0) return SizedBox();

    if (markerIcons.isEmpty) return SizedBox();
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(16),
      child: SizedBox(
        height: 300,
        child: PlatformMap(
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
            Factory<OneSequenceGestureRecognizer>(
              () => EagerGestureRecognizer(),
            ),
          },
          onMapCreated: (controller) async {
            await Future.delayed(Duration(milliseconds: 100));
            mapController = controller;
            if (mapController != null) {
              await mapController!.showMarkerInfoWindow(
                MarkerId(model.id),
              );
            }
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(model.lat, model.lng),
            zoom: 14,
          ),
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          rotateGesturesEnabled: false,
          tiltGesturesEnabled: false,
          zoomControlsEnabled: false,
          markers: {
            Marker(
              markerId: MarkerId(model.id),
              position: LatLng(model.lat, model.lng),
              infoWindow: InfoWindow(
                title: model.name,
                snippet: model.address,
              ),
              icon: BitmapDescriptor.fromBytes(markerIcons.first),
            ),
          },
        ),
      ),
    );
  }
}

class _Tel extends StatelessWidget {
  final CampingModel model;
  const _Tel({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final hasTel = model.tel.isNotEmpty;
    if (!hasTel) return const SizedBox();
    return Tile(
      onTap: () {
        final uri = Uri(scheme: 'tel', path: model.tel);
        launchUrl(uri);
      },
      text: model.tel,
      trailing: PhosphorIcons.phoneTransfer(),
    );
  }
}
