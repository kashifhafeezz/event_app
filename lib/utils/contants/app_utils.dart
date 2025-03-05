class AppUtils {
  factory AppUtils() => _singleton;

  AppUtils._internal();

  static final AppUtils _singleton = AppUtils._internal();

  List<String> specialityListEn = [
    'Dermatologist',
    'Surgeon',
    'Plastic Surgeon',
    'Other',
  ];

  List<String> specialityListAr = [
    'أخصائي جلدية',
    'جراح',
    'جراح تجميل',
    'أخرى',
  ];

  List<String> countriesEn = [
    'United Arab Emirates',
    'Saudi Arabia',
    'Egypt',
    'India',
    'Spain',
    'United Kingdom',
    'United States',
    'Pakistan',
  ];

  List<String> countriesAr = [
    'الإمارات العربية المتحدة',
    'المملكة العربية السعودية',
    'مصر',
    'الهند',
    'إسبانيا',
    'المملكة المتحدة',
    'الولايات المتحدة',
    'باكستان',
  ];
}
