import 'package:to_camp/features/camping/model/camping_model.dart';

abstract class DynamicLinkService {
  static Uri getShortLink(CampingModel model) {
    final uri = Uri.https('tocamp.supalink.cc', '/shared', {
      'id': model.id.toString(),
      'name': model.name,
    });
    return uri;
  }
}
