import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:share_plus/share_plus.dart';
import 'package:to_camp/common/const/data.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';

abstract class DeepLinkUtils {
  static Future<void> shareLink(
    BuildContext context,
    CampingModel model,
  ) async {
    final box = context.findRenderObject() as RenderBox?;
    final uri = getShortLink(model);
    final params = ShareParams(
      uri: uri,
      subject: '투캠에서 확인해보세요!',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
    await SharePlus.instance.share(params);
  }

  static Future<void> shareEmail(
    BuildContext context,
    String email,
  ) async {
    final box = context.findRenderObject() as RenderBox?;

    final params = ShareParams(
      text: email,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
    await SharePlus.instance.share(params);
  }

  static Uri getShortLink(CampingModel model) {
    final String baseUrl = SUPABASE_URL;

    final uri = Uri.parse(baseUrl).replace(
      path: 'functions/v1/share_camp_site',
      queryParameters: {'id': model.id, 'name': model.name},
    );

    print(uri);
    return uri;
  }
}
