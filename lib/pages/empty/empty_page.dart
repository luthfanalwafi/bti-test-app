import 'package:bti_test_app/commons/empty_widget.dart';
import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const EmptyWidget(description: 'Page Not Found'),
    );
  }
}
