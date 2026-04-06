import 'package:flutter/material.dart';

class VisibilityWidget extends StatelessWidget {
  final bool visible;
  final Widget child;
  final Widget replacement;

  const VisibilityWidget({
    super.key,
    this.visible = false,
    required this.child,
    this.replacement = const SizedBox(),
  });
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: visible ? child : replacement,
      layoutBuilder: (currentChild, previousChildren) {
        return currentChild!;
      },
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
