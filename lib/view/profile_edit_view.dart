import 'package:flutter/material.dart';
import 'package:flutter_egitim_ecommerce/constant/app_color.dart';
import 'package:flutter_egitim_ecommerce/widgets/custom_button.dart';
import 'package:flutter_egitim_ecommerce/widgets/custom_textfield.dart';

class ProfileEditView extends StatefulWidget {
  const ProfileEditView({super.key});

  @override
  State<ProfileEditView> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: const Text("Profilimi Düzenle"),
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
              child: Text("İsim Soyisim"),
            ),
            CustomTextfield(hintText: "İsim Soyisim", fillColor: Colors.grey.shade200),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Email Adresi"),
            ),
            CustomTextfield(hintText: "Email Adresi", fillColor: Colors.grey.shade200),
            const Spacer(),
            CustomButton(
              text: "Güncelle",
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
