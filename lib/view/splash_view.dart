import 'package:flutter/material.dart';
import 'package:flutter_egitim_ecommerce/view/login_view.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => const LoginView()), (route) => false);
    });
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
