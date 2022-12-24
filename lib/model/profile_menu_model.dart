// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ProfileMenuModel {
  IconData leading;
  String text;
  Function() onTap;
  
  ProfileMenuModel({
    required this.leading,
    required this.text,
    required this.onTap,
  });
}
