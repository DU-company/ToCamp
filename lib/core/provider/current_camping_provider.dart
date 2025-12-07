import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:flutter_riverpod/legacy.dart';

final selectedCampingProvider = StateProvider<CampingModel?>(
  (ref) => null,
);
