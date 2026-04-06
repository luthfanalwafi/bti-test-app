import 'dart:async';
import 'dart:io';
import 'package:bti_test_app/commons/photo_view.dart';
import 'package:bti_test_app/commons/visibility.dart';
import 'package:bti_test_app/models/chat.dart';
import 'package:bti_test_app/models/news.dart';
import 'package:bti_test_app/pages/support-chat/widget/chat_action.dart';
import 'package:bti_test_app/services/auto_reply.dart';
import 'package:bti_test_app/services/image_picker_modal.dart';
import 'package:bti_test_app/pages/support-chat/widget/chat_header.dart';
import 'package:bti_test_app/services/color_theme.dart';
import 'package:bti_test_app/services/modals.dart';
import 'package:bti_test_app/services/snackbar.dart';
import 'package:bti_test_app/services/sqflite/table/support_chat.dart';
import 'package:bti_test_app/services/utils.dart';
import 'package:flutter/material.dart';

class SupportChatPage extends StatefulWidget {
  final NewsModel news;
  const SupportChatPage({super.key, required this.news});

  @override
  State<SupportChatPage> createState() => _SupportChatPageState();
}

class _SupportChatPageState extends State<SupportChatPage> {
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  List<ChatModel> messages = [];
  String botTypingMsg = 'CS is typing...';

  bool _botTyping = false;
  set botTyping(bool value) {
    setState(() => _botTyping = value);
  }

  @override
  void initState() {
    super.initState();

    messages.add(
      ChatModel(
        text: "Hello! I'm your support assistant. How can I help?",
        time: getTime(),
        isUser: false,
      ),
    );

    getChatHistory();
  }

  String getTime() {
    return Utils.timeFormat(DateTime.now());
  }

  void sendMessage() async {
    final text = controller.text.trim();

    if (text.isEmpty) return;

    messages.add(ChatModel(text: text, time: getTime(), isUser: true));
    botTyping = true;
    controller.clear();
    scrollToBottom();

    final reply = generateBotReply(text);
    await Future.delayed(Duration(seconds: 2));
    messages.add(ChatModel(text: reply, time: getTime(), isUser: false));
    await insertChat(messages);

    botTyping = false;

    scrollToBottom();
  }

  void scrollToBottom() {
    Future.delayed(Duration(milliseconds: 200), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> getChatHistory() async {
    final db = SupportChatDB();
    final newsTitle = widget.news.title ?? '';
    try {
      final response = await db.getChatHistory(newsTitle);

      if (response.isNotEmpty) {
        setState(() {
          messages = response;
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> insertChat(List<ChatModel> chats) async {
    final db = SupportChatDB();
    final newsTitle = widget.news.title ?? '';
    try {
      await db.insert(newsTitle, chats);
    } catch (e) {
      rethrow;
    }
  }

  Widget buildMessage(ChatModel msg) {
    final border = BorderRadius.only(
      topLeft: Radius.circular(20.0),
      topRight: Radius.circular(20.0),
      bottomLeft: Radius.circular(msg.isUser ? 20.0 : 0.0),
      bottomRight: Radius.circular(msg.isUser ? 0.0 : 20.0),
    );
    return Column(
      children: [
        Align(
          alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 6.0),
            padding: msg.imagePath == null ? EdgeInsets.all(12.0) : null,
            constraints: BoxConstraints(maxWidth: 250.0),
            decoration: BoxDecoration(
              color: msg.isUser ? primaryColor : grey.withValues(alpha: 0.2),
              borderRadius: border,
            ),
            child: VisibilityWidget(
              visible: msg.imagePath == null,
              replacement: InkWell(
                onTap: () => onTapImage(msg.imagePath ?? ''),
                child: ClipRRect(
                  borderRadius: border,
                  child: Image.file(
                    File(msg.imagePath ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              child: Text(
                msg.text ?? '',
                style: TextStyle(
                  color: msg.isUser ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
              left: msg.isUser ? 0.0 : 8.0,
              right: msg.isUser ? 8.0 : 0.0,
            ),
            child: Text(msg.time),
          ),
        ),
      ],
    );
  }

  void onTapImage(String imageString) {
    File image = File(imageString);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PhotoViewPage(file: image)),
    );
  }

  void modalImage() async {
    FocusScope.of(context).requestFocus(FocusNode());
    try {
      final result = await Modals.showMaterialModal(
        context: context,
        builder: CameraPickerModal(),
      );
      if (result != null) {
        result as File;
        messages.add(
          ChatModel(imagePath: result.path, time: getTime(), isUser: true),
        );
        await insertChat(messages);
      }
    } catch (e) {
      if (!mounted) return;
      showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: ChatHeaderWidget(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: EdgeInsets.all(12.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return buildMessage(messages[index]);
              },
            ),
          ),

          if (_botTyping)
            Container(
              padding: EdgeInsets.all(18.0),
              child: Text(botTypingMsg, style: TextStyle(color: green)),
            ),

          ChatsActionWidget(
            controller: controller,
            sendMessage: sendMessage,
            modalImage: modalImage,
          ),
        ],
      ),
    );
  }
}
