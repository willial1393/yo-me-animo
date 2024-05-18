import 'package:flutter/material.dart';
import 'package:movies_app/app/theme/colors.dart';
import 'package:movies_app/app/widgets/yma_menu.dart';

class EScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final VoidCallback? onBack;
  final VoidCallback? onFloatAction;
  final Widget? floatActionIcon;

  const EScaffold({
    required this.title,
    required this.body,
    this.onFloatAction,
    this.onBack,
    this.floatActionIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: EColor.primary,
      ),
      drawer: onBack != null ? null : const YMAMenu(),
      body: SafeArea(child: body),
      floatingActionButton: onFloatAction == null
          ? null
          : FloatingActionButton(
              onPressed: onFloatAction,
              shape: const CircleBorder(
                side: BorderSide(color: EColor.primary, width: 2),
              ),
              child: floatActionIcon ?? const Icon(Icons.search),
            ),
    );
  }
}
