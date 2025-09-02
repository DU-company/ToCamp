import 'package:to_camp/features/camping/model/camping_model.dart';

abstract class CampingDetailState {}

class CampingDetailLoading extends CampingDetailState {}

class CampingDetailError extends CampingDetailState {
  final String message;
  CampingDetailError({required this.message});
}

class CampingDetailModel extends CampingDetailState {
  final CampingModel campingModel;
  final List<String> imgUrls;

  CampingDetailModel({
    required this.campingModel,
    required this.imgUrls,
  });
}
