///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class ProductsModelData {
/*
{
  "id": 1,
  "image": "9180091875378.jpg",
  "price": 800,
  "title": "Nokia",
  "isFavorite": false
} 
*/

  int? id;
  String? image;
  int? price;
  String? title;
  bool? isFavorite;

  ProductsModelData({
    this.id,
    this.image,
    this.price,
    this.title,
    this.isFavorite,
  });
  ProductsModelData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toInt();
    image = json['image']?.toString();
    price = json['price']?.toInt();
    title = json['title']?.toString();
    isFavorite = json['isFavorite'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['price'] = price;
    data['title'] = title;
    data['isFavorite'] = isFavorite;
    return data;
  }
}

class ProductsModel {
/*
{
  "message": "Ürünler başarıyla getirildi",
  "status": true,
  "data": [
    {
      "id": 1,
      "image": "9180091875378.jpg",
      "price": 800,
      "title": "Nokia",
      "isFavorite": false
    }
  ]
} 
*/

  String? message;
  bool? status;
  List<ProductsModelData?>? data;

  ProductsModel({
    this.message,
    this.status,
    this.data,
  });
  ProductsModel.fromJson(Map<String, dynamic> json) {
    message = json['message']?.toString();
    status = json['status'];
  if (json['data'] != null) {
  final v = json['data'];
  final arr0 = <ProductsModelData>[];
  v.forEach((v) {
  arr0.add(ProductsModelData.fromJson(v));
  });
    this.data = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      final v = this.data;
      final arr0 = [];
  v!.forEach((v) {
  arr0.add(v!.toJson());
  });
      data['data'] = arr0;
    }
    return data;
  }
}
