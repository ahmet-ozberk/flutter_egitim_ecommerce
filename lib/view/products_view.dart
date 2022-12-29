import 'package:flutter/material.dart';
import 'package:flutter_egitim_ecommerce/constant/app_color.dart';
import 'package:flutter_egitim_ecommerce/controller/favorite_controller.dart';
import 'package:flutter_egitim_ecommerce/model/products_model.dart';
import 'package:flutter_egitim_ecommerce/services/api_service.dart';
import 'package:flutter_egitim_ecommerce/services/notify.dart';
import 'package:flutter_egitim_ecommerce/view/product_detail_view.dart';

class ProductsView extends StatefulWidget {
  final String categoryName;
  final int categoryId;
  const ProductsView({super.key, required this.categoryName, required this.categoryId});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  List<ProductsModelData?> products = [];
  bool isLoading = false;

  void getData() {
    isLoading = true;
    final data = {"categoryId": widget.categoryId};
    ApiService.products(data).then((value) {
      if (value != null && value.status == true) {
        setState(() {
          products = value.data!;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text(widget.categoryName),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Ara...",
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 0.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 0.5,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
                    ],
                  ),
                ),
                Expanded(
                  child: SafeArea(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.78,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final item = products[index];
                        return Stack(
                          clipBehavior: Clip.none,
                          children: [
                            InkWell(
                              onTap: () => Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => ProductDetailView(id: item.id!))),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey.shade200,
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 4),
                                        child: Banner(
                                          message: "${item?.price ?? 0.0} ₺",
                                          location: BannerLocation.topStart,
                                          color: AppColor.primary,
                                          textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: Image.network(
                                              "https://e-ticaret-api.onrender.com/uploads/products/${item!.image}",
                                              fit: BoxFit.contain,
                                              width: double.infinity,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 4),
                                      child: Text(
                                        item.title ?? "",
                                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: ElevatedButton.icon(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColor.pink,
                                            maximumSize: const Size(double.infinity, 36),
                                            minimumSize: const Size(double.infinity, 32),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            )),
                                        icon: const Icon(Icons.add_shopping_cart_rounded),
                                        label: const Text("Ekle"),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: -8,
                              right: -8,
                              child: Container(
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle, color: Colors.white, boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                  )
                                ]),
                                child: IconButton(
                                  onPressed: () {
                                    if (item.isFavorite == true) {
                                      FavoriteController.removeFavorite(item.id!).then((value) {
                                        if (value != null && value == true) {
                                          setState(() {
                                            item.isFavorite = false;
                                          });
                                        }
                                      });
                                    } else {
                                      FavoriteController.addFavorite(item.id!).then((value) {
                                        if (value != null && value == true) {
                                          setState(() {
                                            item.isFavorite = true;
                                          });
                                        }
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: item.isFavorite == true ? Colors.red : Colors.grey.shade300,
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
