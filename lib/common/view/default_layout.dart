import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';

class DefaultLayout extends ConsumerWidget {
  final Widget child;
  final Widget? bottomNavigationBar;
  final AppBar? appBar;

  const DefaultLayout({
    super.key,
    required this.child,
    this.bottomNavigationBar,
    this.appBar,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: child,
      backgroundColor: theme.color.surface,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
