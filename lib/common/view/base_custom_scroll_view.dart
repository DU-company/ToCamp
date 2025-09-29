import 'package:flutter/material.dart';

class BaseCustomScrollView extends StatelessWidget {
  final List<Widget> slivers;
  final bool hasBox;
  const BaseCustomScrollView({
    super.key,
    required this.slivers,
    this.hasBox = true,
  });

  @override
  Widget build(BuildContext context) {
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;

    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: slivers,
          ),
        ),
        if (hasBox) SizedBox(height: safeAreaBottom + 60),
      ],
    );
  }
}
