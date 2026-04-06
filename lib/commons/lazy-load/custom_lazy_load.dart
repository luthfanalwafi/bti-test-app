import 'package:bti_test_app/commons/visibility.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomLazyLoad extends StatelessWidget {
  final bool visible;
  final Widget onLoad;
  final Widget child;
  const CustomLazyLoad({
    super.key,
    this.visible = false,
    required this.onLoad,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return VisibilityWidget(
      visible: visible,
      replacement: child,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: onLoad,
      ),
    );
  }
}
