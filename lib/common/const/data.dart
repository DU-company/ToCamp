import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';

final SERVICE_KEY = dotenv.env['SERVICE_KEY']!;
final SUPABASE_URL = dotenv.env['SUPABASE_URL']!;
final SUPABASE_ANON_KEY = dotenv.env['SUPABASE_ANON_KEY']!;

const LIKE_BOX = 'likeBox';
const CART_BOX = 'cartBox';
const RECENT_KEYWORD_BOX = 'RECENT_KEYWORD_BOX';
const RECENT_CAMPING_BOX = 'recentCampingBox';
const THEME_BOX = 'THEME_BOX';
