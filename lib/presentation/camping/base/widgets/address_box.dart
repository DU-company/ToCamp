import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/core/theme/res/layout.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';

class AddressBox extends ConsumerWidget {
  final String doNm;
  final String sigunguNm;
  final String address;
  final bool isDetail;
  const AddressBox({
    super.key,
    required this.doNm,
    required this.sigunguNm,
    required this.address,
    required this.isDetail,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pAddress = isDetail ? address : '$doNm $sigunguNm';

    final theme = ref.read(themeServiceProvider);

    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        pAddress,
        style: context
            .layout(
              theme.typo.headline6,
              mobile: theme.typo.subtitle1,
            )
            .copyWith(
              color: theme.color.subtext,
              fontWeight: theme.typo.semiBold,
            ),
      ),
    );
  }
}
