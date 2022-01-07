import 'package:design_system/src/utils/typedef.dart';
import 'package:flutter/material.dart';

class LeadingBarButton extends StatelessWidget {
  final OnTap? onTap;
  final Color? color;
  final IconData _leading;

  LeadingBarButton.close({this.onTap, this.color, Key? key})
      : _leading = Icons.close,
        super(key: key);

  LeadingBarButton.back({this.onTap, this.color, Key? key})
      : _leading = Icons.chevron_left,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            FocusScope.of(context).unfocus();
            Navigator.of(context).pop();
          },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(16),
        child: Icon(_leading, color: color, size: 16),
      ),
    );
  }
}
