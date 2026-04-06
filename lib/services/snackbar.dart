import 'package:flutter/material.dart';

enum SnackBarType { floatingTop, floatingBottom }

void showSnackBar(
  BuildContext context,
  String message, {
  SnackBarType? type,
  VoidCallback? onTap,
  String? actionText,
  double? paddingBottom,
}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    snackBar(
      message: message,
      type: type,
      onTap: onTap,
      actionText: actionText,
      paddingBottom: paddingBottom,
    ),
  );
}

SnackBar snackBar({
  required String message,
  SnackBarType? type,
  VoidCallback? onTap,
  String? actionText,
  double? paddingBottom,
}) {
  switch (type) {
    case SnackBarType.floatingBottom:
      return SnackBar(
        margin: EdgeInsets.fromLTRB(16, 0, 16, paddingBottom ?? 32),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        content: Row(
          children: [
            Expanded(child: Text(message)),
            if (onTap != null) ...[
              const SizedBox(width: 8),
              TextButton(
                onPressed: onTap,
                child: Text(
                  actionText ?? 'Batalkan',
                  style: const TextStyle(color: Color(0xFF1EE3FF)),
                ),
              ),
            ],
          ],
        ),
      );
    default:
      return SnackBar(content: Text(message), behavior: SnackBarBehavior.fixed);
  }
}

// Flushbar<dynamic> showSnackBarCustom(
//   BuildContext context,
//   String message, {
//   double radius = 16,
//   Color color = primaryColor,
//   Color backgroundColor = white,
// }) {
//   return Flushbar(
//     flushbarPosition: FlushbarPosition.TOP,
//     duration: const Duration(seconds: 3),
//     margin: const EdgeInsets.only(left: 16, top: 24, right: 16),
//     backgroundColor: backgroundColor,
//     message: message,
//     messageColor: color,
//     borderRadius: BorderRadius.circular(radius),
//   )..show(context);
// }
