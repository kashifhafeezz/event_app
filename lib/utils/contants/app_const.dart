class AppConst {
  factory AppConst() => _singleton;

  AppConst._internal();

  static final AppConst _singleton = AppConst._internal();

  double screenHorizontalPadding = 18;
}
