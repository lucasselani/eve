import 'package:flutter/material.dart';

enum EveTextType { header, title, paragraph, footer }

class EveText extends StatelessWidget {
  final EveTextType _type;
  final String _text;
  final TextAlign? _textAlign;

  const EveText._(
    this._type,
    this._text,
    this._textAlign, {
    Key? key,
  }) : super(key: key);

  factory EveText.header({required String text, TextAlign? textAlign}) =>
      EveText._(
        EveTextType.header,
        text,
        textAlign,
      );

  factory EveText.title({required String text, TextAlign? textAlign}) =>
      EveText._(
        EveTextType.title,
        text,
        textAlign,
      );

  factory EveText.paragraph({required String text, TextAlign? textAlign}) =>
      EveText._(
        EveTextType.paragraph,
        text,
        textAlign,
      );

  factory EveText.footer({required String text, TextAlign? textAlign}) =>
      EveText._(
        EveTextType.footer,
        text,
        textAlign,
      );

  @override
  Widget build(BuildContext context) => Text(
        _text,
        textAlign: _textAlign,
        overflow: TextOverflow.ellipsis,
        style: _getStyle(context),
      );

  TextStyle? _getStyle(BuildContext context) {
    TextStyle? style;
    if (_type == EveTextType.paragraph) {
      style = Theme.of(context).textTheme.bodyText1;
    } else if (_type == EveTextType.title) {
      style = Theme.of(context).textTheme.bodyText2;
    } else if (_type == EveTextType.header) {
      style = Theme.of(context).textTheme.headline1;
    } else if (_type == EveTextType.footer) {
      style = Theme.of(context).textTheme.overline;
    }
    return style;
  }
}
