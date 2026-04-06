import 'package:bti_test_app/models/news.dart';
import 'package:bti_test_app/pages/home/category.dart';
import 'package:bti_test_app/pages/home/news.dart';
import 'package:bti_test_app/provider/news_provider.dart';
import 'package:bti_test_app/services/color_theme.dart';
import 'package:bti_test_app/services/news_categories.dart';
import 'package:bti_test_app/services/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  set index(int value) {
    final prov = Provider.of<NewsProvider>(context, listen: false);
    _index = value;
    prov.category = newsCategories[_index];
  }

  List<NewsModel> _news = [];
  set news(List<NewsModel> value) {
    setState(() => _news = value);
  }

  bool _loading = false;
  set loading(bool value) {
    setState(() => _loading = value);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getData([bool refresh = false]) async {
    loading = true;
    await Future.wait([getNews(refresh), getBookmark()]);
    loading = false;
  }

  Future<void> getNews([bool refresh = false]) async {
    final prov = Provider.of<NewsProvider>(context, listen: false);
    final category = prov.category;
    try {
      final result = await prov.getHeadlineNews(category, refresh);
      if (result != null) news = result;
    } catch (e) {
      if (!mounted) return;
      showSnackBar(context, e.toString());
    }
  }

  Future<void> getBookmark() async {
    final prov = Provider.of<NewsProvider>(context, listen: false);
    try {
      await prov.getBookmark();
    } catch (e) {
      if (!mounted) return;
      showSnackBar(context, e.toString());
    }
  }

  void onTapCategory(int i) {
    index = i;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: AlignmentGeometry.topLeft,
                radius: 1.1,
                colors: [primaryColor, tertiaryColor, secondaryColor],
              ),
            ),
          ),

          Positioned(
            top: screenHeight * 0.07,
            child: Container(
              width: screenWidth,
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Top News\nIndonesia',
                      style: textTheme.headlineMedium?.copyWith(
                        color: white,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search, color: white, size: 38.0),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: screenHeight * 0.2,
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 32.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: [
                  NewsCategory(indexCategory: _index, onTap: onTapCategory),
                  SizedBox(height: 24.0),
                  News(news: _news, getData: getData, loading: _loading),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
