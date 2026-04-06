import 'package:bti_test_app/models/news.dart';
import 'package:bti_test_app/pages/news-detail/widget/news_detail_body.dart';
import 'package:bti_test_app/provider/news_provider.dart';
import 'package:bti_test_app/router/constants.dart';
import 'package:bti_test_app/services/assets.dart';
import 'package:bti_test_app/services/color_theme.dart';
import 'package:bti_test_app/services/modals.dart';
import 'package:bti_test_app/services/snackbar.dart';
import 'package:bti_test_app/services/test_key.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsDetailPage extends StatefulWidget {
  final NewsModel news;
  const NewsDetailPage({super.key, required this.news});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  bool _addedToBookmark = false;
  set addedToBookmark(bool value) {
    setState(() => _addedToBookmark = value);
  }

  List<NewsModel> _bookmarkNews = [];
  set bookmarkNews(List<NewsModel> value) {
    setState(() => _bookmarkNews = value);
  }

  @override
  void initState() {
    super.initState();
    checkBookmark();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> checkBookmark() async {
    final prov = Provider.of<NewsProvider>(context, listen: false);
    bookmarkNews = prov.bookmark;
    addedToBookmark = false;
    for (var item in _bookmarkNews) {
      if (item.title == widget.news.title) addedToBookmark = true;
    }
  }

  void addToBookmark() async {
    final prov = Provider.of<NewsProvider>(context, listen: false);
    Modals.loading(context: context);
    try {
      await prov.insertBookmark(widget.news);
      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      showSnackBar(context, e.toString());
    }
    checkBookmark();
  }

  void deleteFromBookmark() async {
    final prov = Provider.of<NewsProvider>(context, listen: false);
    Modals.loading(context: context);
    final title = widget.news.title;
    try {
      if (title != null) await prov.deleteBookmark(title);
      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context);
      showSnackBar(context, e.toString());
    }
    checkBookmark();
  }

  Widget actionButton({
    required Alignment alignment,
    required EdgeInsetsGeometry padding,
    required IconData icon,
    required VoidCallback onPressed,
    Color? iconColor,
    Key? key,
  }) {
    return Align(
      alignment: alignment,
      child: Container(
        padding: padding,
        child: IconButton(
          key: key,
          onPressed: onPressed,
          icon: Icon(icon, color: iconColor),
          iconSize: 32.0,
          style: IconButton.styleFrom(
            backgroundColor: Colors.white,
            shape: CircleBorder(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: screenHeight * 0.4,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(widget.news.urlImage ?? ''),
                fit: BoxFit.cover,
              ),
            ),
          ),
          actionButton(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 24.0, left: 24.0),
            icon: Icons.arrow_back,
            onPressed: () => Navigator.pop(context),
          ),
          actionButton(
            key: keyBookmarkBtn,
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(top: 24.0, right: 24.0),
            icon: Icons.bookmark,
            iconColor: _addedToBookmark ? primaryColor : null,
            onPressed: _addedToBookmark ? deleteFromBookmark : addToBookmark,
          ),
          Stack(
            children: [
              NewsDetailBody(news: widget.news),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: EdgeInsets.only(bottom: 24.0, right: 24.0),
                  child: InkWell(
                    key: keyOpenChat,
                    onTap: () => Navigator.pushNamed(
                      context,
                      supportChatRoute,
                      arguments: widget.news,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [primaryColor, primaryColor, secondaryColor],
                        ),
                      ),
                      child: Image.asset(iconBubbleChat, scale: 1.5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
