import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final markerIconProvider =
    StateNotifierProvider<MarkerIconProvider, List<Uint8List>>(
      (ref) => MarkerIconProvider(),
    );

class MarkerIconProvider extends StateNotifier<List<Uint8List>> {
  MarkerIconProvider() : super([]) {
    setCustomMapPin();
  }

  void setCustomMapPin() async {
    try {
      Uint8List markerIcon;
      Uint8List likedMarkerIcon;

      markerIcon = await getBytesFromAsset(
        //IOS와 android 상위버전에서는 정상작동하지만 android 하위버전에서는 매우 크게 보인다
        'asset/img/marker.png',
        120,
        // Platform.isIOS ? 120 : 70,
      );
      likedMarkerIcon = await getBytesFromAsset(
        'asset/img/liked_marker.png',
        120,
        // Platform.isIOS ? 120 : 70,
      );
      state = [markerIcon, likedMarkerIcon];
    } catch (e) {
      state = [];
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(
      format: ui.ImageByteFormat.png,
    ))!.buffer.asUint8List();
  }
}
