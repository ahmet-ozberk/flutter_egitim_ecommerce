import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_egitim_ecommerce/model/campaign_model.dart';
import 'package:flutter_egitim_ecommerce/model/login_model.dart';

class ApiService {
  static final dio = Dio();
  static const String baseUrl = "https://e-ticaret-api.onrender.com/";

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
}
