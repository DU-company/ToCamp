import 'package:to_camp/data/models/camping_model.dart';

class CampingDetailModel {
  final CampingModel campingModel;
  final List<String> imgUrls;

  CampingDetailModel({
    required this.campingModel,
    required this.imgUrls,
  });
}
