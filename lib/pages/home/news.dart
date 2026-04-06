import 'package:bti_test_app/commons/empty_widget.dart';
import 'package:bti_test_app/commons/lazy-load/custom_lazy_load.dart';
import 'package:bti_test_app/commons/lazy-load/lazy_load_item_list.dart';
import 'package:bti_test_app/commons/visibility.dart';
import 'package:bti_test_app/models/news.dart';
import 'package:bti_test_app/pages/home/widget/news_widget.dart';
import 'package:bti_test_app/router/constants.dart';
import 'package:bti_test_app/services/color_theme.dart';
import 'package:bti_test_app/services/test_key.dart';
import 'package:flutter/material.dart';

class News extends StatefulWidget {
  final List<NewsModel> news;
  final Future<void> Function(bool) getData;
  final bool loading;

  const News({
    super.key,
    required this.news,
    required this.getData,
    this.loading = false,
  });

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  void onTapNews(NewsModel news) {
    Navigator.pushNamed(context, newsDetailRoute, arguments: news);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () => widget.getData(true),
        child: CustomLazyLoad(
          visible: widget.loading,
          onLoad: LazyLoadItemList(),
          child: VisibilityWidget(
            visible: widget.news.isNotEmpty,
            replacement: EmptyWidget(
              action: () => widget.getData(true),
              actionColor: tertiaryColor,
              actionText: 'Reload',
            ),
            child: ListView.separated(
              padding: EdgeInsets.only(left: 24.0, right: 24.0, bottom: 50.0),
              itemCount: widget.news.length,
              separatorBuilder: (context, index) => SizedBox(height: 24.0),
              itemBuilder: (context, index) {
                final item = widget.news[index];
                return InkWell(
                  key: keyNewsItem,
                  onTap: () => onTapNews(item),
                  child: NewsWidget(news: item),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
