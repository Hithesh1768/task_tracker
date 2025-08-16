import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'themenotifier.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final globalThemeColor = Provider.of<ThemeNotifier>(context).themeColor;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            globalThemeColor.shade700,
            globalThemeColor.shade100,
          ],
        ),
      ),
      child: child,
    );
  }
}
