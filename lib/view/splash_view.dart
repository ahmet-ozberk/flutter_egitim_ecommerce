import 'package:flutter/material.dart';
import 'package:flutter_egitim_ecommerce/services/storage_servis.dart';
import 'package:flutter_egitim_ecommerce/view/base_view.dart';
import 'package:flutter_egitim_ecommerce/view/login_view.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  void init() async {
    final token = await StorageService.getToken();
    Future.delayed(const Duration(seconds: 1), () {
      if (token == null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginView()),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BaseView()),
          (route) => false,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset("assets/lottie/splash.json"),
      ),
    );
  }
}
