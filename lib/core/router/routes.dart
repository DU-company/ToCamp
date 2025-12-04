import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/core/view/root_tab.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/features/camping/search/search_result/search_result_screen.dart';
import 'package:to_camp/features/camping/view/screen/camping_screen.dart';
import 'package:to_camp/features/camping_detail/view/screen/camping_detail_screen.dart';
import 'package:to_camp/features/camping_detail/view/screen/shared_camping_detail_screen.dart';
import 'package:to_camp/features/image/view/screen/image_detail_screen.dart';
import 'package:to_camp/features/image/view/screen/image_grid_screen.dart';
import 'package:to_camp/features/like/view/screen/camping_like_screen.dart';

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
          path: 'detail/:id',
          name: CampingDetailScreen.routeName,
          builder: (_, state) {
            final id = state.pathParameters['id']!;
            return CampingDetailScreen(id: id);
          },
        ),

        /// Extra로 imgUrls 받기
        GoRoute(
          path: 'imageGrid',
          name: ImageGridScreen.routeName,
          builder: (_, state) {
            final imgUrls = state.extra as List<String>;
            return ImageGridScreen(imgUrls: imgUrls);
          },
        ),
        GoRoute(
          path: 'imageDetail',
          name: ImageDetailScreen.routeName,
          builder: (_, state) {
            final imgUrls = state.extra as List<String>;
            return ImageDetailScreen(imgUrls: imgUrls);
          },
        ),
        GoRoute(
          path: 'search-result/:keyword',
          name: SearchResultScreen.routeName,
          builder: (_, state) {
            final keyword = state.pathParameters['keyword']!;
            return SearchResultScreen(keyword: keyword);
          },
        ),
        GoRoute(
          path: 'wishlist/:id/:name',
          name: WishlistScreen.routeName,
          builder: (_, state) {
            final id = state.pathParameters['id']!;
            final name = state.pathParameters['name']!;
            return WishlistScreen(categoryId: id, categoryName: name);
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
