import 'package:bti_test_app/commons/lazy-load/lazy_load_box.dart';
import 'package:flutter/material.dart';

class LazyLoadItemList extends StatelessWidget {
  final int row;
  final EdgeInsetsGeometry? padding;

  const LazyLoadItemList({
    super.key,
    this.row = 10,
    this.padding = const EdgeInsets.all(24.0),
  });
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ListView.separated(
        padding: padding,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: BoxLazyLoad(height: 30.0),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(color: Colors.grey);
        },
        itemCount: row,
      ),
    );
  }
}
