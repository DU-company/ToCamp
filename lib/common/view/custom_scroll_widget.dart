import 'package:flutter/material.dart';

class CustomScrollWidget extends StatelessWidget {
  final List<Widget> slivers;
  final bool hasBox;
  const CustomScrollWidget({
    super.key,
    required this.slivers,
    this.hasBox = true,
  });

  @override
  Widget build(BuildContext context) {
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
        if (hasBox) const SizedBox(height: 60),
      ],
    );
  }
}
