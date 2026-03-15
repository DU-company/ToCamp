import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/presentation/camping/location/view_model/location_view_model.dart';
import 'package:to_camp/presentation/common/widgets/dialog/base_confirm_dialog.dart';

class LocationPermissionDialog extends ConsumerWidget {
  final VoidCallback onResume;
  const LocationPermissionDialog({super.key, required this.onResume});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseConfirmDialog(
      title: '위치 접근 권한',
      content: '앱 설정에서 위치 권한을 허용하면 주변 상품 정보를 받아올 수 있습니다.',
      onConfirm: () {
        context.pop();
        Geolocator.openAppSettings();
        onResume();
      },
      confirmMessage: '앱 설정으로 이동',
      cancelMessage: '뒤로 가기',
    );
  }
}
