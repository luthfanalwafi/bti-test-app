import 'package:bti_test_app/commons/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

const Curve curve = Curves.easeInOut;
const Duration duration = Duration(milliseconds: 300);

class Modals {
  static void loading({
    required BuildContext context,
    bool isDismissible = true,
    bool isDraggable = true,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          alignment: Alignment.center,
          backgroundColor: Colors.transparent,
          content: LoadingWidget(),
        );
      },
    );
  }

  static Future<T?> showMaterialModal<T>({
    required BuildContext context,
    required Widget builder,
    bool isDraggable = true,
    bool isDismissible = true,
  }) async {
    final result = await showMaterialModalBottomSheet<T>(
      context: context,
      enableDrag: isDraggable,
      isDismissible: isDismissible,
      builder: (_) => builder,
      useRootNavigator: false,
      animationCurve: curve,
      duration: duration,
      expand: false,
      backgroundColor: Colors.transparent,
    );
    return result;
  }
}
