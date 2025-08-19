import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';

final currentCampingProvider = StateProvider<CampingModel?>(
  (ref) => null,
);
