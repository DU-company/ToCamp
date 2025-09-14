import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/common/view/root_tab.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/view/screen/camping_screen.dart';
import 'package:to_camp/features/camping_detail/view/screen/camping_detail_screen.dart';
import 'package:to_camp/features/camping_detail/view/screen/shared_camping_detail_screen.dart';
import 'package:to_camp/features/image/view/screen/image_detail_screen.dart';
import 'package:to_camp/features/image/view/screen/image_grid_screen.dart';
import 'package:to_camp/features/like/view/screen/camping_like_screen.dart';
import 'package:to_camp/features/search/view/search_result/screen/search_result_screen.dart';

final routesProvider = Provider((ref) => GoRoutes());

class GoRoutes {
  final List<RouteBase> routes = [
    GoRoute(
      path: '/',
      name: RootTab.routeName,
      builder: (_, _) => const RootTab(),
      routes: [
        GoRoute(
          path: 'camping/:title',
          name: CampingScreen.routeName,
          builder: (_, state) {
            final items = state.extra as List<CampingModel>;
            final title = state.pathParameters['title']!;
            return CampingScreen(items: items, title: title);
          },
        ),
        GoRoute(
          path: 'detail',
          name: CampingDetailScreen.routeName,
          builder: (_, state) {
            final id = state.uri.queryParameters['id']!;
            return CampingDetailScreen(id: id);
          },
        ),
        GoRoute(
          path: 'imageGrid',
          name: ImageGridScreen.routeName,
          builder: (_, state) {
            final id = state.uri.queryParameters['id']!;
            return ImageGridScreen(id: id);
          },
        ),
        GoRoute(
          path: 'imageDetail',
          name: ImageDetailScreen.routeName,
          builder: (_, state) {
            final id = state.uri.queryParameters['id']!;
            return ImageDetailScreen(id: id);
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
          path: 'like',
          name: CampingLikeScreen.routeName,
          builder: (_, state) {
            final id = state.uri.queryParameters['id']!;
            final name = state.uri.queryParameters['name']!;
            return CampingLikeScreen(
              categoryId: id,
              categoryName: name,
            );
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
    final uri = state.uri;
    print(uri);
    if (uri.host == 'shared') {
      final id = uri.queryParameters['id'];
      final name = uri.queryParameters['name'];
      return '/shared?id=$id&name=$name';
    } else {
      return null;
    }
  }
}
