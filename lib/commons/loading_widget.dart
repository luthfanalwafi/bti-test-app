import 'package:bti_test_app/services/assets.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 150.0, child: Image.asset(animationLoading));
  }
}
