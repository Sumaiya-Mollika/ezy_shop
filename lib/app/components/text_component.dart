import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/style.dart';

class TextComponent extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final Color color;
  final double opacity;
  final String font;
  final int? maxLines;
  final bool isTranslatable;
  final bool isHideKeyboard;
  final double? lineHeight;
  final double? letterSpacing;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final EdgeInsets padding;
  final TextOverflow? textOverflow;
  final VoidCallback? onPressed;
  final TextDecoration? textDecoration;
  final TextInputType? keyboardType;

  const TextComponent(
    this.text, {
    super.key,
    this.onPressed,
    this.maxLines,
    this.opacity = 1,
    this.textOverflow,
    this.font = AppFont.primaryFont,
    this.isTranslatable = true,
    this.isHideKeyboard = true,
    this.color = AppColors.kTextColor,
    this.fontSize = TextSize.textFontSize,
    this.textAlign = TextAlign.start,
    this.lineHeight = AppFont.kLineHeight,
    this.letterSpacing = AppFont.kSmallerLetterSpacing,
    this.fontWeight = AppFontWeight.regularFontWeight,
    this.padding = EdgeInsets.zero,
    this.textDecoration,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return onPressed != null
        ? GestureDetector(
            onTapUp: (details) {
              if (isHideKeyboard) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            onTap: onPressed,
            child: _getTextWidget(),
          )
        : _getTextWidget();
  }

  Widget _getTextWidget() {
    return Padding(
      padding: padding,
      child: Text(
        text ?? "",
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: textOverflow,
        style: GoogleFonts.getFont(font,
            fontWeight: fontWeight,
            fontSize: fontSize,
            fontStyle: FontStyle.normal,
            height: lineHeight,
            letterSpacing: letterSpacing,
            color: color.withValues(alpha: opacity),
            decoration: textDecoration),
      ),
    );
  }
}
