import 'package:flutter/material.dart';
import 'package:flutter_egitim_ecommerce/view/splash_view.dart';
import 'package:grock/grock.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Grock.navigationKey,
      scaffoldMessengerKey: Grock.scaffoldMessengerKey,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home:const SplashView(),
    );
  }
}
