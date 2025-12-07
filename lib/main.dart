import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:to_camp/core/const/data.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/core/router/app_router.dart';

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
