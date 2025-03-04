import 'package:flutter/material.dart';

class AppColors {
  factory AppColors() => _singleton;
  AppColors._internal();
  static final AppColors _singleton = AppColors._internal();

  Color alert = const Color(0xffF1312A);
}
