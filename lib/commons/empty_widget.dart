import 'package:bti_test_app/services/assets.dart';
import 'package:bti_test_app/services/color_theme.dart';
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final String? description, actionText, image;
  final Widget? titleWidget, descriptionWidget;
  final VoidCallback? action;
  final Color? actionColor;
  final double? imageWidth;

  const EmptyWidget({
    super.key,
    this.description,
    this.action,
    this.actionColor,
    this.actionText,
    this.image,
    this.imageWidth,
    this.titleWidget,
    this.descriptionWidget,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(imageEmptyPage, height: 80.0, fit: BoxFit.contain),
          SizedBox(height: 20.0),
          titleWidget ?? SizedBox(),
          descriptionWidget ??
              SizedBox(
                width: 250.0,
                child: Text(
                  description ?? 'No Data',
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
          if (action != null) ...[
            SizedBox(height: 20.0),
            SizedBox(
              width: 150.0,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: actionColor ?? white,
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  ),
                  child: InkWell(
                    onTap: action,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 8.0,
                      ),
                      child: Center(
                        child: Text(
                          actionText ?? 'Relaod',
                          style: TextStyle(
                            color: actionText != null ? white : grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
