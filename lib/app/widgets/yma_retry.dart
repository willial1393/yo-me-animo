import 'package:flutter/material.dart';

class YMARetry extends StatelessWidget {
  final VoidCallback onRetry;

  const YMARetry({required this.onRetry, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onRetry,
        child: const Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Reintentar'),
                Icon(Icons.refresh),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
