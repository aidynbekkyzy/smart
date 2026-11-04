import 'package:flutter/material.dart';

/// Контентті үлкен экрандарда (планшет, веб) ортаға шектеп қояды.
class ResponsiveCenter extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  const ResponsiveCenter({super.key, required this.child, this.maxWidth = 600});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}

class Breakpoints {
  Breakpoints._();
  static int gridColumns(double width) {
    if (width >= 1000) return 3;
    if (width >= 650) return 2;
    return 1;
  }
}
