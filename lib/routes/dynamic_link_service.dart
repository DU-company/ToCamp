import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';

abstract class DynamicLinkService {
  static Future<void> shareLink(
    BuildContext context,
    CampingModel model,
  ) async {
    final box = context.findRenderObject() as RenderBox?;
    final uri = getShortLink(model);
    final params = ShareParams(
      uri: uri,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
    await SharePlus.instance.share(params);
  }

  static Uri getShortLink(CampingModel model) {
    final uri = Uri(
      scheme: 'com.du.tocamp',
      host: 'shared',
      queryParameters: {'id': model.id, 'name': model.name},
    );
    // final uri = Uri(
    //   scheme: 'https',
    //   host: 'tocamp.supalink.cc',
    //   path: 'shared',
    //   queryParameters: {'id': model.id, 'name': model.name},
    // );
    print(uri);
    return uri;
  }
}
