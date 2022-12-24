import 'package:flutter/material.dart';
import 'package:flutter_egitim_ecommerce/constant/app_color.dart';
import 'package:flutter_egitim_ecommerce/widgets/custom_button.dart';
import 'package:flutter_egitim_ecommerce/widgets/custom_password_field.dart';

class PasswordUpdateView extends StatefulWidget {
  const PasswordUpdateView({super.key});

  @override
  State<PasswordUpdateView> createState() => _PasswordUpdateViewState();
}

class _PasswordUpdateViewState extends State<PasswordUpdateView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: const Text("Şifremi Değiştir"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Mevcut Şifre"),
            ),
            CustomPasswordField(hintText: "Mevcut Şifre", fillColor: Colors.grey.shade200),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Yeni Şifre"),
            ),
            CustomPasswordField(hintText: "Yeni Şifre", fillColor: Colors.grey.shade200),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Yeni Şifre Tekrar"),
            ),
            CustomPasswordField(hintText: "Yeni Şifre Tekrar", fillColor: Colors.grey.shade200),
            const Spacer(),
            CustomButton(
              text: "Şifremi Güncelle",
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      )),
    );
  }
}
