import 'package:flutter/material.dart';
import 'package:flutter_egitim_ecommerce/constant/app_color.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Function()? onTap;
  const CustomButton({super.key, this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primary,
        minimumSize: const Size(double.infinity, 44),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        )
      ),
      child: Text(text ?? "Button"),
    );
  }
}
