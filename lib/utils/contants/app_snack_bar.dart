import 'package:flutter/material.dart';

class AppSnackBar {
  factory AppSnackBar() => _singleton;

  AppSnackBar._internal();

  static final AppSnackBar _singleton = AppSnackBar._internal();

  void showErrorSnackBar({
    required BuildContext context,
    required String errorMessage,
  }) {
    final snackBar = SnackBar(
      content: Text(
        errorMessage,
        // style: AppTextStyles().smallTextStyle(
        //   context: context,
        //   textColor: AppColors().appWhiteColor,
        // ),
      ),
      // backgroundColor: AppColors().appTerritoryColor,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showSuccessSnackBar({
    required BuildContext context,
    required String successMessage,
  }) {
    final snackBar = SnackBar(
      content: Text(
        successMessage,
        //   style: AppTextStyles().smallTextStyle(
        //     context: context,
        //     textColor: AppColors().appWhiteColor,
        //   ),
      ),
      // backgroundColor: AppColors().appSuccessColor,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
