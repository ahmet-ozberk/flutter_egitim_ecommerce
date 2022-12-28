import 'package:flutter/material.dart';
import 'package:flutter_egitim_ecommerce/view/base_view.dart';
import 'package:flutter_egitim_ecommerce/view/home_view.dart';
import 'package:flutter_egitim_ecommerce/widgets/custom_button.dart';
import 'package:lottie/lottie.dart';

class BasketCompleteView extends StatelessWidget {
  const BasketCompleteView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Lottie.asset('assets/lottie/basket_complete.json',height: size.height*0.3),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleText("Sipariş Numarası"),
                  descriptionText("14235"),
                  titleText("Adres"),
                  descriptionText("Random adres bilgileri içeriri bu text"),
                  titleText("Toplam Tutar"),
                  descriptionText("456.99 ₺"),
                  titleText("Ödeme Türü"),
                  descriptionText("Krei Kartı")
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                text: "Anasayfaya Dön",
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const BaseView()),
                    (route) => false,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Container descriptionText(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(
          color: Colors.white,
          width: 2,
        ),
        right: BorderSide(
          color: Colors.white,
          width: 2,
        ),
      )),
      child: Text(text),
    );
  }

  Widget titleText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, color: Colors.grey.shade800),
      ),
    );
  }
}
