// ignore_for_file: public_member_api_docs, sort_constructors_first
class PreviousOrderModel {
  List<OrderModel> orders;
  String address;
  bool status;
  double totalPrice;
  PreviousOrderModel({
    required this.orders,
    required this.address,
    required this.status,
    required this.totalPrice,
  });
}

class OrderModel {
  String name;
  double price;
  int quantity;
  String image;
  OrderModel({
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
  });
}
