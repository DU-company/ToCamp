import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final SERVICE_KEY = dotenv.env['SERVICE_KEY'];

const LIKE_BOX = 'likeBox';
const CART_BOX = 'cartBox';
const RECENT_SEARCH_BOX = 'recentSearchBox';
const RECENT_CAMPING_BOX = 'recentCampingBox';
const THEME_BOX = 'THEME_BOX';

final LatLngBounds koreaBounds = LatLngBounds(
  southwest: const LatLng(33.0905, 125.7801), // 남서쪽 위도와 경도
  northeast: const LatLng(38.5920, 130.9204), // 북동쪽 위도와 경도
);
