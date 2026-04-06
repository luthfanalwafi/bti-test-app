import 'package:bti_test_app/services/color_theme.dart';
import 'package:bti_test_app/services/test_key.dart';
import 'package:flutter/material.dart';

class ChatsActionWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback sendMessage;
  final VoidCallback modalImage;

  const ChatsActionWidget({
    super.key,
    required this.controller,
    required this.sendMessage,
    required this.modalImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            onPressed: modalImage,
            icon: Icon(Icons.image_outlined, color: grey, size: 40.0),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: softGrey.withValues(alpha: 0.2),
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              child: TextField(
                key: keyInputMsg,
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Write your message...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            key: keySendMsgBtn,
            onTap: sendMessage,
            child: Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [primaryColor, primaryColor, secondaryColor],
                ),
              ),
              child: Icon(Icons.arrow_forward, color: white),
            ),
          ),
        ],
      ),
    );
  }
}
