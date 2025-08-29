import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/serach/model/recent_keyword_model.dart';
import 'package:to_camp/routes/app_router.dart';
import 'common/const/data.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // 세로 모드로 고정
  ]);

  await Supabase.initialize(
    url: SUPABASE_URL,
    anonKey: SUPABASE_ANON_KEY,
  );

  await Hive.initFlutter();
  // Hive.registerAdapter(CampingLikeModelAdapter());
  // Hive.registerAdapter(HiveCampingModelAdapter());
  // Hive.registerAdapter(CampingModelAdapter());
  Hive.registerAdapter(RecentKeywordModelAdapter());
  //
  // await Hive.openBox<CampingModel>(LIKE_BOX); // 찜
  // await Hive.openBox<CampingModel>(RECENT_CAMPING_BOX); // 최근 조회 캠핑장
  await Hive.openBox<RecentKeywordModel>(
    RECENT_KEYWORD_BOX,
  ); // 최근 검색 단어
  // await Hive.openBox<LikeCampingEntity>(CAMPING_LIKE_BOX);
  await Hive.openBox<bool>(THEME_BOX); // 테마

  runApp(const ProviderScope(child: _APP()));
}

class _APP extends ConsumerWidget {
  const _APP({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: theme,
      routerConfig: router,
    );
  }
}
