import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_egitim_ecommerce/constant/app_color.dart';
import 'package:flutter_egitim_ecommerce/model/previous_order_model.dart';

class PreviousOrdersView extends StatefulWidget {
  const PreviousOrdersView({super.key});

  @override
  State<PreviousOrdersView> createState() => _PreviousOrdersViewState();
}

class _PreviousOrdersViewState extends State<PreviousOrdersView> {
  List<PreviousOrderModel> orders = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 6; i++) {
      orders.add(PreviousOrderModel(
        orders: [
          OrderModel(
            image: "https://loremflickr.com/1080/720?random=${i + 1}",
            name: "Product $i",
            price: Random().nextDouble() * 100,
            quantity: i + 1,
          ),
          OrderModel(
            image: "https://loremflickr.com/1080/720?random=${i + 2}",
            name: "Product ${i+1}",
            price: Random().nextDouble() * 100,
            quantity: i + 1,
          ),
        ],
        address: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        status: i % 2 == 0,
        totalPrice: ((i + 1) * 10) * 2,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: const Text("Önceki Siparişlerim"),
        centerTitle: true,
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 16,),
        padding: EdgeInsets.all(20),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final item = orders[index];
          return orderWidget(item);
        },
      ),
    );
  }

  Widget orderWidget(PreviousOrderModel model) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ExpansionTile(
          childrenPadding: const EdgeInsets.all(14),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                model.status ? "Teslim Edildi" : "Teslim Edilmedi",
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Text(
                "${model.totalPrice} ₺",
                style: const TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "Adres: ${model.address}",
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            ...model.orders.map(
              (e) => ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    e.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(e.name),
                subtitle: Text("${e.price.toStringAsFixed(2)} ₺"),
                trailing: CircleAvatar(
                  child: Text(e.quantity.toString()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
