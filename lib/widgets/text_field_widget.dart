import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatefulWidget {
  TextFieldWidget(
      {super.key,
      this.onChanged,
      this.onTap,
      this.validator,
      required this.controller,
      required this.contentPaddingHorizontal,
      required this.contentPaddingVertical,
      required this.hintText,
      required this.color,
      required this.borderColor,
      required this.fontSize,
      this.radius = 0,
      this.fillColor = Colors.transparent,
      this.hintcolor,
      this.textLength = 0,
      this.maxLines = 1,
      this.hintHeight = 0.5,
      this.isTextArea = false,
      this.isReadOnly = false,
      this.isPassword = false,
      this.prefixIcon,
      this.suffixIcon,
      this.isFromAddRemarks = false,
      this.keyboardType = TextInputType.text});
  final void Function(String value)? onChanged;
  final void Function()? onTap;
  final TextEditingController controller;
  final double contentPaddingHorizontal;
  final double contentPaddingVertical;
  final String hintText;
  final double hintHeight;
  final Color color;
  final Color? hintcolor;
  final Color borderColor;
  final Color fillColor;
  final double fontSize;
  final Widget? prefixIcon;
  final double radius;
  final bool isTextArea;
  bool isPassword;
  TextInputType keyboardType;
  final bool isReadOnly;
  final int textLength;
  final int maxLines;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  bool isFromAddRemarks;
  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

bool passwordVisible = false;

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  void initState() {
    super.initState();
    passwordVisible = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: widget.color,
        fontSize: widget.fontSize,
      ),
      onChanged: widget.onChanged,
      textAlignVertical: TextAlignVertical.center,
      onTap: widget.onTap ?? () {},
      readOnly: widget.isReadOnly,
      keyboardType: widget.isPassword
          ? TextInputType.visiblePassword
          : widget.keyboardType,
      maxLength: (widget.isTextArea)
          ? widget.textLength
          : widget.isFromAddRemarks
              ? null
              : null,
      maxLines: (widget.isTextArea)
          ? widget.maxLines
          : widget.isFromAddRemarks
              ? 5
              : 1,
      obscureText: passwordVisible,
      textAlign: TextAlign.left,
      controller: widget.controller,
      validator: widget.validator,
      decoration: InputDecoration(
        hintMaxLines: 1,
        hintTextDirection: TextDirection.ltr,
        isCollapsed: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          height: widget.hintHeight,
          color: widget.hintcolor ?? widget.color,
          fontSize: widget.fontSize - 1,
        ),
        errorStyle: const TextStyle(
          height: 0.1,
          fontSize: 10,
        ),
        suffixIcon: widget.suffixIcon ??
            (widget.isPassword
                ? IconButton(
                    icon: Icon(
                      passwordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.grey,
                      size: 18,
                    ),
                    onPressed: () {
                      setState(
                        () {
                          passwordVisible = !passwordVisible;
                        },
                      );
                    },
                  )
                : const SizedBox.shrink()),
        fillColor: widget.fillColor,
        filled: true,
        contentPadding: EdgeInsets.symmetric(
            horizontal: widget.contentPaddingHorizontal,
            vertical: widget.contentPaddingVertical),
        prefixIcon: widget.prefixIcon,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: widget.borderColor),
        ),
      ),
    );
  }
}
