import 'package:bti_test_app/commons/empty_widget.dart';
import 'package:bti_test_app/commons/visibility.dart';
import 'package:bti_test_app/models/news.dart';
import 'package:bti_test_app/pages/home/widget/news_widget.dart';
import 'package:bti_test_app/provider/news_provider.dart';
import 'package:bti_test_app/router/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  void onTapNews(NewsModel news) {
    Navigator.pushNamed(context, newsDetailRoute, arguments: news);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 1.2,
        title: Text('Bookmark'),
      ),
      body: Consumer<NewsProvider>(
        builder: (context, prov, _) {
          final items = prov.bookmark;
          return VisibilityWidget(
            visible: items.isNotEmpty,
            replacement: EmptyWidget(),
            child: ListView.separated(
              padding: EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                top: 24.0,
                bottom: 50.0,
              ),
              itemCount: items.length,
              separatorBuilder: (context, index) => SizedBox(height: 24.0),
              itemBuilder: (context, index) {
                final item = items[index];
                return InkWell(
                  onTap: () => onTapNews(item),
                  child: NewsWidget(news: item),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
