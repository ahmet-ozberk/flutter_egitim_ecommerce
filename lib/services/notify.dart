import 'package:flutter/material.dart';
import 'package:flutter_egitim_ecommerce/constant/app_color.dart';
import 'package:grock/grock.dart';

class Notify {
  static void success(String t) {
    Grock.toast(
        text: t,
        backgroundColor: AppColor.primary,
        textStyle: const TextStyle(color: Colors.white),
        alignment: Alignment.center);
  }

  static void unsuccess(String t) {
    Grock.toast(
        text: t,
        backgroundColor: Colors.red,
        textStyle: const TextStyle(color: Colors.white),
        alignment: Alignment.center);
  }
}
