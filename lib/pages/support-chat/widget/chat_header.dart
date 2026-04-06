import 'package:bti_test_app/services/assets.dart';
import 'package:bti_test_app/services/color_theme.dart';
import 'package:flutter/material.dart';

class ChatHeaderWidget extends StatelessWidget {
  const ChatHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppBar(
      elevation: 2.0,
      automaticallyImplyLeading: false,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            child: Icon(Icons.arrow_back, size: 30.0),
          ),
          SizedBox(width: 24.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chat Support',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6.0),
                RichText(
                  text: TextSpan(
                    text: 'Online',
                    style: textTheme.bodyLarge?.copyWith(color: green),
                    children: [
                      TextSpan(
                        text: ' • Typically replies in minutes',
                        style: textTheme.bodyLarge?.copyWith(
                          color: primaryTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 45.0,
            child: CircleAvatar(backgroundImage: AssetImage(iconCS)),
          ),
        ],
      ),
    );
  }
}
