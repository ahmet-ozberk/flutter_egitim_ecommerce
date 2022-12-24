import 'package:flutter/material.dart';
import 'package:flutter_egitim_ecommerce/constant/app_color.dart';

class CustomPasswordField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final Color fillColor;
  const CustomPasswordField({super.key, this.hintText = "Parola", this.controller, this.fillColor = Colors.white});

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isVisible,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        fillColor: widget.fillColor,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isVisible = !isVisible;
            });
          },
          icon: Icon(
            isVisible ? Icons.visibility_rounded : Icons.visibility_off_rounded,
            color: AppColor.primary,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 0.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 0.5,
          ),
        ),
      ),
    );
  }
}
