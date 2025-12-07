import 'package:to_camp/data/models/camping_detail_model.dart';

abstract class CampingDetailState {}

class CampingDetailLoading extends CampingDetailState {}

class CampingDetailSuccess extends CampingDetailState {
  final CampingDetailModel detail;

  CampingDetailSuccess(this.detail);
}

class CampingDetailError extends CampingDetailState {
  final String message;

  CampingDetailError(this.message);
}
