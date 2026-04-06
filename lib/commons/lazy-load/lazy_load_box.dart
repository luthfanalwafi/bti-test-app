import 'package:flutter/material.dart';

class BoxLazyLoad extends StatelessWidget {
  final double width, height, radius;
  final EdgeInsetsGeometry margin;

  const BoxLazyLoad({
    super.key,
    this.width = double.infinity,
    this.height = 0.0,
    this.radius = 5.0,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: theme.highlightColor,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
