import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/theme/component/custom_icon_button.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';

class InputField extends ConsumerWidget {
  final String hint;
  // final String? labelText;
  final TextEditingController? controller;
  final void Function(String text)? onChanged;
  final void Function(String text)? onSubmitted;
  final void Function()? onClear;
  final int? maxLine;
  final int? minLine;
  final bool isNumber;
  final bool isName;
  final bool autoFocus;
  final FocusNode? focusNode;
  final bool enabled;
  const InputField({
    super.key,
    required this.hint,
    // this.labelText,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.maxLine,
    this.minLine,
    this.focusNode,
    this.isName = false,
    this.isNumber = false,
    this.autoFocus = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return TextField(
      maxLines: maxLine,
      minLines: minLine,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      autofocus: autoFocus,
      controller: controller,
      focusNode: focusNode,

      /// 텍스트 스타일
      style: theme.typo.subtitle1,

      enabled: enabled,

      /// 커서 색상
      cursorColor: theme.color.primary,
      decoration: InputDecoration(
        hintText: hint,
        // labelText: labelText,
        // labelStyle: theme.typo.,
        filled: true,
        fillColor: theme.color.hintContainer,
        border: OutlineInputBorder(
          /// 테두리 삭제
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),

          /// 테두리 둥글게
          borderRadius: BorderRadius.circular(12),
        ),

        /// 힌트 스타일
        hintStyle: theme.typo.subtitle1.copyWith(
          fontWeight: theme.typo.light,
          color: theme.color.onHintContainer,
        ),

        /// padding
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),

        /// 삭제 버튼
        suffixIcon: (onClear == null || controller == null)
            ? null
            : Padding(
                padding: const EdgeInsets.all(4.0),
                child: CustomIconButton(
                  onTap: onClear,
                  icon: Icons.close,
                  size: 16,
                  backgroundColor: theme.color.subtext,
                  foregroundColor: theme.color.surface,
                ),
              ),
      ),

      /// 숫자만 입력 가능하게
      keyboardType: isNumber ? TextInputType.number : null,
      inputFormatters: [
        if (isNumber) FilteringTextInputFormatter.digitsOnly,
        if (isName)
          FilteringTextInputFormatter.allow(
            RegExp(r'[a-zA-Z\u0E00-\u0E7F0-9]'),
          ),
      ],
    );
  }
}
