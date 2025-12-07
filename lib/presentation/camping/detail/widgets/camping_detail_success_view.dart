import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/core/theme/res/layout.dart';
import 'package:to_camp/data/models/camping_detail_model.dart';
import 'package:to_camp/presentation/camping/detail/widgets/detail_app_bar.dart';
import 'package:to_camp/presentation/camping/detail/widgets/detail_body.dart';
import 'package:to_camp/presentation/camping/detail/widgets/detail_footer.dart';
import 'package:to_camp/presentation/camping/detail/widgets/detail_map.dart';
import 'package:to_camp/presentation/common/widgets/base_custom_scroll_view.dart';

class CampingDetailSuccessView extends ConsumerWidget {
  final CampingDetailModel detail;

  const CampingDetailSuccessView({super.key, required this.detail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _ResponsiveCampingDetailScreen(
      appbar: DetailAppBar(detailModel: detail),
      body: DetailBody(campingModel: detail.campingModel),
      map: DetailMap(model: detail.campingModel),
      footer: DetailFooter(detailModel: detail),
    );
  }
}

class _ResponsiveCampingDetailScreen extends StatelessWidget {
  final Widget appbar;
  final Widget body;
  final Widget map;
  final Widget footer;

  const _ResponsiveCampingDetailScreen({
    super.key,
    required this.appbar,
    required this.body,
    required this.map,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return context.layout(
      Stack(
        children: [
          BaseCustomScrollView(
            slivers: [
              appbar,
              body,
              SliverToBoxAdapter(child: map),
            ],
          ),

          Align(
            alignment: AlignmentGeometry.bottomCenter,
            child: footer,
          ),
        ],
      ),
      desktop: Row(
        children: [
          Expanded(child: CustomScrollView(slivers: [appbar, body])),
          Expanded(child: Column(children: [map, Spacer(), footer])),
        ],
      ),
    );
  }
}
