class ChatModel {
  final String? text;
  final String? imagePath;
  final String time;
  final bool isUser;

  ChatModel({
    this.text,
    this.imagePath,
    required this.time,
    required this.isUser,
  });

  ChatModel.fromDb(Map<String, dynamic> json)
    : text = json['text'],
      imagePath = json['imagePath'],
      time = json['time'],
      isUser = json['isUser'] == 1 ? true : false;

  Map<String, dynamic> toJson() => {
    'text': text,
    'imagePath': imagePath,
    'time': time,
    'isUser': isUser ? 1 : 0,
  };
}
