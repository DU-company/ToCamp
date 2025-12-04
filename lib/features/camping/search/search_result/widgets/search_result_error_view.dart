import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/features/common/widgets/error_message_widget.dart';
import 'package:to_camp/features/camping/base/based_list_view_model.dart';
import 'package:to_camp/features/camping/search/search_result/search_result_view_model.dart';

class SearchResultErrorView extends ConsumerWidget {
  final String keyword;
  final String message;
  const SearchResultErrorView({
    super.key,
    required this.keyword,
    required this.message,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height / 2,
      child: ErrorMessageWidget(
        message: message,
        onTap: () =>
            ref.read(basedListViewModelProvider.notifier).paginate(),
      ),
    );
  }
}
