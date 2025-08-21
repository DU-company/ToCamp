import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/theme/component/error_message_widget.dart';
import 'package:to_camp/features/location/provider/location_provider.dart';

class LocationErrorScreen extends ConsumerWidget {
  final String message;
  const LocationErrorScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ErrorMessageWidget(
      message: message,
      onTap: () {
        ref.read(locationProvider.notifier).getCurrentLocation();
      },
    );
  }
}
