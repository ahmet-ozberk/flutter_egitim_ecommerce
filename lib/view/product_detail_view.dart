import 'package:flutter/material.dart';
import 'package:flutter_egitim_ecommerce/constant/app_color.dart';
import 'package:flutter_egitim_ecommerce/model/product_detail_model.dart';
import 'package:flutter_egitim_ecommerce/services/api_service.dart';
import 'package:flutter_egitim_ecommerce/services/notify.dart';
import 'package:flutter_egitim_ecommerce/widgets/custom_button.dart';

class ProductDetailView extends StatefulWidget {
  final int id;
  const ProductDetailView({super.key, required this.id});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  int quantity = 1;
  int pageViewActiveIndex = 0;
  double price = 179.99;
  ProductDetailModelData? model;
  bool isLoading = false;

  void getData() {
    isLoading = true;
    final data = {"productId": widget.id};
    ApiService.productDetail(data).then((value) {
      if (value != null && value.status == true) {
        setState(() {
          model = value.data!;
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
    getData();
  }

  // quantity değerini arttırmak için kullanılacak
  void increment() {
    setState(() {
      quantity++;
    });
  }

  // quantity değerini azaltmak için kullanılacak
  void deincrement() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bottomSafeArea = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      bottomSheet: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: bottomSafeArea),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${(model?.price ?? 1) * quantity} ₺",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () => deincrement(),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade400,
                        ),
                        child: const Icon(Icons.remove),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        quantity.toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    InkWell(
                      onTap: () => increment(),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.pink,
                  maximumSize: Size(size.width * 0.3, 36),
                  minimumSize: Size(size.width * 0.3, 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
              icon: const Icon(Icons.add_shopping_cart_rounded),
              label: const Text("Ekle"),
            ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : SafeArea(
              top: false,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: size.height * 0.4,
                        child: PageView.builder(
                          itemCount: model?.image?.length ?? 0,
                          onPageChanged: (activeIndex) {
                            setState(() {
                              pageViewActiveIndex = activeIndex;
                            });
                          },
                          itemBuilder: (context, index) {
                            final item = model?.image?[index];
                            return Image.network(
                              "https://e-ticaret-api.onrender.com/uploads/products/${item}",
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.arrow_back_ios_new),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  "${pageViewActiveIndex + 1}/${model?.image?.length ?? 0}",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 12,
                        right: 12,
                        child: Container(
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white, boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                            )
                          ]),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${model?.price ?? 0.0} ₺",
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: List.generate(
                            5,
                            (index) => Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Icon(
                                Icons.star,
                                color: index < 4 ? Colors.orange : Colors.grey.shade300,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      model?.title ?? "Bu ürünün başlık bilgisi bulunmuyor",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Ürün Açıklaması",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(model?.description ?? "Bu ürün için açıklama bulunmuyor"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
