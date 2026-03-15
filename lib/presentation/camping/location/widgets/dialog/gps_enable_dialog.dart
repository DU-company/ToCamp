import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/presentation/common/widgets/dialog/base_confirm_dialog.dart';

class GpsEnableDialog extends StatelessWidget {
  const GpsEnableDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseConfirmDialog(
      title: "위치 서비스",
      content:
          '위치 서비스가 비활성화 상태입니다.'
          '\n현재 위치를 가져오기 위해서는 앱 설정에서 위치 서비스(GPS)를 활성화 해주세요.',
      confirmMessage: '앱 설정으로 이동',
      onConfirm: () => context.pop(),
      cancelMessage: '뒤로 가기',
    );
  }
}
