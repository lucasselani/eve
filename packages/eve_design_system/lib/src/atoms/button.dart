import 'package:eve_design_system/src/utils/typedef.dart';
import 'package:flutter/material.dart';

class EveIconButton extends StatelessWidget {
  final OnTap onTap;
  final double internalPadding;
  final double size;
  final IconData icon;

  const EveIconButton({
    Key? key,
    this.internalPadding = 8,
    this.size = 32,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.all(internalPadding),
          child: Icon(
            icon,
            size: size,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      );
}

class EveButton extends StatelessWidget {
  final double _borderRadius = 16;

  final OnTap onTap;
  final String text;

  final bool _enabled;
  final bool _isSolid;

  const EveButton._(
    this._enabled,
    this._isSolid, {
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  factory EveButton.hollow({
    required OnTap onTap,
    required String text,
  }) =>
      EveButton._(true, false, onTap: onTap, text: text);

  factory EveButton.solid({
    required OnTap onTap,
    required String text,
    bool enabled = true,
  }) =>
      EveButton._(enabled, true, onTap: onTap, text: text);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonColor = _isSolid ? theme.primaryColor : Colors.transparent;
    final borderColor = _isSolid ? Colors.transparent : theme.primaryColor;
    return Container(
      height: 64,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: borderColor != Colors.transparent ? 1.5 : 0,
        ),
        borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
        color: _enabled ? buttonColor : buttonColor.withOpacity(0.2),
      ),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(_borderRadius)),
        onTap: onTap,
        child: Center(
          child: Text(
            text,
            style: theme.textTheme.headline1?.copyWith(
              color: _isSolid ? theme.backgroundColor : borderColor,
            ),
          ),
        ),
      ),
    );
  }
}
