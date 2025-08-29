import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/common/view/root_tab.dart';
import 'package:to_camp/features/camping_detail/view/screen/camping_detail_screen.dart';
import 'package:to_camp/features/camping_detail/view/screen/shared_camping_detail_screen.dart';
import 'package:to_camp/features/like/view/screen/camping_like_screen.dart';
import 'package:to_camp/features/location/view/screen/location_camping_screen.dart';
import 'package:to_camp/features/serach/view/search_result/screen/search_result_screen.dart';


final routesProvider = Provider((ref) => GoRoutes());

class GoRoutes {
  final List<RouteBase> routes = [
    GoRoute(
      path: '/',
      name: RootTab.routeName,
      builder: (_, _) => RootTab(),
      routes: [
        GoRoute(
          path: 'detail',
          name: CampingDetailScreen.routeName,
          builder: (_, state) {
            final id = state.uri.queryParameters['id']!;
            return CampingDetailScreen(id: id);
          },
        ),
        GoRoute(
          path: 'searchResult',
          name: SearchResultScreen.routeName,
          builder: (_, state) {
            final keyword = state.uri.queryParameters['keyword']!;
            return SearchResultScreen(keyword: keyword);
          },
        ),
        GoRoute(
          path: 'location',
          name: LocationCampingScreen.routeName,
          builder: (_, _) => LocationCampingScreen(),
        ),
        GoRoute(
          path: 'like',
          name: CampingLikeScreen.routeName,
          builder: (_, state) {
            final id = state.uri.queryParameters['id']!;
            return CampingLikeScreen(id: id);
          },
        ),
        GoRoute(
          path: 'shared',
          name: SharedCampingDetailScreen.routeName,
          builder: (_, state) {
            final id = state.uri.queryParameters['id']!;
            final name = state.uri.queryParameters['name']!;
            return SharedCampingDetailScreen(id: id, name: name);
          },
        ),
      ],
    ),
  ];

  String? redirectLogic(GoRouterState state) {
    print(state.uri);
  }
}
