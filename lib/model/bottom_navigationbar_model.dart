import 'package:flutter/material.dart';

class BottomNavigationbarModel {
  // anasayfa, sepet, favoriler, profil
  int index;
  IconData icon;
  String title;
  Widget body;
  BottomNavigationbarModel({required this.index, required this.icon, required this.title, required this.body});
}
