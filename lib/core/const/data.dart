import 'package:flutter_dotenv/flutter_dotenv.dart';

/// API KEY
final SERVICE_KEY = dotenv.env['SERVICE_KEY']!;
final SUPABASE_URL = dotenv.env['SUPABASE_URL']!;
final SUPABASE_ANON_KEY = dotenv.env['SUPABASE_ANON_KEY']!;

/// Asset Image
const CAMPING_IMAGE = 'asset/img/camping.png';
const CAMPING_BANNER = 'asset/img/camping_banner.png';
const LOGO_BLACK = 'asset/img/logo_black.svg';
const LOGO_WHITE = 'asset/img/logo_white.svg';
const MARKER = 'asset/img/marker.png';
const MARKER_PINK = 'asset/img/marker_pink.png';

/// Sqflite(Don't Change!!)
const TABLE_WISHLIST_CATEGORY = 'like_categories';
const TABLE_WISHLIST_CAMPING = 'like_campings';
const TABLE_RECENT_CAMPING = 'recent_campings';
const TABLE_RECENT_KEYWORD = 'recent_keywords';
const DB_NAME = 'tocamp.db';

/// ETC
const APP_VERSION = 'v2.1.0';
const EMAIL_ADDRESS = 'du0788754@gmail.com';
