import 'package:flutter/material.dart';

class KFTextField extends StatelessWidget {
  const KFTextField(
      {Key? key,
      this.controller,
      this.hintText,
      this.obscureText = false,
      this.textInputType,
      this.textInputAction,
      this.suffixIcon,
      this.onChanged,
      this.validator,
      this.prefixIcon,
      this.enableSuggestions = true})
      : super(key: key);
  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final bool enableSuggestions;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableSuggestions: enableSuggestions,
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      keyboardType: textInputType,
      textInputAction: textInputAction ?? TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white38)),
          fillColor: Colors.white12,
          filled: true),
    );
  }
}
