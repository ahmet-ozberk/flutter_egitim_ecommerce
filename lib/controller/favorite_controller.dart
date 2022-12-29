import 'package:flutter_egitim_ecommerce/services/api_service.dart';
import 'package:flutter_egitim_ecommerce/services/notify.dart';

class FavoriteController {
  static Future<bool?> addFavorite(int id) async {
    bool? result;
    await ApiService.favoriteAdd({"productId": id}).then((value) {
      if (value != null && value == true) {
        result = true;
        Notify.success("Ürün favorilere eklendi");
      } else {
        result = false;
        Notify.unsuccess("Ürün favorilere eklenirken bir hata oluştu");
      }
    }).catchError((e) {
      result = false;
      Notify.unsuccess("Ürün favorilere eklenirken bir hata oluştu");
    });
    return result;
  }

  static Future<bool?> removeFavorite(int id) async {
    bool? result;
    await ApiService.favoriteRemove({"productId": id}).then((value) {
      if (value != null && value == true) {
        result = true;
        Notify.success("Ürün favorilerden kaldırıldı");
      } else {
        result = false;
        Notify.unsuccess("Ürün favorilerden kaldırılırken bir hata oluştu");
      }
    }).catchError((e) {
      result = false;
      Notify.unsuccess("Ürün favorilerden kaldırılırken bir hata oluştu");
    });
    return result;
  }
}
