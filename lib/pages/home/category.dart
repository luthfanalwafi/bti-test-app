import 'package:bti_test_app/services/color_theme.dart';
import 'package:bti_test_app/services/news_categories.dart';
import 'package:flutter/material.dart';

class NewsCategory extends StatefulWidget {
  final int indexCategory;
  final void Function(int) onTap;
  const NewsCategory({
    super.key,
    required this.indexCategory,
    required this.onTap,
  });

  @override
  State<NewsCategory> createState() => _NewsCategoryState();
}

class _NewsCategoryState extends State<NewsCategory> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 40.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 24.0),
        itemCount: newsCategories.length,
        separatorBuilder: (context, i) => SizedBox(width: 12.0),
        itemBuilder: (context, i) {
          final item = newsCategories[i];
          final active = widget.indexCategory == i;
          final name = item.name;
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => widget.onTap(i),
              borderRadius: BorderRadius.all(Radius.circular(18.0)),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(18.0)),
                  color: active
                      ? tertiaryColor
                      : softGrey.withValues(alpha: 0.3),
                ),
                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                child: Text(
                  name,
                  style: textTheme.bodyMedium?.copyWith(
                    color: active ? white : black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
