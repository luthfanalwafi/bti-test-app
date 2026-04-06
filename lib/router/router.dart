import 'package:bti_test_app/models/news.dart';
import 'package:bti_test_app/pages/home/index.dart';
import 'package:bti_test_app/pages/index.dart';
import 'package:bti_test_app/pages/login/index.dart';
import 'package:bti_test_app/pages/news-detail/index.dart';
import 'package:bti_test_app/pages/support-chat/index.dart';
import 'package:bti_test_app/router/constants.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final uri = Uri.parse(settings.name ?? '');

    switch (uri.path) {
      case loginRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => LoginPage(),
        );
      case mainRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MainPage(),
        );
      case homeRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => HomePage(),
        );
      case newsDetailRoute:
        final argument = settings.arguments as NewsModel;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => NewsDetailPage(news: argument),
        );
      case supportChatRoute:
        final argument = settings.arguments as NewsModel;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SupportChatPage(news: argument),
        );
      default:
        return null;
    }
  }
}
