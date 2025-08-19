import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/common/view/root_tab.dart';
import 'package:to_camp/features/camping_detail/view/screen/camping_detail_screen.dart';

final routesProvider = Provider(
  (ref) => GoRoutes(),
);

class GoRoutes {
  final List<GoRoute> routes = [
    GoRoute(
      path: '/',
      name: RootTab.routeName,
      builder: (_, __) => RootTab(),
    ),
    GoRoute(
      path: '/detail',
      name: CampingDetailScreen.routeName,
      builder: (_, state) {
        final id = state.uri.queryParameters['id']!;
        return CampingDetailScreen(id: id);
      },
    ),
    // GoRoute(
    //   path: '/',
    //   name: RootTab.routeName,
    //   builder: (_, __) => RootTab(),
    // ),
    // GoRoute(
    //   path: '/',
    //   name: RootTab.routeName,
    //   builder: (_, __) => RootTab(),
    // ),
  ];
}
