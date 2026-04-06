import 'package:bti_test_app/models/news.dart';
import 'package:bti_test_app/services/color_theme.dart';
import 'package:bti_test_app/services/utils.dart';
import 'package:flutter/material.dart';

class NewsDetailBody extends StatelessWidget {
  final NewsModel news;
  const NewsDetailBody({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;
    final source = news.source ?? SourceModel();
    final sourceTitle = source.name ?? '';
    final dateTime = Utils.parseDate(news.date);
    final date = Utils.dateFormatddMMMMyyyy(dateTime);
    final category = news.category;
    return Positioned(
      top: screenHeight * 0.4 - 50.0,
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                news.title ?? '',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('$sourceTitle • $date', style: textTheme.bodyMedium),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: red,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    child: Text(
                      category ?? '',
                      style: textTheme.bodyMedium?.copyWith(color: white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.0),
              Text(news.description ?? '', style: textTheme.bodyMedium),
              SizedBox(height: 24.0),
              Text(news.content ?? '', style: textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
