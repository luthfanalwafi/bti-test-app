import 'package:bti_test_app/services/color_theme.dart';
import 'package:flutter/material.dart';

class CustomNavigationBarItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final void Function()? onTap;

  const CustomNavigationBarItem({
    super.key,
    required this.label,
    required this.icon,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        // width: 48.0,
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? primaryColor : grey),
            SizedBox(height: 4.0),
            Text(
              label,
              style: textTheme.labelSmall?.copyWith(
                color: isSelected ? primaryColor : grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
