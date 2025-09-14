import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/const/data.dart';
import 'package:to_camp/common/utils/platform_utils.dart';

final markerIconProvider =
    StateNotifierProvider<MarkerIconProvider, List<Uint8List>>(
      (ref) => MarkerIconProvider(),
    );

class MarkerIconProvider extends StateNotifier<List<Uint8List>> {
  MarkerIconProvider() : super([]) {
    setMarkerIcon();
  }

  void setMarkerIcon() async {
    try {
      Uint8List markerIcon;
      Uint8List likedMarkerIcon;

      markerIcon = await getBytesFromAsset(
        MARKER,
        PlatformUtils.setMarkerSize(),
      );
      likedMarkerIcon = await getBytesFromAsset(
        MARKER_PINK,
        PlatformUtils.setMarkerSize(),
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
      allowUpscaling: false,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(
      format: ui.ImageByteFormat.png,
    ))!.buffer.asUint8List();
  }
}
