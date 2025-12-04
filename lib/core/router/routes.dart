import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/features/camping/wishlist/wishlist_detail_screen.dart';
import 'package:to_camp/features/common/screen/root_tab.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/features/camping/search/search_result/search_result_screen.dart';
import 'package:to_camp/features/camping/base/camping_screen.dart';
import 'package:to_camp/features/camping_detail/view/screen/camping_detail_screen.dart';
import 'package:to_camp/features/camping_detail/view/screen/shared_camping_detail_screen.dart';
import 'package:to_camp/features/image/view/screen/image_detail_screen.dart';
import 'package:to_camp/features/image/view/screen/image_grid_screen.dart';

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
          path: 'image-grid',
          name: ImageGridScreen.routeName,
          builder: (_, state) {
            final imgUrls = state.extra as List<String>;
            return ImageGridScreen(imgUrls: imgUrls);
          },
        ),
        GoRoute(
          path: 'image-detail',
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
          path: 'wishlist-detail/:id/:name',
          name: WishlistDetailScreen.routeName,
          builder: (_, state) {
            final id = state.pathParameters['id']!;
            final name = state.pathParameters['name']!;
            return WishlistDetailScreen(id: id, name: name);
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
