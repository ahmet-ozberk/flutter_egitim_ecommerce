import 'package:flutter/material.dart';
import 'package:flutter_egitim_ecommerce/constant/app_color.dart';
import 'package:flutter_egitim_ecommerce/services/api_service.dart';
import 'package:flutter_egitim_ecommerce/services/notify.dart';
import 'package:flutter_egitim_ecommerce/services/storage_servis.dart';
import 'package:flutter_egitim_ecommerce/view/base_view.dart';
import 'package:flutter_egitim_ecommerce/view/register_view.dart';
import 'package:flutter_egitim_ecommerce/widgets/custom_button.dart';
import 'package:flutter_egitim_ecommerce/widgets/custom_password_field.dart';
import 'package:flutter_egitim_ecommerce/widgets/custom_textfield.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isVisible = true;
  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    setState(() {
      isLoading = true;
    });
    final data = {"email": emailController.text, "password": passwordController.text};
    ApiService.login(data).then((value) {
      if (value != null && value.status == true) {
        StorageService.setToken(value.token!);
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) => const BaseView()), (route) => false);
      } else {
        setState(() {
          isLoading = false;
        });
        Notify.unsuccess("Bir sorun oluştu, bilgilerinizi kontrol edip tekrar deneyin.");
      }
    }).catchError((e) {
      setState(() {
        isLoading = false;
      });
      Notify.unsuccess("Bir sorun oluştu.");
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: AppColor.pink.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColor.yellow.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: AppColor.orange.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.2),
                  const Text(
                    "Giriş Yap",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    height: size.height * 0.32,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 10)),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomTextfield(
                          hintText: "Email Adresi",
                          controller: emailController,
                        ),
                        CustomPasswordField(
                          controller: passwordController,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator.adaptive())
                        : CustomButton(
                            text: "Giriş Yap",
                            onTap: () => login(),
                          ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Hesabın yok mu?"),
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterView()));
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Kayıt Ol",
                            style: TextStyle(
                              color: AppColor.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
