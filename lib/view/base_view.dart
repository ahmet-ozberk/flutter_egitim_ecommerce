import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_egitim_ecommerce/constant/app_color.dart';
import 'package:flutter_egitim_ecommerce/model/bottom_navigationbar_model.dart';
import 'package:flutter_egitim_ecommerce/view/basket_view.dart';
import 'package:flutter_egitim_ecommerce/view/favorite_view.dart';
import 'package:flutter_egitim_ecommerce/view/home_view.dart';
import 'package:flutter_egitim_ecommerce/view/profile_view.dart';

class BaseView extends StatefulWidget {
  const BaseView({super.key});

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  final group = AutoSizeGroup();
  // anasayfa, sepet, favoriler, profil
  List<BottomNavigationbarModel> bottomNavigationItems = [
    BottomNavigationbarModel(icon: Icons.home_filled, title: "Anasayfa", body: const HomeView(), index: 0),
    BottomNavigationbarModel(icon: Icons.shopping_bag_rounded, title: "Sepet", body: const BasketView(), index: 1),
    BottomNavigationbarModel(icon: Icons.favorite, title: "Favorilerim", body: const FavoriteView(), index: 2),
    BottomNavigationbarModel(icon: Icons.person, title: "Profil", body: const ProfileView(), index: 3),
  ];
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      bottomNavigationBar: Container(
        height: 55,
        width: double.infinity,
        margin: EdgeInsets.only(left: 20, right: 20, bottom: bottomPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
            children: bottomNavigationItems.map((item) {
          return Expanded(
            child: IconButton(
              onPressed: () {
                setState(() {
                  activeIndex = item.index;
                });
              },
              icon: Column(
                children: [
                  Icon(
                    item.icon,
                    size: 20,
                    color: activeIndex == item.index ? AppColor.primary : Colors.grey.shade400,
                  ),
                  Expanded(
                    child: AutoSizeText(
                      item.title,
                      group: group,
                      style: TextStyle(
                        fontSize: 14,
                        color: activeIndex == item.index ? AppColor.primary : Colors.grey.shade400,
                      ),
                      minFontSize: 8,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList()),
      ),
      body: bottomNavigationItems[activeIndex].body,
    );
  }
}
