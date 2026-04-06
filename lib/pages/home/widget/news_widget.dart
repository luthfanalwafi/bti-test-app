import 'package:bti_test_app/commons/visibility.dart';
import 'package:bti_test_app/models/news.dart';
import 'package:bti_test_app/services/assets.dart';
import 'package:bti_test_app/services/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsWidget extends StatelessWidget {
  final NewsModel news;

  const NewsWidget({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final urlImage = news.urlImage;
    final source = news.source ?? SourceModel();
    final sourceTitle = source.name ?? '';
    final dateTime = Utils.parseDate(news.date);
    final date = Utils.dateFormatddMMMMyyyy(dateTime);
    return Row(
      children: [
        SizedBox(
          height: 100.0,
          width: 100.0,
          child: VisibilityWidget(
            visible: urlImage != null,
            replacement: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(imageDefaut, fit: BoxFit.cover),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: CachedNetworkImage(
                imageUrl: urlImage ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return Center(child: CircularProgressIndicator());
                },
                errorWidget: (context, error, stackTrace) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(imageDefaut, fit: BoxFit.cover),
                  );
                },
              ),
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                news.title ?? '',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text('$sourceTitle • $date', style: textTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}
