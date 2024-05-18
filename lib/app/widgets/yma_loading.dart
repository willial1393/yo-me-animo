import 'package:flutter/material.dart';
import 'package:movies_app/app/theme/colors.dart';

class YMALoading extends StatelessWidget {
  final bool linear;
  final bool small;

  const YMALoading({super.key, this.linear = false, this.small = false});

  @override
  Widget build(BuildContext context) {
    if (linear) {
      return const LinearProgressIndicator(
        color: EColor.primary,
      );
    }
    return Center(
      child: SizedBox(
        height: small ? 20 : null,
        width: small ? 20 : null,
        child: const CircularProgressIndicator(
          color: EColor.primary,
        ),
      ),
    );
  }
}
