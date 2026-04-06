import 'package:bti_test_app/models/news.dart';
import 'package:bti_test_app/models/news_categories.dart';
import 'package:bti_test_app/services/api.dart';
import 'package:bti_test_app/services/news_categories.dart';
import 'package:bti_test_app/services/sqflite/table/bookmark.dart';
import 'package:bti_test_app/services/sqflite/table/news.dart';
import 'package:flutter/material.dart';

class NewsProvider extends ChangeNotifier {
  NewsCategoryModel _category = newsCategories[0];
  NewsCategoryModel get category => _category;
  set category(NewsCategoryModel value) {
    _category = value;
    notifyListeners();
  }

  List<NewsModel> _bookmark = [];
  List<NewsModel> get bookmark => _bookmark;
  set bookmark(List<NewsModel> value) {
    _bookmark = value;
    notifyListeners();
  }

  Future<List<NewsModel>> getDataDb(String category) async {
    final db = NewsDB();
    try {
      final response = await db.getNewsByCategory(category);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> insertNews(String category, List<NewsModel> news) async {
    final db = NewsDB();
    try {
      await db.insert(category, news);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getBookmark() async {
    final db = BookmarkDB();
    try {
      final response = await db.getNews();
      bookmark = response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> insertBookmark(NewsModel news) async {
    final db = BookmarkDB();
    try {
      await db.insert(news);
      await getBookmark();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteBookmark(String title) async {
    final db = BookmarkDB();
    try {
      await db.delete(title);
      await getBookmark();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<NewsModel>?> getHeadlineNews(
    NewsCategoryModel category,
    bool refresh,
  ) async {
    try {
      List<NewsModel> news = [];
      final data = await getDataDb(category.name);
      if (data.isEmpty || refresh) {
        Map<String, dynamic> body = {'category': category.key};
        final response = await Api.getHeadlineNews(body);
        if (response != null) {
          final articles = response['articles'] as List?;
          news = articles != null && articles.isNotEmpty
              ? articles
                    .map((f) => NewsModel.fromJson(f, category.name))
                    .toList()
              : [];
          await insertNews(category.name, news);
        }
      } else {
        news = data;
      }
      return news;
    } catch (e) {
      rethrow;
    }
  }
}
