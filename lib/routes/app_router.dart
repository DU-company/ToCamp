import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/routes/go_routes.dart';

final appRouterProvider = Provider((ref) {
  final routes = ref.watch(routesProvider);
  return GoRouter(
    // navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    routes: routes.routes,
    redirect: (context, state) => routes.redirectLogic(state),
  );
});
