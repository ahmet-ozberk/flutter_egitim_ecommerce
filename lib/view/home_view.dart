import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_egitim_ecommerce/constant/app_color.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int activeCampaingsIndex = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: const Text("Anasayfa"),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.location_on_rounded))],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 30),
          CarouselSlider.builder(
            options: CarouselOptions(
              height: size.height * 0.3,
              viewportFraction: 0.82,
              onPageChanged: (index, reason) {
                setState(() {
                  activeCampaingsIndex = index;
                });
              },
            ),
            itemCount: 6,
            itemBuilder: (context, index, realIndex) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: index == activeCampaingsIndex ? 0 : 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    "https://loremflickr.com/1080/720?random=${index + 1}",
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              6,
              (index) => Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: index == activeCampaingsIndex ? Colors.black : Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
