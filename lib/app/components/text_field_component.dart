import 'package:ezy_shop/app/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';

class TextFieldComponent extends StatefulWidget {
  final String? hint;

  final TextInputAction? textInputAction;
  final Function(String? value) onChanged;

  final double? fontSize;
  final Color textFontColor;
  final String font;
  final FontWeight fontWeight;
  final EdgeInsets padding;
  final bool isFullValidate;
  final Widget? suffixIcon;
  final bool isPasswordField;
  final Color? prefixIconColor;
  final bool isRemoveBottomBorder;
  final InputBorder? inputDecorationBorder;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final TextEditingController? textController;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  const TextFieldComponent({
    super.key,
    this.hint,
    this.suffixIcon,
    required this.onChanged,
    this.isFullValidate = true,
    this.isPasswordField = false,
    this.fontSize = TextSize.textSmallFontSize,
    this.font = AppFont.primaryFont,
    this.fontWeight = AppFontWeight.mediumFontWeight,
    this.textFontColor = AppColors.kTextColor,
    this.prefixIconColor = AppColors.primaryColor,
    this.textInputAction = TextInputAction.done,
    this.isRemoveBottomBorder = true,
    this.inputDecorationBorder,
    this.floatingLabelBehavior,
    this.padding = const EdgeInsets.all(8.0),
    this.textController,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  State<TextFieldComponent> createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  bool _fieldVisibility = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: TextFormField(
        controller: widget.textController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (value) {
          widget.onChanged(value);
        },
        style: GoogleFonts.getFont(
          widget.font,
          fontWeight: widget.fontWeight,
          color: widget.textFontColor,
          fontSize: widget.fontSize,
        ),
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        obscureText: widget.isPasswordField == true ? _fieldVisibility : false,
        textInputAction: widget.textInputAction,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.kWhiteColor,
           border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
          hintText: widget.hint ?? "",
          hintStyle: const TextStyle(
            color: AppColors.hintColor,
            fontFamily: AppFont.primaryFont,
            fontSize: TextSize.textSmallFontSize,
          ),
          errorMaxLines: 3,
          // border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          suffixIcon: widget.isPasswordField == true
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _fieldVisibility = !_fieldVisibility;
                    });
                  },
                  child: Icon(
                      _fieldVisibility
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.lightPrimaryColor))
              : null,
        ),
      ),
    );
  }
}
