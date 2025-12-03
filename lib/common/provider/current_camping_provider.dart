import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:flutter_riverpod/legacy.dart';
final currentCampingProvider = StateProvider<CampingModel?>(
  (ref) => null,
);
