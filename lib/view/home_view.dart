import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_egitim_ecommerce/constant/app_color.dart';
import 'package:flutter_egitim_ecommerce/model/campaign_model.dart';
import 'package:flutter_egitim_ecommerce/services/api_service.dart';
import 'package:flutter_egitim_ecommerce/services/notify.dart';
import 'package:flutter_egitim_ecommerce/view/products_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int activeCampaingsIndex = 0;
  bool isLoading = false;
  List<CampaignModelData?> campaigns = [];

  void getCampaign() {
    isLoading = true;
    ApiService.campaigns().then((value) {
      if (value != null && value.status == true) {
        setState(() {
          campaigns = value.data!;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          Notify.unsuccess("Bir sorun oluştu");
        });
      }
    }).catchError((e) {
      setState(() {
        isLoading = false;
        Notify.unsuccess("Bir sorun oluştu");
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getCampaign();
  }

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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : ListView(
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
                  itemCount: campaigns.length,
                  itemBuilder: (context, index, realIndex) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: index == activeCampaingsIndex ? 0 : 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FadeInImage(
                          image: NetworkImage("https://e-ticaret-api.onrender.com/uploads/slider/${campaigns[index]!.image}"),
                          placeholder: const AssetImage("assets/images/image_loading.gif"),
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
                    campaigns.length,
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
                const Padding(
                  padding: EdgeInsets.only(left: 24, top: 12, bottom: 4),
                  child: Text(
                    "Kategoriler",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    // satırlar arasındaki boşluğu belirler
                    mainAxisSpacing: 12,
                    // sütunmlar arasındaki boşluğu belirler
                    crossAxisSpacing: 16,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductsView(
                              categoryName: "Kategori $index",
                            ),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: FadeInImage(
                                image: NetworkImage("https://loremflickr.com/1080/720?random=${index + 1}"),
                                placeholder: const AssetImage("assets/images/image_loading.gif"),
                                fit: BoxFit.cover,
                                placeholderFit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            "Kategori $index",
                            style: TextStyle(
                              color: Colors.grey.shade900,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
}
