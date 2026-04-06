String generateBotReply(String message) {
  final msg = message.toLowerCase();
  bool hasNumber = RegExp(r'\d').hasMatch(msg);

  if (hasNumber) {
    return 'Thanks! I\'ll check the details for you';
  }

  if (msg.contains('hello')) {
    return 'Hello! How can I assist you today?';
  }

  if (msg.contains('order')) {
    return 'Sure, could you please provide your order number?';
  }

  return 'Sorry, I didn\'t understand that. Can you try asking differently?';
}
