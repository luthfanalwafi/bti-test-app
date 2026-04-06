import 'package:bti_test_app/services/color_theme.dart';
import 'package:flutter/material.dart';

class LazyLoadCategoryItem extends StatelessWidget {
  final int row;
  final double height, radius;
  final EdgeInsetsGeometry? padding;

  const LazyLoadCategoryItem({
    super.key,
    this.row = 10,
    this.height = 30.0,
    this.radius = 5,
    this.padding = const EdgeInsets.all(20.0),
  });
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.topCenter,
      child: ListView.separated(
        padding: padding,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: white,
              border: BoxBorder.all(color: grey),
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: softGrey,
                    borderRadius: BorderRadius.circular(radius),
                  ),
                ),
                const SizedBox(height: 15.0),
                Container(
                  width: width * 0.5,
                  height: height * 0.7,
                  decoration: BoxDecoration(
                    color: softGrey,
                    borderRadius: BorderRadius.circular(radius),
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 20.0);
        },
        itemCount: row,
      ),
    );
  }
}
