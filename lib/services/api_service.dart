import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_egitim_ecommerce/model/campaign_model.dart';
import 'package:flutter_egitim_ecommerce/model/categories_model.dart';
import 'package:flutter_egitim_ecommerce/model/login_model.dart';
import 'package:flutter_egitim_ecommerce/model/product_detail_model.dart';
import 'package:flutter_egitim_ecommerce/model/products_model.dart';
import 'package:flutter_egitim_ecommerce/services/storage_servis.dart';

class ApiService {
  static final dio = Dio();
  static const String baseUrl = "https://e-ticaret-api.onrender.com/";

  static Future<Options?> options() async {
    final token = await StorageService.getToken();
    if (token != null) {
      return Options(headers: {"Authorization": "Bearer $token"});
    } else {
      return null;
    }
  }

  static Future<LoginModel?> login(Map<String, dynamic> data) async {
    try {
      final response = await dio.post("${baseUrl}login", data: data);
      log("Data=> ${response.data}", name: "Login");
      if (response.statusCode == 200) {
        return LoginModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<LoginModel?> register(Map<String, dynamic> data) async {
    try {
      final response = await dio.post("${baseUrl}register", data: data);
      log("Data=> ${response.data}", name: "Register");
      if (response.statusCode == 200) {
        return LoginModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<CampaignModel?> campaigns() async {
    try {
      final response = await dio.get("${baseUrl}slider");
      log("Data=> ${response.data}", name: "Campaigns");
      if (response.statusCode == 200) {
        return CampaignModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<CategoriesModel?> categories() async {
    try {
      final response = await dio.get("${baseUrl}categories");
      log("Data=> ${response.data}", name: "Categories");
      if (response.statusCode == 200) {
        return CategoriesModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<ProductsModel?> products(Map<String, dynamic> data) async {
    try {
      final token = await options();
      final response = await dio.post("${baseUrl}productsList", data: data, options: token);
      log("Data=> ${response.data}", name: "Products");
      if (response.statusCode == 200) {
        return ProductsModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<ProductDetailModel?> productDetail(Map<String, dynamic> data) async {
    try {
      final token = await options();
      final response = await dio.post("${baseUrl}productDetail", data: data, options: token);
      log("Data=> ${response.data}", name: "ProductDetail");
      if (response.statusCode == 200) {
        return ProductDetailModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<bool?> favoriteAdd(Map<String, dynamic> data) async {
    try {
      final token = await options();
      final response = await dio.post("${baseUrl}favoriAdd", data: data, options: token);
      log("Data=> ${response.data}", name: "favoriAdd");
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

    static Future<bool?> favoriteRemove(Map<String, dynamic> data) async {
    try {
      final token = await options();
      final response = await dio.post("${baseUrl}favoriRemove", data: data, options: token);
      log("Data=> ${response.data}", name: "favoriRemove");
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
