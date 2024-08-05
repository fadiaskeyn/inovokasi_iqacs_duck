import 'package:flutter/material.dart';
import 'package:mobile_gmf/Theme.dart';

class RegisterField extends StatefulWidget {
  const RegisterField({
    super.key,
    required this.isLoading,
    this.prefixIcon,
    this.hint,
    this.label,
    this.keyType,
    this.maxLenght,
    this.isPassword,
    this.validator,
    this.controller,
  });

  final bool isLoading;
  final IconData? prefixIcon;
  final String? hint;
  final String? label;
  final TextInputType? keyType;
  final int? maxLenght;
  final bool? isPassword;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  @override
  State<RegisterField> createState() => _RegisterFieldState();
}

class _RegisterFieldState extends State<RegisterField> {
  var textLength = 0;

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscuringCharacter: '*',
      keyboardType: widget.keyType,
      enabled: !widget.isLoading,
      cursorColor: Colors.black,
      maxLength: widget.maxLenght,
      obscureText: widget.isPassword == true ? !showPassword : false,
      decoration: InputDecoration(
          suffixText: widget.maxLenght != null
              ? '$textLength/${widget.maxLenght}'
              : null,
          suffixIcon: widget.isPassword == true
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  child: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                    color: const Color(0xff228896),
                  ))
              : null,
          counterText: '',
          contentPadding: const EdgeInsets.all(10),
          prefixIcon: Container(
              width: 50,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  color: bluetogreenColor),
              child: Icon(
                widget.prefixIcon,
                color: Colors.white,
              )),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: bluetogreenColor),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: bluetogreenColor),
              borderRadius: BorderRadius.circular(10)),
          hintText: widget.hint,
          hintStyle: greyTextStyle,
          labelText: widget.label,
          labelStyle: greyTextStyle),
      onChanged: (val) {
        setState(() {
          textLength = val.length;
        });
      },
    );
  }
}
