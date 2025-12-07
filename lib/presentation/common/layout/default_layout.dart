import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/presentation/common/widgets/loading_widget.dart';

class DefaultLayout extends ConsumerWidget {
  final Widget child;
  final Widget? bottomNavigationBar;
  final AppBar? appBar;
  final bool isLoading;

  const DefaultLayout({
    super.key,
    required this.child,
    this.bottomNavigationBar,
    this.appBar,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: appBar,
          body: Stack(
            children: [
              child,

              /// BottomNavi
              Align(
                alignment: Alignment.bottomCenter,
                child: bottomNavigationBar,
              ),
            ],
          ),
          backgroundColor: theme.color.surface,
        ),

        /// Loading Indicator
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: theme.color.background,
              child: isLoading ? LoadingWidget() : null,
            ),
          ),
      ],
    );
  }
}
