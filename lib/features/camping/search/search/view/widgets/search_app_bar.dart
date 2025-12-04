import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/features/common/widgets/input_field.dart';
import 'package:to_camp/features/camping/search/search_result/search_result_view_model.dart';
import 'package:flutter_riverpod/legacy.dart';

final keywordTextEditingController = Provider(
  (ref) => TextEditingController(),
);

final keywordProvider = StateProvider<String>((ref) => '');

class SearchAppBar extends ConsumerWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(keywordTextEditingController);
    final keyword = ref.watch(keywordProvider);
    final keywordNotifier = ref.read(keywordProvider.notifier);
    final viewModel = ref.read(
      searchResultViewModelProvider(keyword).notifier,
    );
    return SliverAppBar(
      floating: true,
      titleSpacing: 8,
      title: InputField(
        hint: '이번 캠핑은 어디로 가시나요?',
        maxLine: 1,
        onChanged: (text) => keywordNotifier.state = text,
        onSubmitted: (text) => viewModel.onSearch(context),
        controller: controller,
        onClear: keyword.isEmpty ? null : () => viewModel.onClear(),
      ),
    );
  }
}
